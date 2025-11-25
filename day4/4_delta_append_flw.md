# Scnerio is--two seperate files in differnt sources --and want to append as single source or table--Delta append flow

memic--
vol1-file1.csv
vol2-file2.csv

if same schema its good and stream will be processed and in case of differnt scema autoloader will automatically handle with new columns

import dlt
from pyspark.sql.functions import *

# ====================================================================
# SCRIPT 1: SAME SCHEMA (Seamless Merge)
# ====================================================================

# 1. CREATE DESTINATION TABLE
dlt.create_streaming_table(
    name = 'raw_data_bronze',
    comment = "Raw data destination with consistent schema from both flows."
)

# 2. FLOW 1: Reads CSV (Assumes columns: id, value, timestamp)
@dlt.append_flow(
    target = 'raw_data_bronze',
    name = 'ingest_csv_flow'
)
def flow_1():
    df = spark.readStream.format(
        "cloudFiles"
    ).option(
        "cloudFiles.format", "csv"
    ).option(
        "cloudFiles.schemaLocation", "/Volumes/first_catalog/bronze/bronze/vol_result"
    ).option(
        "header", "true"
    ).load(
        "/Volumes/first_catalog/bronze/bronze/vol1"
    )
    return df

# 3. FLOW 2: Reads JSON (Assumes same columns: id, value, timestamp)
@dlt.append_flow(
    target = 'raw_data_bronze',
    name = 'ingest_json_flow'
)
def flow_2():
    df = spark.readStream.format(
        "cloudFiles"
    ).option(
        "cloudFiles.format", "json"
    ).option(
        "cloudFiles.schemaLocation", "/Volumes/first_catalog/bronze/bronze/vol_result"
    ).load(
        "/Volumes/first_catalog/bronze/bronze/vol2"
    )
    return df
















    
---not coded
# differnt scehma
import dlt
from pyspark.sql.functions import *

# ====================================================================
# SCRIPT 2: DIFFERENT SCHEMA (Schema Evolution - addNewColumns)
# ====================================================================

# 1. CREATE DESTINATION TABLE (Same as before)
dlt.create_streaming_table(
    name = 'raw_data_bronze',
    comment = "Raw data destination that allows schema evolution."
)

# 2. FLOW 1: Reads initial schema (Columns: A, B, C)
@dlt.append_flow(
    target = 'raw_data_bronze',
    name = 'ingest_initial_schema_flow'
)
def flow_1():
    df = spark.readStream.format("cloudFiles")\
        .option("cloudFiles.format", "csv")\
        .option("cloudFiles.schemaLocation", "/Volumes/databricksansh/bronze_schema/flow1/")\
        .option("header", "true") 
        # Note: No specific schema evolution option needed here, 
        # as this flow sets the initial schema.
        .load("/Volumes/databricksansh/bronze/autovol/flow1/")
    return df

# 3. FLOW 2: Reads the differing schema (Columns: A, B, C, D)
# This flow introduces column D, forcing the schema evolution.
@dlt.append_flow(
    target = 'raw_data_bronze',
    name = 'ingest_new_column_flow'
)
def flow_2():
    df = spark.readStream.format("cloudFiles")\
        .option("cloudFiles.format", "json")\
        .option("cloudFiles.schemaLocation", "/Volumes/databricksansh/bronze_schema/flow2/")\
        # *** KEY OPTION FOR SCHEMA EVOLUTION ***
        # This tells Auto Loader to modify the target table's schema 
        # and add any new columns found in the incoming data.
        .option("cloudFiles.schemaEvolutionMode", "addNewColumns")\ 
        .load("/Volumes/databricksansh/bronze/autovol/flow2/")
    return df