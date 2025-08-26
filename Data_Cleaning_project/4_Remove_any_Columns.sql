-- 4. Remove any Columns

-- We cant populate this data so we will get rid of it
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging2;

-- Get rid of column that are of no use
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;