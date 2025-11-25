# Dimensional data
Dimensional data refers to the textual and descriptive attributes that provide context to your business processes. Its main role is to define the entities (people, places, things) involved in a transaction or event.

# scd and types

SCD stands for Slowly Changing Dimension. It is a technique used in data warehousing to manage and track changes to dimensional data (like customers, products, or locations) over time. Dimensional data often changes, but not on a regular, predictable schedule (hence, "slowly changing").


# 1. SCD Type 1: Overwrite (No History)-upsert
Behavior: The new data overwrites the old data immediately. Historical information is lost.

When to Use: For correcting minor errors or for fields where the past value is irrelevant for analysis (e.g., fixing a spelling error, or storing an up-to-the-minute status flag).

Pros: Simplest to implement; the dimension table always reflects the current reality.

Cons: Cannot perform historical analysis based on the old dimension value.

Example: A customer updates their phone number. The old phone number is immediately replaced by the new one.

# SCD Type 2: Add New Row (Full History)
Behavior: A change in a dimensional attribute results in adding a new row to the dimension table. The original row remains, capturing the history.

Key Fields Used: To manage this history, the dimension table typically adds:

A surrogate key (unique ID for each row).

Effective Date/Timestamp columns (start_date, end_date).

A Current Row Indicator (a boolean flag like is_current = 'Y'/'N').

When to Use: When it is crucial to track the history of an attribute and link facts (like sales) to the correct historical dimension value.

Pros: Preserves the complete history; enables complex "as-was" reporting.

Cons: Increases the size of the dimension table significantly (one customer can have many rows).

Example: A customer moves from New York to Texas. A new row is created for the Texas address, and the end_date and is_current flag are updated on the old New York row.

# 3. SCD Type 3: Add New Column (Limited History)
How SCD Type 3 Works
When an attribute changes, you don't create a new row; instead, you add a new column to the existing dimension table to hold the old value.

Customer_Key	Customer_Name	Current_Region	Previous_Region
101	Jane Doe	West	North

Behavior: A change in a dimensional attribute results in adding a new column to the dimension table to store the historical value.

When to Use: When you only need to track the current value and the single immediately preceding value.

Pros: Keeps the dimension table structure simple (one row per entity) while allowing for some historical context.

Cons: Can only track one previous state. If the attribute changes again, the "original" value is lost.

Example: A customer changes their preferred sales representative. The table has two columns: current_rep and previous_rep.




