### Layoff Data Analysis Project

This project showcases a complete data cleaning and analysis pipeline using SQL. It demonstrates proficiency in data manipulation, data integrity, and extracting key business insights from raw data. The entire workflow is documented in a series of structured SQL scripts.

### Project Steps

The project is broken down into three logical phases:

1.  **Data Cleaning:** This phase focuses on preparing the raw data for analysis by addressing common data quality issues.
2.  **Exploratory Data Analysis (EDA):** This phase uses the cleaned data to uncover meaningful insights and patterns.
3.  **Insights and Findings:** A summary of the key discoveries made during the analysis.

---

### Phase 1: Data Cleaning

This is the most critical phase, where raw data is transformed into a clean and reliable dataset.

#### **1. Duplicate Removal**

* **Objective:** To identify and remove any identical rows that could skew the analysis.
* **Methodology:**
    * A staging table (`layoffs_staging`) was created as a replica of the original `layoffs` table to ensure data safety.
    * A Common Table Expression (CTE) was used with the `ROW_NUMBER()` window function. The `PARTITION BY` clause included all columns to identify true duplicates, where `row_num > 1`.
    * A second staging table (`layoffs_staging2`) was created with a `row_num` column, allowing the duplicate rows to be safely deleted without affecting the primary table.

#### **2. Data Standardization**

* **Objective:** To ensure consistency and uniformity in the data, particularly for categorical text fields.
* **Methodology:**
    * The `TRIM()` function was applied to remove leading or trailing white spaces from the `company` column.
    * Variations in `industry` and `country` names were identified using `SELECT DISTINCT`. `UPDATE` statements with `WHERE LIKE` were then used to standardize them (e.g., `Crypto%` to `Crypto`).
    * The `date` column was converted from a text string to a proper `DATE` format using `STR_TO_DATE()` and `ALTER TABLE`.

#### **3. Handling Null and Blank Values**

* **Objective:** To handle missing data points effectively.
* **Methodology:**
    * Missing `industry` values were populated using a **self-join**. This query matched a company with a missing industry to another entry for the same company where the industry was known, then updated the missing value.
    * After the update, all empty strings (`''`) in the `industry` column were converted to `NULL` for consistency.

#### **4. Removing Unnecessary Data**

* **Objective:** To finalize the cleaned dataset by removing irrelevant or un-usable information.
* **Methodology:**
    * Rows with no layoff information (where both `total_laid_off` and `percentage_laid_off` were `NULL`) were deleted.
    * The temporary `row_num` column, created during the duplicate removal step, was dropped from the final table.

---

### Phase 2: Exploratory Data Analysis (EDA)

This phase leverages the cleaned data to extract meaningful insights.

* **Key Metrics:** Queries were performed to identify the maximum number of layoffs and the highest percentage of a workforce laid off.
* **Top Performers Analysis:** The data was grouped by `company`, `industry`, `country`, and `stage` to find the top entities with the most layoffs.
* **Temporal Trends:** Analysis was conducted to understand layoff trends over time, identifying which years had the most significant number of layoffs.

### Conclusion

This project successfully demonstrates a full data cleaning and analysis pipeline. By applying industry best practices—including the use of staging tables, window functions for duplicate detection, and intelligent data imputation with self-joins—the project transforms raw data into a clean, insightful dataset. This work highlights key skills essential for any data-focused role.
