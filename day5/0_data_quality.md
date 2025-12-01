import dlt
from pyspark.sql.functions import col

# Define all your complex rules here
product_quality_rules = {
    "symbol_is_valid": "SYMBOL IS NOT NULL",
    "price_is_positive": "LAST > 0 AND LAST IS NOT NULL"
}

# Assuming 'product_raw_bronze' is your upstream table
# --- CONFIGURATION (adjust as needed) ---
# ...
# ====================================================================
# 1. SILVER LAYER (Cleans, Transforms, and Quarantines)
# ====================================================================

@dlt.table(
    name="product_silver_1",
    comment="Clean product data passing all defined quality expectations."
)
# Use expect_all_or_quarantine to apply all rules and quarantine failing records
# If a record fails ANY of the rules in the dictionary, it is quarantined.
# @dlt.expect_all_or_fail(product_quality_rules)
@dlt.expect_all_or_drop(product_quality_rules)
def clean_products():
    df = (
        spark.readStream.format("cloudFiles")
        .option("cloudFiles.format", "csv")
        .option("header", "true")
        .option("cloudFiles.schemaLocation","/Volumes/first_catalog/bronze/bronze/schemacheckpoint/" )
        .load("/Volumes/first_catalog/bronze/bronze/ERRORERCORDS/")
    )
    return df.withColumn("LAST", col("LAST").cast("double"))

    so it will fileter that data and load to product_silver_1