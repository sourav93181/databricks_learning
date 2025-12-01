from pyspark.sql.functions import col
from pyspark.sql.types import *
from datetime import datetime

# Define schema
schema = StructType([
    StructField("policy_holder_id", IntegerType(), True),
    StructField("case_id", StringType(), True),
    StructField("call_category", StringType(), True),
    StructField("call_received", TimestampType(), True),
    StructField("call_duration_secs", IntegerType(), True),
    StructField("original_order", IntegerType(), True)
])

# Create data with datetime objects
data = [
    (52481621, "a94c2213-4ba5-812d", None,      datetime(2022, 1, 17, 19, 37, 0), 286, 161),
    (51435044, "f0b5-0eb0-4c49-b21e", "n/a",    datetime(2022, 1, 18, 2, 46, 0), 208, 225),
    (52082925, "289bd7e8-4527-bdf5", "benefits",datetime(2022, 1, 18, 3, 1, 0), 291, 352),
    (54624612, "62c2-d9a3-44d2-9065", "IT_support",datetime(2022, 1, 19, 0, 27, 0), 273, 358),
    (54624612, "9f57-164b4a36-934e", "claims",  datetime(2022, 1, 19, 6, 33, 0), 157, 362)
]

# Create DataFrame
df = spark.createDataFrame(data, schema)
display(df)

result_df=df.filter((col('call_category').isNull()) | (col('call_category') =='n/a') )
display(result_df.count())