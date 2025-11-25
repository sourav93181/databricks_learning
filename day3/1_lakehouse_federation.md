# Lakehouse Federation

Lakehouse Federation in Databricks is a powerful feature that allows you to query external data sources without moving the data into your Databricks Lakehouse. This means you can run SQL queries on data stored in external systems like MySQL, PostgreSQL, Azure SQL DB, Snowflake, and more — directly from Databricks

so it actually reduce migration to come and sit in default location to query it



# Lakehouse Federation

You define read-only connections to external databases.

These connections are registered as catalogs in Unity Catalog.--called as foriegn catalog

The actual data stays in the external system — only the results are returned to Databricks.