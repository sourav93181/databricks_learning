┌───────────────────────────┐
│      Source Systems       │
│  ERP / CSV / Flat Files   │
└─────────────┬─────────────┘
              │
              ▼
┌──────────────────────────────────────────┐
│   Unity Catalog – Raw Volume (Landing)   │
│  catalog: finance                        │
│  schema : ap                             │
│  volume : ap_raw_volume                  │
│                                          │
│  /vendor/                                │
│  /purchase_order/                        │
│  /invoice/                               │
│  /payment/                               │
└─────────────┬────────────────────────────┘
              │
              ▼
┌──────────────────────────────────────────┐
│        BRONZE LAYER (Delta Tables)       │
│  • Raw schema                            │
│  • Metadata added (ingest_ts, source)   │
│                                          │
│  finance.ap_bronze.vendor                │
│  finance.ap_bronze.purchase_order        │
│  finance.ap_bronze.invoice_header        │
│  finance.ap_bronze.invoice_line          │
│  finance.ap_bronze.payment               │
└─────────────┬────────────────────────────┘
              │
              ▼
┌──────────────────────────────────────────┐
│          SILVER LAYER (Business)         │
│  • Data quality checks                  │
│  • Deduplication                        │
│  • Type casting                         │
│  • ✅ 3-Way Matching                    │
│    (PO ↔ Invoice ↔ Payment)             │
│                                          │
│  finance.ap_silver.vendor_clean          │
│  finance.ap_silver.invoice_validated     │
│  finance.ap_silver.three_way_match       │
└─────────────┬────────────────────────────┘
              │
              ▼
┌──────────────────────────────────────────┐
│             GOLD LAYER (Analytics)       │
│  • AP Aging                              │
│  • Outstanding Payables                 │
│  • Vendor-wise Payments                 │
│                                          │
│  finance.ap_gold.ap_aging                │
│  finance.ap_gold.outstanding_payables    │
│  finance.ap_gold.vendor_payment_summary  │
└──────────────────────────────────────────┘
