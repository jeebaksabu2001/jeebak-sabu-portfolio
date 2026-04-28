# COMP6210 - Big Data
# Task 1.1 — Nearest Neighbor via Sequential Scan
# Goal: Calculate the distance between a query point to every point
# in the selected dataset to find the nearest neighbor.

import time

# Helpers

def parse_points(path):
    # Reads the text lines as "id x y" and returns a list of dicts, commas are tolerated
    items = []
    with open(path, "r", encoding="utf-8") as f:
        for line in f:
            s = line.strip()
            if not s:
                continue  # skipps blanks
            t = s.replace(",", " ").split()
            if len(t) < 3:
                continue # ignore the malformed rows with < 3
            try:
                items.append({
                    'id': int(float(t[0])), # parse id/x/y and cast id via float to int to tolerate "1.0"
                    'x': float(t[1]),
                    'y': float(t[2])
                })
            except ValueError:
                pass # if the row cannot be parsed we ignore it instead of it failing the whole run
    return items


def dist2(p1, p2):
    # Squared Euclidean Distance between two points (x,y)
    dx = p1['x'] - p2['x']       
    dy = p1['y'] - p2['y']
    return dx*dx + dy*dy        # return squared distance

# Main

def main():
    # Loading the datasets
    facilities = parse_points("shop.txt")
    queries    = parse_points("query_points.txt")

    results = []                # assign (qid, nid, x, y) per query
    t0 = time.perf_counter()    # assign timer to mesuring total execution

    # For every query, scan all facilities linearly and select the best
    for q in queries:
        best_point = None       # current best facility
        best_d2 = float('inf')  # current best squared distance

        for p in facilities:
            d2 = dist2(q, p)
            # Choose the smaller id when distances are equal
            if (d2 < best_d2) or (d2 == best_d2 and (best_point is None or p['id'] < best_point['id'])):
                best_d2 = d2    # new best distance
                best_point = p  # new best facility

        # if no facilities then record None fields
        if best_point is None:
            results.append((q['id'], None, None, None))
        else:
            results.append((q['id'], best_point['id'], best_point['x'], best_point['y'])) 

    total = time.perf_counter() - t0        # Elapsed runtime since the start
    avg = total / max(1, len(queries))      # avg time per query, avoids /0 when there are no queries

    # Output
    out_path = "task1_sequential_output.txt"
    with open(out_path, "w", encoding="utf-8") as f:
        f.write("=== Nearest Neighbor — Sequential Scan ===\n")
        for qid, nid, x, y in results:
            if nid is None:
                f.write(f"id=None, x=None, y=None for query {qid}\n")
            else:
                f.write(f"id={nid}, x={x:.6f}, y={y:.6f} for query {qid}\n")
        f.write("\n")
        f.write(f"Total processing time for {len(queries)} queries: {total:.6f} seconds\n")
        f.write(f"Average time per query: {avg:.6f} seconds\n")

    # Console summary
    print(f"Done = {out_path} | Q={len(queries)} | Total={total:.6f}s | Avg={avg:.6f}s")


if __name__ == "__main__":
    main()
