USE DATABASE ANALYTICS;
USE SCHEMA RAW;

-- 1. Create file format for CSV parsing
CREATE OR REPLACE FILE FORMAT csv_format
  TYPE = 'CSV'
  FIELD_DELIMITER = ','
  SKIP_HEADER = 1
  NULL_IF = ('NULL', 'null');

-- 2. Create internal stage to hold uploaded files
CREATE OR REPLACE STAGE my_csv_stage
  FILE_FORMAT = csv_format;

-- 3. Create target table in RAW schema
CREATE OR REPLACE TABLE REGION_TARGETS (
  region VARCHAR(50),
  year INT,
  sales_target FLOAT
);

-- 4. Load data from stage into the RAW table
COPY INTO ANALYTICS.RAW.REGION_TARGETS
  FROM @my_csv_stage/region_targets.csv
  FILE_FORMAT = (FORMAT_NAME = csv_format)
  ON_ERROR = 'ABORT_STATEMENT';

-- 5. Validate row count and loaded data
SELECT COUNT(*) AS row_count FROM ANALYTICS.RAW.REGION_TARGETS;
SELECT * FROM ANALYTICS.RAW.REGION_TARGETS LIMIT 10;


SELECT DISTINCT O_ORDERSTATUS FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS