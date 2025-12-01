import dlt
from pyspark.sql.functions import *

@dlt.table(
    name="bronze_dignosis",
    comment="Raw patient data from volume"
)
def load_patient():
    return (
        spark.readStream.format("cloudFiles")
        .option("cloudFiles.format", "csv")
        .load("/Volumes/e2e_first_scd1_project/heathcare_core_dev_01/source_map_data")
        .withColumn("ingest_time", current_timestamp())
    )



@dlt.table(
    name="bronze_patient",
    comment="Raw patient data from volume"
)
def load_patient():
    return (
        spark.readStream.format("cloudFiles")
        .option("cloudFiles.format", "csv")
        .load("/Volumes/e2e_first_scd1_project/heathcare_core_dev_01/source_patients")
        .withColumn("ingest_time", current_timestamp())
    )


@dlt.table(
    name="patient_dig_silver",
    comment="Enriched patient records with diagnostic descriptions."
)
def patient_enriched():
    # Read streaming bronze/silver table
    patients = dlt.read_stream("bronze_patient")

    # Read mapping table (batch or streaming)
    diagnosis_map = dlt.read("bronze_dignosis")

    # Perform left join
    enriched_df = (
        patients.alias("p")
        .join(
            diagnosis_map.alias("m"),
            col("p.diagnosis_code") == col("m.diagnosis_code"),
            "left"
        )
        .select(
            col("p.patient_id"),
            col("p.name"),
            col("p.age"),
            col("p.gender"),
            col("p.address"),
            col("p.contact_number"),
            col("p.admission_date"),
            col("m.diagnosis_description"),
            current_timestamp().alias("dlt_ingest_time")
        )
    )

    return enriched_df


dlt.create_streaming_table("patient_dig_silver_main")

dlt.create_auto_cdc_flow(
    target="patient_dig_silver_main",
    source="patient_dig_silver",
    keys=["patient_id"],
    sequence_by=col("dlt_ingest_time"),
    stored_as_scd_type=1
)

import dlt
from pyspark.sql import functions as F

@dlt.table(
    name="patient_diagnosis_gold",
    comment="Gold table with aggregated patient statistics by diagnosis."
)
def patient_statistics_by_diagnosis():
    
    # Read from the Silver table
    df = dlt.read("patient_dig_silver_main")

    # Apply exact transformation logic
    result_df = (
        df.groupBy("diagnosis_description")
        .agg(
            F.count("patient_id").alias("patient_count"),
            F.avg("age").alias("avg_age"),
            F.countDistinct("gender").alias("unique_gender_count"),
            F.min("age").alias("min_age"),
            F.max("age").alias("max_age")
        )
    )

    return result_df


import dlt
from pyspark.sql import functions as F

@dlt.table(
    name="gold_patient_stats_by_gender",
    comment="Gold table: aggregated patient statistics grouped by gender"
)
def patient_statistics_by_gender():
    df = dlt.read("patient_dig_silver_main")

    result_df = (
        df.groupBy("gender")
        .agg(
            F.count("patient_id").alias("patient_count"),
            F.avg("age").alias("avg_age"),
            F.countDistinct("diagnosis_description").alias("unique_diagnosis_count"),
            F.min("age").alias("min_age"),
            F.max("age").alias("max_age")
        )
    )
    return result_df
