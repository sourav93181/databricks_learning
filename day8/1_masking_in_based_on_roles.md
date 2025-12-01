# Dynamic Column Masking (Unity Catalog — PRODUCTION)

## Step 1: Create masking function
CREATE OR REPLACE FUNCTION mask_email(email STRING)
RETURNS STRING
RETURN regexp_replace(email, '(^.).*(@.*$)', '$1***$2');

## Step 2: Apply masking policy
CREATE OR REPLACE MASKING POLICY email_mask
AS (email STRING) -> STRING
USING CASE
  WHEN is_account_group_member('data_engineering_team') THEN email
  ELSE mask_email(email)
END;

## Step 3: Apply to table column
ALTER TABLE users 
ALTER COLUMN email 
SET MASKING POLICY email_mask;