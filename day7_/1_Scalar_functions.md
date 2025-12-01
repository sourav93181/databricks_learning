A scalar function is a user-defined function (UDF) in Databricks SQL that:

✔️ Takes one input value per row
✔️ Returns one output value per row
✔️ Can be reused in SQL queries like a normal built-in function
✔️ Runs on the Databricks SQL engine


# in sql

syntax for creating a function 
CREATE OR REPLACE FUNCTION databrickssansh.bronze.sql_scalar_func(p_par INT)
RETURNS INT
LANGUAGE SQL
RETURN p_par * 10;

use this way
%sql
SELECT 
  total_amount,
  databrickssansh.bronze.sql_scalar_func(total_amount)
FROM databrickssansh.silver.sales_engr;


# function that return tables
CREATE OR REPLACE FUNCTION split_csv(str STRING)
RETURNS TABLE (value STRING)
RETURN
  SELECT trim(col) AS value
  FROM explode(split(str, ',')) AS t(col);

  SELECT value FROM split_csv('a,b,c'); 