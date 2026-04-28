# Nearest Neighbor Search Using R-Tree Algorithms

## Project Summary

This project implements and compares three nearest neighbor search algorithms using 2D spatial point data. The goal is to find the nearest facility for each query point using different search strategies and compare their performance.

The project was completed as part of COMP6210 Big Data Assignment 2. The selected dataset for this task is the **Shop dataset**, and the query file contains 200 user locations. Each algorithm finds the nearest shop for every query point and records the nearest shop ID, coordinates, total processing time, and average query time.

## Project Context

Nearest neighbor search is an important spatial data processing task. It is commonly used in location-based services, recommendation systems, navigation apps, facility search, and geographic information systems.

In this project, each query point represents a user location, and the objective is to find the closest shop from the dataset.

The project compares the following methods:

1. Sequential Scan Based Method
2. Branch-and-Bound Algorithm using an R-tree
3. Branch-and-Bound with Divide-and-Conquer

## Dataset Used

This project uses two text files:

```text
shop.txt
query_points.txt
```

## Dataset Description

### shop.txt

The `shop.txt` file contains the selected facility dataset. Each row represents one shop location.

Format:

```text
id x y
```

Example:

```text
1 144.69 56.59
```

Where:

- **id**: Unique shop identifier
- **x**: X-coordinate / longitude-style coordinate
- **y**: Y-coordinate / latitude-style coordinate

### query_points.txt

The `query_points.txt` file contains 200 query locations. Each row represents one user location.

Format:

```text
id x y
```

Example:

```text
1 188.88 26.23
```

Where:

- **id**: Unique query identifier
- **x**: X-coordinate of the query point
- **y**: Y-coordinate of the query point

## Tools and Technologies Used

- **Python**
- **R-tree data structure**
- **Branch-and-Bound search**
- **Divide-and-Conquer strategy**
- **Sequential scan**
- **Euclidean distance**
- **Text file processing**
- **Command-line execution**

## Algorithms Implemented

## 1. Sequential Scan Based Method

File:

```text
task1.1.py
```

### Purpose

The sequential scan method finds the nearest neighbor by calculating the distance from each query point to every shop in the dataset.

### Method

For each query point:

1. Read all shop points from `shop.txt`.
2. Read all query points from `query_points.txt`.
3. For each query point, calculate the squared Euclidean distance to every shop.
4. Keep track of the shop with the smallest distance.
5. Output the nearest shop ID and coordinates.
6. Record total processing time and average processing time per query.

### Distance Formula

The squared Euclidean distance is used:

```text
distance² = (query_x - shop_x)² + (query_y - shop_y)²
```

The square root is not required because comparing squared distances gives the same nearest neighbor result.

### Output File

```text
task1_sequential_output.txt
```

### Performance Result

```text
Queries: 200
Total Time: 6.280074 seconds
Average Time Per Query: 0.031400 seconds
```

### Strengths

- Simple to understand and implement
- Always checks every possible point
- Produces accurate nearest neighbor results

### Limitations

- Slow for large datasets
- Time complexity increases significantly as the number of facilities grows
- Does not use any spatial indexing or pruning

## 2. Branch-and-Bound Algorithm using R-tree

File:

```text
task1.2.py
```

### Purpose

The Branch-and-Bound method improves nearest neighbor search by using an R-tree spatial index. Instead of checking every shop point, the algorithm uses minimum bounding rectangles to prune areas that cannot contain a closer point.

### Method

The algorithm follows these steps:

1. Read shop points from `shop.txt`.
2. Build an R-tree from the shop points.
3. Store points inside leaf nodes.
4. Store minimum bounding rectangles for internal nodes.
5. For each query point, search the R-tree using Branch-and-Bound.
6. Use minimum distance from the query point to each bounding rectangle.
7. Prune branches that cannot contain a closer point.
8. Return the nearest shop for each query.

### R-tree Concept

An R-tree groups nearby points into bounding rectangles. During search, the algorithm can skip entire branches if their bounding rectangle is farther than the current best nearest distance.

### Branch-and-Bound Concept

Branch-and-Bound reduces unnecessary search by:

- Exploring promising branches first
- Maintaining the current best nearest point
- Pruning branches whose minimum possible distance is worse than the current best

### Output File

```text
task1_bab_output.txt
```

### Performance Result

```text
Queries: 200
Total Time: 0.038886 seconds
Average Time Per Query: 0.000194 seconds
```

### Strengths

- Much faster than sequential scan
- Uses spatial indexing
- Avoids checking every shop point
- Efficient for larger spatial datasets

### Limitations

- More complex to implement
- Requires R-tree construction
- Performance depends on tree structure and node capacity

## 3. Branch-and-Bound with Divide-and-Conquer

File:

```text
task1.3.py
```

### Purpose

This method extends the R-tree Branch-and-Bound approach by first dividing the dataset into two spatial subspaces. An R-tree is built for each subspace, and the nearest candidate from each subspace is compared to produce the final result.

### Method

The algorithm follows these steps:

1. Read shop points from `shop.txt`.
2. Divide the dataset into two subspaces.
3. Build one R-tree for each subspace.
4. For each query point, run Branch-and-Bound search on both R-trees.
5. Find the nearest candidate from each subspace.
6. Compare both candidates.
7. Return the overall nearest shop.
8. Record total processing time and average query time.

### Divide-and-Conquer Concept

