# Scenario 1: Immutable / Append-Only Source

This is the standard and simplest scenario, perfectly handled by the default behavior of Structured Streaming.

spark.readStream.table("mydb.raw_append_only_data")

# skipChangeCommits

Option	Value	Behavior
skipChangeCommits
true	
The streaming job will ignore any updates or deletes that occurred on the source Delta table. It will only process the initial data and subsequent appends (inserts).


skipChangeCommits	
false (Default)	
The streaming job will process all commits to the source table, including changes from MERGE, UPDATE, and DELETE. You must use the Change Data Feed (CDF) and special logic (like APPLY CHANGES INTO or custom merges) to handle these changes downstream.


streaming_df = spark.readStream \
  .format("delta") \
  .option("skipChangeCommits", "true") \
  .table("source_database.some_delta_table")

ETL pipeline

import dlt
from pyspark.sql.functions import *

# CREATE A STREAMING TABLE
@dlt.table(
    name = 'sales_stg'
)
def sales_stg():
    df = spark.readStream.option("skipChangeCommits", "True")\
        .table("databricksansh.silver.sales_enr")
    return df

# CREATE A MAT VIEW
@dlt.table(
    name = 'sales_enr'
)
def sales_trn():
    df = spark.read.table("sales_stg")
    df = df.withColumn("priceAfterDiscount", col("total_amount")-col("discount"))
    return df

# CREATE A MAT VIEW
@dlt.table(
    name = 'sales_cur'
)
def sales_cur():
    df = spark.read.table("sales_enr")
    return df