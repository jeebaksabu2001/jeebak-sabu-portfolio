# 📍 Nearest Neighbor Search Using R-Tree Algorithms

## 📌 Project Summary

This project implements and compares three nearest neighbor search algorithms using 2D spatial point data. The goal is to find the nearest shop for each query point and compare the performance of different search strategies.

The project uses the Shop dataset and 200 query points. Each algorithm returns the nearest shop ID, coordinates, total processing time, and average query time.

## 🎯 Project Objectives

- Find the nearest shop for each query point.
- Implement a basic Sequential Scan method.
- Implement Branch-and-Bound search using an R-tree.
- Implement Branch-and-Bound with Divide-and-Conquer.
- Compare the accuracy and runtime of all three methods.

## 📊 Dataset Used

This project uses two text files:

- `shop.txt` – Contains shop/facility coordinates.
- `query_points.txt` – Contains 200 user query locations.

Each file follows this format:

id x y

Example:

1 144.69 56.59

## 🧾 Dataset Fields

| Field | Description |
|---|---|
| `id` | Unique identifier for the shop or query point |
| `x` | X-coordinate / longitude-style coordinate |
| `y` | Y-coordinate / latitude-style coordinate |

## 🛠️ Tools and Technologies Used

- **Python**
- **R-tree data structure**
- **Branch-and-Bound search**
- **Divide-and-Conquer strategy**
- **Sequential scan**
- **Euclidean distance**
- **Text file processing**
- **Command-line execution**

## 📈 Algorithms Implemented

### 1. Sequential Scan

File: `task1.1.py`

The sequential scan method calculates the distance between each query point and every shop in the dataset. The shop with the smallest distance is selected as the nearest neighbor.

This method is simple and accurate, but it is slow for large datasets because every shop must be checked for every query.

Output file: `task1_sequential_output.txt`

### 2. Branch-and-Bound using R-tree

File: `task1.2.py`

This method builds an R-tree spatial index for the shop dataset. The Branch-and-Bound algorithm uses minimum bounding rectangles to avoid searching areas that cannot contain a closer shop.

This method is much faster than sequential scan because it prunes unnecessary search paths.

Output file: `task1_bab_output.txt`

### 3. Branch-and-Bound with Divide-and-Conquer

File: `task1.3.py`

This method first splits the shop dataset into two spatial subspaces. An R-tree is then built for each subspace. For each query, the nearest candidate from both subspaces is found and compared to determine the final nearest shop.

This approach is faster than sequential scan, but slightly slower than the single R-tree method in this project.

Output file: `task1_dc_output.txt`

## 📐 Distance Calculation

The project uses squared Euclidean distance:

distance² = (query_x - shop_x)² + (query_y - shop_y)²

The square root is not required because comparing squared distances gives the same nearest neighbor result.

## 📊 Performance Comparison

| Algorithm | Queries | Total Time | Average Time Per Query |
|---|---:|---:|---:|
| Sequential Scan | 200 | 6.280074 seconds | 0.031400 seconds |
| Branch-and-Bound R-tree | 200 | 0.038886 seconds | 0.000194 seconds |
| Branch-and-Bound with Divide-and-Conquer | 200 | 0.059545 seconds | 0.000298 seconds |

## 🔍 Key Findings

- All three algorithms produced the same nearest neighbor results.
- Sequential Scan was the slowest method because it checks every shop point.
- Branch-and-Bound using an R-tree was the fastest method.
- Divide-and-Conquer was much faster than Sequential Scan but slightly slower than the single R-tree method.
- R-tree indexing improved performance by pruning search areas that could not contain a closer shop.
- Spatial indexing is highly effective for nearest neighbor search on large 2D datasets.

## 🖼️ Screenshots

This project includes screenshots showing successful execution of each algorithm:

- `task1_seq.png`
- `task1_Bab.png`
- `task1_dc.png`

## 🧠 Skills Demonstrated

- Python programming
- Spatial data processing
- Nearest neighbor search
- Sequential Scan implementation
- R-tree construction
- Minimum bounding rectangle logic
- Branch-and-Bound search
- Divide-and-Conquer strategy
- Euclidean distance calculation
- Runtime measurement
- Algorithm performance comparison
- File parsing and text output generation

## ✅ Conclusion

This project demonstrates how different spatial search algorithms perform when solving a nearest neighbor problem.

The Sequential Scan method is simple and accurate but inefficient for large datasets. The Branch-and-Bound R-tree method significantly improves performance by using spatial indexing and pruning. The Divide-and-Conquer version also performs efficiently but was slightly slower than the single R-tree method in this project.

Overall, the results show that R-tree based methods are much more efficient than sequential scanning for nearest neighbor search on large 2D spatial datasets.