Divide-and-Conquer breaks the original problem into smaller subproblems. In this case, the shop dataset is split into two spatial partitions, and each partition is searched separately.

### Output File

```text
task1_dc_output.txt
```

### Performance Result

```text
Queries: 200
Total Time: 0.059545 seconds
Average Time Per Query: 0.000298 seconds
```

### Strengths

- Uses spatial partitioning
- Reduces the search space within each R-tree
- Can be useful when datasets are very large
- Maintains accurate nearest neighbor results

### Limitations

- Slightly slower than the single R-tree Branch-and-Bound method in this project
- Requires building and searching two R-trees
- Performance depends on how the dataset is split

## Output Files

This project includes the following output files:

## task1_sequential_output.txt

Generated by:

```text
task1.1.py
```

Contains nearest shop results for each query using the sequential scan method.

## task1_bab_output.txt

Generated by:

```text
task1.2.py
```

Contains nearest shop results for each query using the R-tree Branch-and-Bound method.

## task1_dc_output.txt

Generated by:

```text
task1.3.py
```

Contains nearest shop results for each query using the Branch-and-Bound with Divide-and-Conquer method.

## Sample Output Format

Each output file follows this format:

```text
id=107909, x=189.020000, y=26.160000 for query 1
```

This means that for query point 1, the nearest shop has:

- Shop ID: 107909
- X-coordinate: 189.020000
- Y-coordinate: 26.160000

## Performance Comparison

| Algorithm | Queries | Total Time | Average Time Per Query |
|---|---:|---:|---:|
| Sequential Scan | 200 | 6.280074 seconds | 0.031400 seconds |
| Branch-and-Bound R-tree | 200 | 0.038886 seconds | 0.000194 seconds |
| Branch-and-Bound with Divide-and-Conquer | 200 | 0.059545 seconds | 0.000298 seconds |

## Key Findings

- All three algorithms produced the same nearest neighbor results for the query points.
- Sequential scan was the slowest method because it checks every shop point for every query.
- Branch-and-Bound using an R-tree was the fastest method in this project.
- Branch-and-Bound with Divide-and-Conquer was much faster than sequential scan but slightly slower than the single R-tree method.
- The R-tree improved performance by pruning search areas that could not contain a closer shop.
- Spatial indexing is highly effective for nearest neighbor search on large 2D point datasets.

## Screenshots

This project includes screenshots showing the successful execution of each algorithm.

```text
task1_seq.png
task1_Bab.png
task1_dc.png
```

These screenshots show the command-line output, including the generated output file, number of queries, total runtime, and average query time.

## How to Run the Project

## Step 1: Place all files in the same folder

Make sure the following files are in the same directory:

```text
task1.1.py
task1.2.py
task1.3.py
shop.txt
query_points.txt
```

## Step 2: Run Sequential Scan

```bash
python task1.1.py
```

This creates:

```text
task1_sequential_output.txt
```

## Step 3: Run Branch-and-Bound R-tree

```bash
python task1.2.py
```

This creates:

```text
task1_bab_output.txt
```

## Step 4: Run Branch-and-Bound with Divide-and-Conquer

```bash
python task1.3.py
```

This creates:

```text
task1_dc_output.txt
```

## Recommended GitHub Folder Structure

```text
Nearest Neighbor Search Using R-Tree Algorithms/
│
├── README.md
├── task1.1.py
├── task1.2.py
├── task1.3.py
├── shop.txt
├── query_points.txt
├── task1_sequential_output.txt
├── task1_bab_output.txt
├── task1_dc_output.txt
├── task1_seq.png
├── task1_Bab.png
└── task1_dc.png
```

## Files Included

- `task1.1.py` – Sequential scan nearest neighbor search
- `task1.2.py` – Branch-and-Bound nearest neighbor search using R-tree
- `task1.3.py` – Branch-and-Bound nearest neighbor search with Divide-and-Conquer
- `shop.txt` – Selected facility dataset containing shop coordinates
- `query_points.txt` – Query dataset containing 200 user locations
- `task1_sequential_output.txt` – Output from sequential scan method
- `task1_bab_output.txt` – Output from Branch-and-Bound R-tree method
- `task1_dc_output.txt` – Output from Branch-and-Bound with Divide-and-Conquer method
- `task1_seq.png` – Screenshot of sequential scan execution
- `task1_Bab.png` – Screenshot of Branch-and-Bound execution
- `task1_dc.png` – Screenshot of Divide-and-Conquer execution
- `README.md` – Project documentation

## Skills Demonstrated

- Python programming
- Spatial data processing
- Nearest neighbor search
- Sequential scan implementation
- R-tree construction
- Minimum bounding rectangle logic
- Branch-and-Bound search
- Divide-and-Conquer strategy
- Euclidean distance calculation
- Runtime measurement
- Algorithm performance comparison
- File parsing and text output generation
- Big data algorithm design

## Conclusion

This project demonstrates how different spatial search algorithms perform when solving a nearest neighbor problem. The sequential scan method is simple and accurate but inefficient for large datasets. The Branch-and-Bound R-tree method significantly improves performance by using spatial indexing and pruning. The Divide-and-Conquer version also performs efficiently by splitting the dataset into subspaces and searching each subspace separately.

Overall, the results show that R-tree based methods are much more efficient than sequential scanning for nearest neighbor search on large 2D spatial datasets.
