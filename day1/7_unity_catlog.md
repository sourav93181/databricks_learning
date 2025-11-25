# Unit catalog

Unity Catalog is a centralized data governance solution in Azure Databricks that helps manage data access track usage and enable discovery across all worksapace

✅ Unity Catalog — Brief, Simple Definition

Unity Catalog is Databricks’ centralized governance layer for:

✔ Data (tables, views, files)
✔ ML models
✔ Notebooks & functions
✔ Permissions
✔ Audit logging
✔ Data lineage

It gives you one place to manage:

Who can read/write data

Where data lives

How tables are structured

Which users accessed what

Which jobs modified which tables

Schema evolution

Cross-workspace sharing

You can think of Unity Catalog as:
❗ “The data governance system for the entire Databricks Lakehouse.”


✅ Unity Catalog — Brief, Simple Definition

Unity Catalog is Databricks’ centralized governance layer for:

✔ Data (tables, views, files)
✔ ML models
✔ Notebooks & functions
✔ Permissions
✔ Audit logging
✔ Data lineage

It gives you one place to manage:

Who can read/write data

Where data lives

How tables are structured

Which users accessed what

Which jobs modified which tables

Schema evolution

Cross-workspace sharing

You can think of Unity Catalog as:
❗ “The data governance system for the entire Databricks Lakehouse.”

🏗 Unity Catalog = 3-Level Namespace
catalog.schema.table


Example:

finance.sales.transactions


Catalog = highest level
Schema = like database
Table/View = actual data

🔒 What Unity Catalog Controls?

Unity Catalog manages:

1. Permissions / Access Control

Table access

Column-level & row-level security

Tokenization

Attribute-based access control (ABAC)

Fine-grained controls

2. Lineage Tracking

Shows:

Which jobs/notebooks read a table

Which tables were used to create another table

3. Data Discovery

You can search tables across workspaces.

4. Governance for All Assets

Delta tables

Files

ML models

Functions

5. Cross-workspace sharing

Share data between workspaces instantly.

🟨 Why Unity Catalog is Important? (Simple)

Without Unity Catalog → Each workspace has its own metastore
With Unity Catalog → You have one single governance layer across your company.

Databricks Associate exam asks about this heavily.

🎯 Unity Catalog – Key Features (Exam Focus)
Feature	What It Means
3-level namespace	catalog.schema.table
Centralized governance	one metastore for all workspaces
Fine-grained access control	table, column, row-level
Lineage	track data movement
Secure sharing	share across workspaces
Supports Delta Lake only	must store data in managed locations
Storage credential	secure access to external S3/Azure/GCS
External locations	map S3 → UC catalog
Managed tables	UC controls storage
External tables	UC only controls metadata


🟦 Unity Catalog Architecture Diagram (ASCII)
                     ┌────────────────────────────┐
                     │     Unity Catalog           │
                     │   (Central Governance)      │
                     └──────────┬──────────────────┘
                                │
                   ┌────────────┴────────────┐
                   │                         │
         ┌─────────────────┐      ┌───────────────────┐
         │   Metastore     │      │   Metastore       │
         │ (Region Scoped) │      │ (Another Region)  │
         └──────┬──────────┘      └─────────┬────────┘
                │                            │
   ┌────────────┴───────────┐      ┌─────────┴──────────┐
   │      Catalogs           │      │      Catalogs       │
   └───────┬────────────────┘      └────────┬────────────┘
           │                                 │
  ┌────────┴──────────┐            ┌─────────┴──────────┐
  │      Schemas       │            │      Schemas        │
  └────────┬───────────┘            └────────┬────────────┘
           │                                 │
     ┌─────┴─────┐                    ┌──────┴──────┐
     │  Tables   │                    │   Views      │
     └───────────┘                    └──────────────┘

Storage Layer (AWS S3 / ADLS / GCS)
         ▲
         │
UC Storage Credentials + External Locations

🟣 Unity Catalog One-Page Cheat Sheet
Core Concepts

Metastore – governance boundary across workspaces

Catalog – top-level container

Schema – organizes tables

Table – Delta managed or external

Volume – governed file storage

Table Types

Managed Table → UC manages data + metadata

External Table → UC manages metadata only; data stays in S3

Storage

Requires:

Storage Credential

External Location

IAM role

Security

Table-level, schema-level, column-level, row-level

Dynamic views allow row-level filtering

Audit logs for all actions

Lineage

Shows upstream/downstream

Tracks notebooks, jobs, tables

Access

GRANT SELECT ON table

GRANT MODIFY ON table

Catalog-level and schema-level grants

Integration

SQL Warehouse

Delta Lake

Delta Sharing

DLT Pipelines