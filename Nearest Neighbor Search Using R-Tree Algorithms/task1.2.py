# COMP6210 - Big Data
# Task 1.2 — Nearest Neighbor via Branch-and-Bound (BaB)
# Goal:  Construct an R-tree for the selected dataset. Then, apply the BaB
#        algorithm using the R-tree to find the nearest neighbor for each query point.

import sys
import math
import time

# Helpers

def parse_points(path):
    # Reads the text lines as "id x y" and returns a list of dicts
    items = []
    with open(path, "r", encoding="utf-8") as f:
        for line in f:
            s = line.strip()
            if not s:
                continue  # skipps blanks
            t = s.replace(",", " ").split()
            if len(t) < 3:
                continue  # ignore the malformed rows with < 3
            try:
                items.append({'id': int(float(t[0])), 'x': float(t[1]), 'y': float(t[2])})
            except ValueError:
                pass # if the row cannot be parsed we ignore it instead of it failing the whole run
    return items

def dist2(p1, p2):
    # Squared Euclidean Distance between two points (x,y)
    dx = p1['x'] - p2['x']
    dy = p1['y'] - p2['y']
    return dx*dx + dy*dy        # return squared distance

def mindist2_point_mbr(point, mbr):
    # Lower bound of min squared distance from point to axis-aligned rectangle (0 if inside)
    dx = 0.0
    if point['x'] < mbr['x1']:
        dx = mbr['x1'] - point['x']
    elif point['x'] > mbr['x2']:
        dx = point['x'] - mbr['x2']
    dy = 0.0
    if point['y'] < mbr['y1']:
        dy = mbr['y1'] - point['y']
    elif point['y'] > mbr['y2']:
        dy = point['y'] - mbr['y2']
    return dx*dx + dy*dy

# R-tree 
B = 128  # Node capacity 

class Node(object):
    def __init__(self):
        # Whether child_nodes is empty determines whether it is an internal or leaf node
        self.child_nodes = []   # list[Node] if internal
        self.data_points = []   # list[dict{id,x,y}] if leaf
        self.parent = None
        self.MBR = {'x1': float('inf'), 'y1': float('inf'),     # Start with infinities so updates are easy
                    'x2': float('-inf'), 'y2': float('-inf')}

    def is_root(self): return self.parent is None
    def is_leaf(self): return len(self.child_nodes) == 0

    def perimeter(self):
        # Return the node's half perimeter of its MBR
        if self.MBR['x1'] == float('inf'):  # empty
            return 0.0
        return (self.MBR['x2'] - self.MBR['x1']) + (self.MBR['y2'] - self.MBR['y1'])

    def is_overflow(self):
        return (len(self.data_points) > B) if self.is_leaf() else (len(self.child_nodes) > B)       # Checking capacity overflow depending on node type

