CREATE TABLE callers (
    policy_holder_id INTEGER,
    case_id VARCHAR(50),
    call_category VARCHAR(20),
    call_received VARCHAR(20),
    call_duration_secs INTEGER,
    original_order INTEGER
);

INSERT INTO callers (policy_holder_id, case_id, call_category, call_received, call_duration_secs, original_order) VALUES
(50837000, 'dc63-acae4f39-bb04', 'claims', '2022-03-09 02:51:00', 205, 130),
(50837000, '41bebebe4bd0-a1ba', 'IT_support', '2022-03-12 05:37:00', 254, 129),
(50936674, '12c8-b35c48a3-b38d', 'claims', '2022-05-31 07:27:00', 240, 31),
(50886837, 'd0b4-8ea7-4b8caa8b', 'IT_support', '2022-03-11 03:38:00', 276, 16),
(50886837, 'a741-c279-41c0-90ba', 'benefits', '2022-03-19 10:52:00', 131, 325),
(50837000, 'bab1-3ec5-4867-90ae', 'benefits', '2022-05-13 18:19:00', 228, 339);

--------------------------sql--------------------------

select count(t.policy_holder_id) from (
select policy_holder_id,count(call_received) from callers group by policy_holder_id having count(call_received)>2) as t;

--------------------------pyspark--------------------------

from pyspark.sql.functions import col,count
result_df=caller_df.groupBy(col('policy_holder_id')).agg(count(col('case_id')).alias('c_t')).filter(col('c_t')>2).agg(count(col('policy_holder_id')))
display(result_df)

