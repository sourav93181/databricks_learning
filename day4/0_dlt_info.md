

# DELTA LIVE TABLES

Delta Live Tables is a declarative framework in Databricks that lets you build reliable, automated data pipelines using SQL or Python.

features:

data ingestion
data transformation
pipeline managment
quality checks
incremental processing

Component	Persisted Data?	Best Use Case

Streaming Table            Yes    Ingesting raw data (Bronze layer); incremental loads.
Materialized View           Yes     Cleaning, Aggregating, and Reporting (Silver/Gold layers).
Temporary View               No     Intermediate logic; breaking complex queries into steps.


ETL piplines 

whatever databricks build folder structure --always change anything through editor not from outside space