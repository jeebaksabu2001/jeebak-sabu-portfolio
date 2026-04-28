# Director Network Centrality and Board Influence Analysis

## Project Summary

This project analyses a real company director network dataset extracted from DEF 14A filings of U.S. companies. The project is based on a venture capital scenario where a VC fund wants to identify influential board members who may help connect an invested company with large U.S.-listed companies for a potential acquisition.

The analysis uses network science techniques to identify important directors and companies within a board membership network. The project focuses on centrality analysis, code improvement, unused feature exploration, improved visualisations, and ethical considerations.

## Business Problem

The venture capital fund has invested in a company and now wants to speed up its exit through acquisition. To support this goal, the fund needs to identify directors who are well-connected across company boards and may be able to introduce the company to potential acquiring firms.

This project helps answer the following questions:

- Which directors are the most influential in the board network?
- Which directors have the widest access to company boards?
- Which directors are connected to other influential directors or companies?
- Which directors act as bridges between different company clusters?
- How can the existing notebook be improved for readability, robustness, and presentation?
- What ethical issues should be considered when using director network data?

## Dataset Used

This project uses two CSV files:

1. `company_directorships.csv`
2. `director-details.csv`

The data comes from real DEF 14A filings from U.S. companies. These filings contain information about company directors, the boards they serve on, director age, roles, compensation, and other related details.

## Dataset 1: company_directorships.csv

This dataset maps company directors to the boards they serve on.

### Key Columns

- **company_name**: Name of the company where the director serves on the board.

- **cikcode**: Central Index Key code assigned by the U.S. Securities and Exchange Commission. This uniquely identifies companies in SEC filings.

- **director_name**: Name of the company director.

- **software_background**: Indicates whether the director has a software or technology-related background.

- **start_date**: Date when the director started serving on the company board.

- **end_date**: Date when the director ended their board service.

## Dataset 2: director-details.csv

This dataset contains demographic, role, and compensation details for directors.

### Key Columns

- **id**: Unique identifier for each director record.

- **url**: Source URL from the SEC filing where the director information was extracted.

- **name**: Name of the director.

- **age**: Age of the director.

- **role**: Director role or title, such as Chair, Independent Director, Executive Director, CEO, or board committee role.

- **compensation**: Annual compensation recorded for the director.

- **source_excerpt**: Text excerpt from the filing that provides evidence for the director details.

- **created_at**: Timestamp showing when the record was created or extracted.

- **gender**: Gender of the director, where available.

## Tools and Technologies Used

- **Python**
- **Pandas** – Data loading, cleaning, merging, and transformation
- **NumPy** – Numerical operations
- **NetworkX** – Network graph creation and centrality analysis
- **Matplotlib** – Data visualisation
- **Seaborn** – Statistical visualisation
- **Scikit-learn** – Clustering and preprocessing
- **Jupyter Notebook** – Code development and analysis documentation

## Analysis Performed

## 1. Network Construction

A board network was created using the relationship between companies and directors.

In this network:

- Companies are connected to directors who serve on their boards.
- Directors with multiple board positions can connect different companies.
- Highly connected directors may be useful for introductions, acquisition discussions, or strategic networking.

This network structure helps identify directors who may provide access to important company ecosystems.

## 2. Centrality Analysis

The project uses centrality measures to identify influential directors and companies within the network.

### Degree Centrality

Degree centrality identifies directors or companies with many direct connections.

In this project, a director with high degree centrality serves on multiple company boards. This means they may have broad access to different companies and can provide many possible introductions.

A director with low degree centrality has fewer direct board connections. They may still be valuable, but their network reach is more limited.

### Eigenvector Centrality

Eigenvector centrality identifies directors who are connected to other influential companies or directors.

In this project, a director with high eigenvector centrality is connected to important boards or well-connected people. These directors may provide credibility because their connections are also influential.

A director with low eigenvector centrality may be connected to less central parts of the network.

### Betweenness Centrality

Betweenness centrality was added as an additional centrality measure.

This measure identifies directors who act as bridges between different board clusters. In the VC scenario, this is valuable because directors with high betweenness centrality may help connect the company to otherwise separate corporate networks.

A director with high betweenness centrality can act as a broker between different company groups, industries, or board communities.

## 3. Code Repairs and Improvements

The original notebook was improved in four key areas.

### 1. Named Aggregation for Demographics

The original code performed repeated operations when summarising director demographic information. The improved version used named aggregation to make the code cleaner, faster, and easier to understand.

Benefits:

- Reduces repeated code
- Improves performance
- Preserves director records more clearly
- Makes the code easier to maintain

### 2. Improved Board Count Distribution Plot

The board count distribution visualisation was improved by adding clearer labels, a title, better formatting, and readability enhancements.

