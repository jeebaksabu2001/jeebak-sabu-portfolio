# 🌐 Director Network Centrality and Board Influence Analysis

## 📌 Project Summary

This project analyses a company director network dataset extracted from DEF 14A filings of U.S. companies. The analysis is based on a venture capital scenario where a VC fund wants to identify influential board members who may help connect an invested company with potential acquiring firms.

The project uses network analysis techniques to identify important directors, improve existing notebook code, explore unused features, improve visualisations, and consider ethical issues in using public director data.

## 🎯 Project Objectives

- Build a company-director network from board membership data.
- Identify influential directors using centrality measures.
- Analyse directors who act as bridges between company clusters.
- Improve code readability, robustness, and visual presentation.
- Explore how director roles can add context to network influence.
- Discuss ethical considerations when using public director data.

## 📊 Dataset Used

This project uses two datasets:

- `company_directorships.csv`
- `director-details.csv`

The data is based on DEF 14A filings and includes information about company directors, board memberships, roles, compensation, and related details.

## 🧾 Dataset Columns

### company_directorships.csv

| Column | Description |
|---|---|
| `company_name` | Name of the company where the director serves |
| `cikcode` | SEC Central Index Key used to identify companies |
| `director_name` | Name of the company director |
| `software_background` | Indicates whether the director has a software or technology background |
| `start_date` | Date when the director started serving on the board |
| `end_date` | Date when the director ended board service |

### director-details.csv

| Column | Description |
|---|---|
| `id` | Unique identifier for each director record |
| `url` | Source URL from the SEC filing |
| `name` | Name of the director |
| `age` | Age of the director |
| `role` | Director role or title |
| `compensation` | Annual compensation recorded for the director |
| `source_excerpt` | Text excerpt supporting the director details |
| `created_at` | Timestamp showing when the record was created |
| `gender` | Gender of the director, where available |

## 🛠️ Tools and Technologies Used

- **Python**
- **Pandas** – Data loading, cleaning, merging, and transformation
- **NumPy** – Numerical operations
- **NetworkX** – Network construction and centrality analysis
- **Matplotlib** – Data visualisation
- **Seaborn** – Statistical visualisation
- **Scikit-learn** – Clustering and preprocessing
- **Jupyter Notebook**

## 📈 Analysis Performed

### 1. Network Construction

A board network was created using relationships between companies and directors.

In this network:

- Companies are connected to directors who serve on their boards.
- Directors with multiple board roles connect different companies.
- Highly connected directors may support strategic introductions or acquisition discussions.

### 2. Centrality Analysis

The project uses centrality measures to identify influential directors.

| Measure | Purpose |
|---|---|
| Degree Centrality | Identifies directors with many direct board connections |
| Eigenvector Centrality | Identifies directors connected to other influential directors or companies |
| Betweenness Centrality | Identifies directors who act as bridges between company clusters |

### 3. Code Improvements

The notebook was improved by:

- Using named aggregation for cleaner demographic summaries.
- Improving board count distribution visualisation.
- Validating and cleaning clustering inputs.
- Improving the age vs compensation scatter plot.
- Making outputs clearer for non-technical users.

### 4. Role Feature Exploration

The `role` feature was identified as an important field for adding context to director influence.

Examples of roles include:

- Chair
- Independent Director
- Executive Director
- Chief Executive Officer
- Board committee member

This feature can help compare whether certain director roles are associated with stronger network influence.

### 5. Visualisation Improvements

The project improved visualisations for better stakeholder communication.

Visualisations included:

- Director counts by credibility tier
- Age distribution of company directors
- Impact by director role
- Top 10 directors by brokerage power

### 6. Ethical Considerations

The project also considers responsible use of public director data.

Key ethical issues include:

- Privacy and consent
- Transparency in outreach
- Bias toward already powerful directors
- Fairness in interpreting director influence
- Responsible use of network insights

## 🔍 Key Findings

- Degree centrality helps identify directors with many direct board connections.
- Eigenvector centrality helps identify directors connected to influential companies or directors.
- Betweenness centrality is useful for finding directors who bridge separate company clusters.
- The `role` field adds important context to director influence.
- Improved visualisations make the analysis easier for non-technical stakeholders to understand.
- Ethical use of director data is important when the goal is strategic corporate outreach.

## 💡 Business Recommendations

- Use centrality scores to shortlist influential directors.
- Prioritise directors with high betweenness centrality because they can connect separate company groups.
- Consider director role when interpreting influence and outreach value.
- Use clear visual summaries when presenting findings to non-technical stakeholders.
- Apply ethical safeguards when using public director data for strategic outreach.

## 🧠 Skills Demonstrated

- Network analysis
- Graph construction
- Degree centrality analysis
- Eigenvector centrality analysis
- Betweenness centrality analysis
- Data cleaning and preprocessing
- Code repair and notebook improvement
- Feature exploration
- Data visualisation
- Clustering input validation
- Business interpretation of network metrics
- Ethical analysis of data science use

## ✅ Conclusion

This project demonstrates how network analysis can be used to identify influential company directors in a corporate board network. By applying centrality measures, improving visualisations, exploring director roles, and considering ethical risks, the project converts public filing data into useful insights for a venture capital acquisition strategy.

Overall, the analysis shows that influential directors are not only those with many direct connections, but also those connected to powerful boards or positioned as bridges between separate company clusters.
