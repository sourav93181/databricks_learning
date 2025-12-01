# DButils

lib by databricks to help you interact with you databricks env more effectively.
it allows you to perform a variety of tasks like:

managing files and directory
working with secrets 
handling widgets
managing libraries


dbutils.help()

from delta.tables import DeltaTable
from pyspark.sql.utils import AnalysisException

target_path = "/mnt/data/customers"

# Your incoming dataframe
updatesDF = spark.createDataFrame([
    (1, "Alice", "Premium"),
    (2, "Bob", "Basic")
], ["customer_id", "name", "plan"])

try:
    delta_table = DeltaTable.forPath(spark, target_path)
    # Run MERGE if table exists
    (delta_table.alias("target")
        .merge(updatesDF.alias("updates"),
               "target.customer_id = updates.customer_id")
        .whenMatchedUpdate(set={
            "name": "updates.name",
            "plan": "updates.plan"
        })
        .whenNotMatchedInsert(values={
            "customer_id": "updates.customer_id",
            "name": "updates.name",
            "plan": "updates.plan"
        })
        .execute())
except AnalysisException:
    # Table doesn't exist yet → create it
    updatesDF.write.format("delta").save(target_path)
