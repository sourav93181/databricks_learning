# how it works

🟦 How It Works (Simple Explanation)
Databricks Compute Type	Internally Uses on AWS
All-Purpose Cluster	AWS EC2 instances
Job Cluster	AWS EC2 instances
SQL Warehouse	EC2 + optimized photon engine
Serverless Compute	AWS Fargate (managed by Databricks)
DLT Pipeline Compute	EC2 instances
Photon	Engine on EC2

# ✅ Types of Compute in Databricks

Databricks provides different compute options depending on the workspace (AWS / Azure / GCP) and plan (Free / Pro / Enterprise).

Here are the main compute types:

🚀 1. All-Purpose Clusters

Purpose: Interactive development
Used for:

Notebooks

Ad-hoc queries

Exploration

Debugging ETL logic

Features:

Can attach/detach to notebooks

Auto-scaling

Costly because they run until manually stopped

Use case:
Exploring data, developing ETL code.

🚀 2. Job Clusters

Purpose: Running scheduled jobs / pipelines
Spin up → run job → shut down automatically.

Features:

Ephemeral (used once per job run)

Cheaper than all-purpose

Used by Jobs, Delta Live Tables, Workflows

Use case:
Daily batch ETL job that runs 10 minutes.

🚀 3. SQL Warehouses (formerly SQL Endpoints)

Purpose: BI & Dashboards
Used for:

Running SQL queries

Power BI / Tableau dashboards

Databricks SQL editor

Features:

Cluster optimized for SQL

Serverless option available

Auto-suspend

🚀 4. Serverless Compute

Purpose: Fully managed compute — no cluster management

Includes:

Serverless notebooks

Serverless SQL warehouses

Serverless jobs

Features:

No driver/executor management

Faster startup

Ideal for BI workloads

🚀 5. Photon Cluster (Compute Engine)

Purpose: High performance execution engine

Uses vectorized execution

Faster for Delta & SQL workloads

Photon is not a separate cluster type — it’s a compute engine option.

🚀 6. Delta Live Tables Compute (DLT)

Purpose: Managed data pipeline compute
Cluster types:

Advanced Compute (for CDC, SCD, QoS)

Basic Compute (simple pipelines)

Used for:

SCD Type 2

Schema evolution

Auto retries

7. Pools

group of computes--we can setup mini and max number of machines --


🟦 Summary Table
Compute Type	Use Case	Notes
All-Purpose Cluster	Interactive	Expensive
Job Cluster	Batch jobs	Auto shutdown
SQL Warehouse	Analytics	For BI/SQL
Serverless Compute	No cluster mgmt	Fast startup
Photon	Speed	Option inside cluster
DLT Compute	ETL pipelines	Auto-managed