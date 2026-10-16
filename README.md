# Zomato Restaurant Analytics

An end-to-end data analytics project using **Python, MySQL, and Tableau** to explore restaurant distribution, customer ratings, pricing, cuisine trends, and service availability.

## Project Overview

This project analyzes restaurant data to identify patterns in restaurant distribution, customer ratings, average cost, cuisine popularity, and online delivery and table-booking availability.

The project combines Python-based exploratory data analysis, SQL-driven business analysis, and Tableau dashboarding to transform restaurant data into actionable insights.

## Business Objectives

- Analyze restaurant distribution across cities and markets.
- Identify popular cuisines and compare restaurant ratings.
- Explore the relationship between price ranges and customer ratings.
- Evaluate online delivery and table-booking availability.
- Identify highly rated restaurants using ratings and customer votes.
- Develop a dashboard to communicate key restaurant-market metrics.

## Tools and Technologies

| Tool | Purpose |
|---|---|
| Python | Data exploration, cleaning, and visualization |
| Pandas | Data manipulation and analysis |
| Matplotlib & Seaborn | Exploratory data visualization |
| MySQL | Relational data modeling and analytical queries |
| SQL | Joins, aggregations, CTEs, window functions, and data-quality checks |
| Tableau | Interactive dashboarding and business reporting |
| Jupyter Notebook | Analytical workflow and documentation |

The original SQL script, Jupyter notebook, Tableau workbook, and approved dataset should be added to their corresponding folders after security and data-source checks.

## Database Design

The MySQL database uses a fact-and-dimension structure.

- `fact_restaurant` — restaurant records and associated analytical measures.
- `dim_location` — restaurant location information.
- `dim_cuisine` — cuisine classifications.
- `dim_price` — price-range classifications.
- `dim_rating` — restaurant rating information.

The SQL analysis uses joins across these tables to support restaurant performance reporting.

## Key Analytical Questions

### Restaurant Distribution
- Which cities have the largest number of restaurants?
- How does restaurant availability vary across markets?

### Ratings and Customer Engagement
- What is the average rating among rated restaurants?
- Which restaurants receive the most customer votes?
- Which restaurants rank highly within their respective cities?

### Cuisine Analysis
- Which cuisines are most common?
- How do average ratings vary by cuisine?
- Which cuisine categories have sufficient restaurant counts for meaningful comparison?

### Pricing Analysis
- How does average cost for two vary by price range?
- How do ratings differ across price segments?

### Service Availability
- How many restaurants offer online delivery?
- How many offer table booking?
- How does the availability of these services relate to ratings and customer votes?

## SQL Techniques

The project demonstrates:

- Multi-table joins
- Aggregate functions and `GROUP BY`
- `WHERE` and `HAVING` filters
- Conditional logic using `CASE`
- Common Table Expressions (CTEs)
- Window functions using `RANK()`
- Views for reusable reporting datasets
- Data-quality checks for duplicate IDs, missing names, and invalid numeric values

## Python Analysis

Python is used for exploratory data analysis and visualization.

The analysis examines restaurant distributions, ratings, pricing, cuisine patterns, customer votes, and service availability using Pandas, Matplotlib, and Seaborn.

A reusable data-quality audit script is also included to validate the exported CSV.

## 📊 Tableau Dashboard

The Tableau workbook includes visual analysis of restaurant counts, city-level restaurant distribution, rating patterns, and online delivery availability.

**Dashboard preview:** 


<img width="1501" height="974" alt="Screenshot 2026-10-15 at 10 58 56 PM" src="https://github.com/user-attachments/assets/e7c8ced8-9efa-441a-9d2d-fd1a2ac3791f" />

The Tableau data source should be documented clearly and reconciled with the MySQL reporting data before the final dashboard is published.

## Data Quality and Validation

The project includes checks for:

- Duplicate restaurant IDs
- Missing restaurant names
- Invalid ratings and price ranges
- Negative votes and costs
- Unmatched dimension keys
- Consistency of derived service flags

### Rating treatment

Restaurants with an aggregate rating of `0` are treated as unrated for average-rating calculations. They remain included in total restaurant counts but are excluded from average-rating calculations.

### Currency considerations

The dataset includes multiple country codes and currencies. Average cost comparisons should be restricted to a common market or currency unless a documented currency-conversion method is applied.

## Key Findings

Add verified findings here after reconciling the MySQL, Python, CSV, and Tableau outputs.

- **Restaurant distribution:** Add the leading city and its verified restaurant count.
- **Cuisine performance:** Add a verified cuisine comparison, including the minimum sample-size rule.
- **Pricing and ratings:** Add a verified comparison of average ratings across price ranges.
- **Service availability:** Add the verified share of restaurants offering online delivery or table booking.

Each finding should include the metric, relevant filters, and its business implication.

## How to Reproduce

### MySQL
1. Create or select the `zomato_project` database.
2. Load the source data into the fact and dimension tables.
3. Run the SQL validation checks.
4. Execute the analytical queries and reporting-view definition.
5. Verify key counts and metrics before connecting Tableau.

### Python
1. Install Python and the libraries required by the notebook.
2. Configure database credentials using environment variables or a local configuration file excluded from Git.
3. Run the notebook from top to bottom.
4. Compare its headline metrics against the SQL outputs.

### Tableau
1. Open the workbook in Tableau Desktop.
2. Connect to the documented CSV or MySQL reporting view.
3. Refresh the data source.
4. Validate the headline metrics against the SQL results.
5. Export screenshots of the final dashboard to the `images/` folder.

## Limitations

- The analysis is descriptive and does not establish causal relationships.
- Ratings and customer votes reflect the supplied dataset rather than necessarily representing current restaurant performance.
- Costs across different currencies are not directly comparable without normalization.
- Restaurant rankings depend on the rating, vote-count, and tie-breaking rules used.


## Author
Mahitha Kalinathabotla
