# Auto loader

Auto Loader is designed to process files as they arrive in cloud storage, ensuring incremental (streaming) ingestion.

# How Incremental Loading Works:
File Discovery: Auto Loader continuously monitors the source directory using either File Notification Mode (listening for cloud events like SQS/Event Grid) or Optimized Directory Listing Mode (checking for new files since the last run).

Metadata Tracking: When a new file is detected, Auto Loader records the file's path and timestamp in its State Store (stored at the cloudFiles.schemaLocation). This record ensures that the file is processed exactly once, and never again.

Micro-Batch Processing: Spark Structured Streaming wakes up in small, frequent intervals (micro-batches), reads only the newly discovered files, processes them, and commits the data to the target Delta Lake table.

# Schema Evolution: Auto Merge vs. No Merge
The Schema Evolution feature dictates what happens when an incoming file contains a schema that is different from the target Delta table's current schema. This is controlled by the cloudFiles.schemaEvolutionMode option.

- 1. Auto Merge Schema (addNewColumns)
This is the most flexible approach, ensuring the pipeline never fails due to new data fields.

Behavior: When an incoming file introduces new columns that don't exist in the target table, Auto Loader automatically adds (merges) those new columns to the end of the target table's schema.

Existing Data: Existing rows in the Delta table will have NULL values for the newly added columns.

Option: cloudFiles.schemaEvolutionMode: "addNewColumns"

- 2. Without Auto Merge Schema (failOnNewColumns)
This is the strictest approach, prioritizing data governance and consistency over pipeline robustness.

Behavior: If an incoming file introduces a new column, the entire stream will immediately fail.

When to Use: When you must ensure that all incoming data strictly adheres to a predefined contract. This requires a manual intervention (like fixing the source data or explicitly evolving the schema) before the pipeline can restart.

Option: cloudFiles.schemaEvolutionMode: "failOnNewColumns"

You cannot use a volume path (e.g., /Volumes/...) as the LOCATION for a table in Unity Catalog SQL. If your Delta files are stored in a volume, you should use the CREATE TABLE ... LOCATION syntax only for external cloud storage URIs (like s3://...). To work with Delta files in a volume, use the volume path directly in Spark DataFrame APIs or mount the volume as a managed table using CREATE TABLE ... AS SELECT or CREATE TABLE ... USING DELTA without specifying LOCATION
1
.