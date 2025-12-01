Your task is to display all columns from this table, along with the maximum transaction amount (MaxTranAmt) for each customer (CustID) and the ratio of each transaction amount (TranAmt) to the maximum transaction amount for that customer 

CREATE TABLE Transaction_Tbl (
    CustID INT NOT NULL,
    TranID INT NOT NULL PRIMARY KEY,
    TranAmt INT,
    TranDate DATE
);

INSERT INTO Transaction_Tbl (CustID, TranID, TranAmt, TranDate) VALUES
(1001, 20001, 10000, '2020-04-25'),
(1001, 20002, 15000, '2020-04-25'),
(1001, 20003, 80000, '2020-04-25'),
(1001, 20004, 20000, '2020-04-25'),
(1002, 30001, 7000, '2020-04-25'),
(1002, 30002, 15000, '2020-04-25'),
(1002, 30003, 22000, '2020-04-25');

select  *,
sum(TranAmt) over (partition by CustID),
round(CAST(TranAmt AS DECIMAL(10,2))/sum(TranAmt) over (partition by CustID),2)
from Transaction_Tbl 

pyspark

year_m_d_df=year_m_d_df.withColumn('sum_partition',sum('TranAmt').over(Window.partitionBy('CustID'))).withColumn('ratio_part',round(col('TranAmt').cast(DecimalType(10, 2))/sum('TranAmt').over(Window.partitionBy('CustID')),2))
year_m_d_df.display()