Benefits:

- Makes the heavy-tailed distribution easier to understand
- Shows that most directors serve on a small number of boards
- Highlights that a small number of directors hold many board positions
- Makes the chart more suitable for a non-technical audience

### 3. Validation and Cleaning for Clustering Inputs

The clustering input data was checked and cleaned before applying scaling and clustering methods.

Benefits:

- Prevents missing values from causing model errors
- Improves notebook robustness
- Makes it clearer which records require attention
- Supports more reliable clustering results

### 4. Improved Age vs Compensation Scatter Plot

The age and compensation scatter plot was improved with clearer axis labels, a title, improved formatting, and a colour legend.

Benefits:

- Makes outliers easier to identify
- Improves interpretation of clusters
- Makes the visualisation more presentation-ready
- Helps non-technical stakeholders understand the relationship between age, compensation, and director groups

## 4. Unused Feature Exploration

The `role` feature was identified as an important feature that was not fully used in the original analysis.

The role field provides useful qualitative information about each director’s board position. Examples include:

- Chair
- Independent Director
- Executive Director
- Chief Executive Officer
- Board committee member

Using this feature can help understand whether certain types of roles are associated with stronger network influence.

For example:

- Chairs may have stronger credibility and access to senior decision-makers.
- Independent Directors may act as bridges between different board networks.
- Executive Directors may have deeper company-specific influence.

This feature could be used in future analysis by grouping directors by role, comparing centrality scores by role, or including role as a feature in clustering models.

## 5. Visualisation Improvements

The project also focused on improving visualisations for a non-technical audience.

The improved visualisations included:

- Director counts by credibility tier
- Age distribution of company directors
- Impact by director role
- Top 10 directors by brokerage power

These visualisations help translate technical network metrics into business-friendly insights that can be used by VC partners, investment teams, and non-technical stakeholders.

## 6. Ethical Considerations

The project also considers ethical issues related to using public director and company data for strategic outreach.

Important ethical considerations include:

### Privacy and Consent

Although DEF 14A filings are public, the data still relates to real people. The analysis should avoid misusing personal details or presenting directors unfairly.

### Transparency

If the VC fund contacts directors based on the analysis, it should be transparent about why they are being contacted and how their public information was used.

### Bias and Power Imbalance

Network analysis may favour already powerful directors who hold many board seats. This can reinforce existing corporate hierarchies and overlook emerging or less connected directors.

### Fairness

Directors should not be reduced only to their network value. Any outreach should respect their professional responsibilities and shareholder duties.

### Responsible Use

The analysis should support ethical business decision-making, not manipulation or inappropriate pressure on directors.

## Key Findings

- Degree centrality helps identify directors with many direct board connections.
- Eigenvector centrality helps identify directors connected to influential companies or directors.
- Betweenness centrality is especially useful for identifying directors who bridge different board clusters.
- The `role` feature adds important context to director influence.
- Improved visualisations make the analysis more suitable for non-technical stakeholders.
- Ethical use of public director data is essential, especially when the goal is strategic corporate outreach.

## Business Recommendations

Based on the analysis, the VC fund should:

1. **Use centrality scores to shortlist directors**
   - Start with directors who have high degree, eigenvector, and betweenness centrality.

2. **Prioritise bridge directors**
   - Directors with high betweenness centrality may be especially valuable because they connect otherwise separate company clusters.

3. **Consider director role**
   - Chairs, Independent Directors, and Executive Directors may offer different types of influence and should be approached differently.

4. **Use visualisations for stakeholder communication**
   - Non-technical decision-makers should be shown simple visual summaries rather than complex network outputs only.

5. **Apply ethical safeguards**
   - Outreach should be transparent, respectful, and based only on appropriate use of public information.

## Files Included

- `directors-network.ipynb` – Jupyter Notebook containing the network analysis and code improvements
- `company_directorships.csv` – Dataset linking directors to company boards
- `director-details.csv` – Dataset containing director demographic, role, and compensation details
- `48085847_assignment3_jeebak.docx` – Written explanation of modifications, rationale, and analytical decisions
- `README.md` – Project documentation

## Skills Demonstrated

- Network analysis
- Graph construction using company-director relationships
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
- Strategic recommendation development

## Conclusion

This project demonstrates how network analysis can be used to identify influential company directors in a corporate board network. By applying centrality measures, improving the original notebook, exploring unused features, improving visualisations, and considering ethical risks, the project converts raw SEC filing data into practical insights for a venture capital acquisition strategy.

The analysis shows that influential directors are not only those with many direct connections, but also those connected to powerful boards or positioned as bridges between separate company clusters. These insights can support more strategic, responsible, and data-driven decision-making.
