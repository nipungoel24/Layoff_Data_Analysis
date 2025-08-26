Layoff Data Analysis
This project demonstrates a comprehensive data cleaning and exploratory data analysis (EDA) workflow using SQL. It's an excellent portfolio piece for showcasing skills in data manipulation, data integrity, and extracting key insights.

README.md
Project: Layoff Data Analysis with SQL
This project focuses on a complete data cleaning and analysis process using SQL, from handling messy raw data to performing exploratory data analysis to uncover key trends in a dataset of company layoffs. The entire workflow is documented in a series of SQL scripts.

Project Steps
The project is structured into three main phases:

Data Cleaning: This phase involves identifying and correcting issues in the raw data, ensuring it is ready for analysis.

Exploratory Data Analysis (EDA): This phase uses the cleaned data to find insights and patterns.

Insights and Findings: A summary of key discoveries from the analysis.

Step 1: Data Cleaning
This is a multi-step process to ensure the data is accurate and reliable.

1. Remove Duplicates
Objective: To identify and remove any identical rows that could skew the analysis.

Methodology:

First, a new staging table (Layoffs_staging) was created to work with a copy of the original data (layoffs). This is a crucial step to preserve the original raw data.

A Common Table Expression (CTE) was used with the ROW_NUMBER() window function. The PARTITION BY clause grouped all columns to ensure that any row with a row_num greater than 1 was an exact duplicate.

A second staging table (layoffs_staging2) was created with an additional row_num column to store the results of the window function. The duplicate rows (where row_num > 1) were then safely deleted from this table.

2. Standardize the Data
Objective: To ensure consistency in the data, particularly for categorical text fields.

Methodology:

White Space: The TRIM() function was used to remove any leading or trailing white spaces from the company column.

Industry Names: The DISTINCT keyword was used to find variations in the industry column. The UPDATE statement with the LIKE operator was then used to standardize similar values, such as consolidating all Crypto% entries to simply 'Crypto'.

Country Names: The same technique was applied to the country column to standardize values like 'United States.' to 'United States'.

Date Format: The date column was converted from a text string to a proper DATE format using STR_TO_DATE() and ALTER TABLE. This is essential for performing any time-based analysis.

3. Handling Null and Blank Values
Objective: To fill in or remove missing data to improve data quality.

Methodology:

The industry column was checked for NULL or blank ('') values.

A self-join was performed on the layoffs_staging2 table to intelligently populate missing industry values. The query looked for a company with a missing industry and joined it to another instance of the same company with a non-null industry, then updated the value. This technique is more efficient than manual updates.

After cleaning, the blank values were updated to NULL to ensure all missing values are handled consistently.

4. Remove Unnecessary Data
Objective: To finalize the cleaned dataset by removing data that cannot be used for analysis.

Methodology:

Rows where both total_laid_off and percentage_laid_off were NULL were deleted. These rows contain no useful information and were removed to streamline the dataset.

The temporary row_num column, which was created solely for identifying duplicates, was dropped from the table.

Step 2: Exploratory Data Analysis (EDA)
With a clean dataset, the following queries were used to gain initial insights.

Maximum Layoffs: Queries were run to find the maximum number of people laid off and the highest percentage of a company's workforce affected. This provides a quick understanding of the scale of impact.

Top Companies by Layoffs: A query grouped the data by company and summed the total_laid_off to identify which companies had the largest number of layoffs.

Industry and Country Analysis: Similar queries were used to identify which industries and countries were most impacted by layoffs. This helps in understanding sector and geographic trends.

Temporal Analysis: The YEAR() function was used to find the year with the highest number of layoffs, providing a high-level view of the temporal distribution of layoffs.

Stage Analysis: The stage column was used to group data and find which company stages (e.g., Post-IPO, Series B) experienced the most layoffs.

Conclusion
This project demonstrates a complete data cleaning and analysis pipeline using SQL. The methods used, such as creating staging tables, using window functions for duplicate detection, and performing self-joins for data imputation, are all industry best practices. The analysis section shows how these skills can be applied to extract valuable insights from raw data.