class RTree(object):
    def __init__(self):
        self.root = Node()  # start as an empty leaf

    def insert(self, u, p):
        # Inserting the point p into the subtree rooted at node u
        if u.is_leaf():
            self.add_data_point(u, p)
            if u.is_overflow():
                self.handle_overflow(u)
        else:
            v = self.choose_subtree(u, p)
            self.insert(v, p)        
            self.update_mbr(v)         

    def choose_subtree(self, u, p):
        # Picking the child whose MBR perimeter increases the least if p were to be inserted
        if u.is_leaf():
            return u
        min_inc = sys.maxsize
        best_child = None
        for child in u.child_nodes:
            inc = self.peri_increase(child, p)
            if inc < min_inc:
                min_inc = inc
                best_child = child
        return best_child

    def peri_increase(self, node, p):
        # Compute (new half-perimeter - old half-perimeter) if p were inserted into node
        x1, x2 = node.MBR['x1'], node.MBR['x2']
        y1, y2 = node.MBR['y1'], node.MBR['y2']
        if x1 == float('inf'):  # empty MBR case
            nx1 = nx2 = p['x']; ny1 = ny2 = p['y']
        else:
            nx1 = min(x1, p['x']); nx2 = max(x2, p['x'])
            ny1 = min(y1, p['y']); ny2 = max(y2, p['y'])
        return (nx2 - nx1 + ny2 - ny1) - node.perimeter()

    def handle_overflow(self, u):
        # Spliting an overflowing node and then connect results to parent or make a new root
        s1, s2 = self.split(u)
        if u.is_root():
            new_root = Node()
            self.add_child(new_root, s1)
            self.add_child(new_root, s2)
            self.root = new_root
            self.update_mbr(new_root)
        else:
            w = u.parent
            # replace u with s1, s2 under parent
            w.child_nodes.remove(u)
            self.add_child(w, s1)
            self.add_child(w, s2)
            if w.is_overflow():
                self.handle_overflow(w)
            else:
                self.update_mbr(w)

    def split(self, u):
        # 40–60 splits, choose minimal total perimeter
        best_s1 = Node()
        best_s2 = Node()
        best_peri = float('inf')

        if u.is_leaf():
            items = u.data_points
            m = len(items)
            lo = max(1, min(math.ceil(0.4 * B), m - 1))
            hi = m - lo
            divides = [
                sorted(items, key=lambda dp: dp['x']),
                sorted(items, key=lambda dp: dp['y']),
            ]
            for div in divides:
                for i in range(lo, hi + 1):
                    s1 = Node(); s1.data_points = div[:i];  self.update_mbr(s1)
                    s2 = Node(); s2.data_points = div[i:];  self.update_mbr(s2)
                    tot = s1.perimeter() + s2.perimeter()
                    if tot < best_peri:
                        best_peri = tot; best_s1 = s1; best_s2 = s2
        else:
            kids = u.child_nodes
            m = len(kids)
            lo = max(1, min(math.ceil(0.4 * B), m - 1))
            hi = m - lo
            divides = [
                sorted(kids, key=lambda c: c.MBR['x1']),
                sorted(kids, key=lambda c: c.MBR['x2']),
                sorted(kids, key=lambda c: c.MBR['y1']),
                sorted(kids, key=lambda c: c.MBR['y2']),
            ]
            for div in divides:
                for i in range(lo, hi + 1):
                    s1 = Node(); s1.child_nodes = div[:i]; self.update_mbr(s1)
                    s2 = Node(); s2.child_nodes = div[i:]; self.update_mbr(s2)
                    tot = s1.perimeter() + s2.perimeter()
                    if tot < best_peri:
                        best_peri = tot; best_s1 = s1; best_s2 = s2
            # re-parent the selected children
            for c in best_s1.child_nodes: c.parent = best_s1
            for c in best_s2.child_nodes: c.parent = best_s2

        return best_s1, best_s2

    def add_child(self, node, child):
        # Linking child under node and expand node's MBR incrementally
        node.child_nodes.append(child)
        child.parent = node
        if child.MBR['x1'] < node.MBR['x1']: node.MBR['x1'] = child.MBR['x1']
        if child.MBR['x2'] > node.MBR['x2']: node.MBR['x2'] = child.MBR['x2']
        if child.MBR['y1'] < node.MBR['y1']: node.MBR['y1'] = child.MBR['y1']
        if child.MBR['y2'] > node.MBR['y2']: node.MBR['y2'] = child.MBR['y2']

    def add_data_point(self, node, data_point):
        # Inserting a point into a leaf and then expanding the leaf's MBR incrementally
        node.data_points.append(data_point)
        if data_point['x'] < node.MBR['x1']: node.MBR['x1'] = data_point['x']
        if data_point['x'] > node.MBR['x2']: node.MBR['x2'] = data_point['x']
        if data_point['y'] < node.MBR['y1']: node.MBR['y1'] = data_point['y']
        if data_point['y'] > node.MBR['y2']: node.MBR['y2'] = data_point['y']

    def update_mbr(self, node):
        # Recomputing a node's MBR from scratch 
        if node.is_leaf():
            if not node.data_points:
                node.MBR = {'x1': float('inf'), 'y1': float('inf'),
                            'x2': float('-inf'), 'y2': float('-inf')}
                return
            xs = [p['x'] for p in node.data_points]
            ys = [p['y'] for p in node.data_points]
        else:
            if not node.child_nodes:
                node.MBR = {'x1': float('inf'), 'y1': float('inf'),
                            'x2': float('-inf'), 'y2': float('-inf')}
                return
            xs = [c.MBR['x1'] for c in node.child_nodes] + [c.MBR['x2'] for c in node.child_nodes]
            ys = [c.MBR['y1'] for c in node.child_nodes] + [c.MBR['y2'] for c in node.child_nodes]
        node.MBR = {'x1': min(xs), 'y1': min(ys), 'x2': max(xs), 'y2': max(ys)}

    # BaB nearest neighbor 
    def nearest_neighbor(self, query_point):
        # Return the nearest facility dict to the query_point using DFS with pruning
        if self.root is None:
            return None
        best_point = None
        best_d2 = float('inf')
        stack = [self.root]

        while stack:
            u = stack.pop()
            # Prune whole subtree if its lower bound exceeds current best
            if mindist2_point_mbr(query_point, u.MBR) > best_d2:
                continue

            if not u.is_leaf():
                # Explore children in order of increasing bound
                scored = [(mindist2_point_mbr(query_point, c.MBR), c) for c in u.child_nodes]
                scored.sort(key=lambda t: t[0])
                for _, c in reversed(scored):
                    stack.append(c)
            else:
                # Check all points in this leaf
                for pt in u.data_points:
                    d2 = dist2(query_point, pt)
                    # if tied select the smaller facility id
                    if (d2 < best_d2) or (d2 == best_d2 and (best_point is None or pt['id'] < best_point['id'])):
                        best_d2 = d2
                        best_point = pt

        return best_point

# Main 

def main():
    # Load datasets
    facilities = parse_points("shop.txt")
    queries    = parse_points("query_points.txt")

    # Build R-tree 
    rtree = RTree()
    for p in facilities:
        rtree.insert(rtree.root, p)

    # Run BaB NN over queries
    results = []
    t0 = time.perf_counter()  # Start the timer just before processing queries
    for q in queries:
        nn = rtree.nearest_neighbor(q)
        results.append((q['id'], nn))
    total = time.perf_counter() - t0  # Stop the timer
    avg = total / max(1, len(queries))  # average per-query time 

    # Output
    out_path = "task1_bab_output.txt"
    with open(out_path, "w", encoding="utf-8") as f:
        f.write("=== Nearest Neighbor — BaB ===\n")
        for qid, nn in results:
            if nn is None:
                f.write(f"id=None, x=None, y=None for query {qid}\n")
            else:
                f.write(f"id={nn['id']}, x={nn['x']:.6f}, y={nn['y']:.6f} for query {qid}\n")
        f.write("\n")
        f.write(f"Total processing time for {len(queries)} queries: {total:.6f} seconds\n")
        f.write(f"Average time per query: {avg:.6f} seconds\n")

    print(f"Done = {out_path} | Q={len(queries)} | Total={total:.6f}s | Avg={avg:.6f}s")

if __name__ == "__main__":
    main()
