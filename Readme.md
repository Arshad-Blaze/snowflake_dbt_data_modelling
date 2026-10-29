[Sources: TPC-H + CSV] 
       │
       ▼
   [Staging]      (Views: rename & cast)
       │
       ▼
 [Intermediate]   (Views: joins & net revenue calculation)
       │
       ▼
    [Marts]       (Tables: dimensions, incremental facts, reports, & snapshots)
       │
       ▼
   [Consume]      (Analytics queries, Snowsight reports)
   
   
   
Orchestration: Run daily via a Snowflake Task executing EXECUTE DBT PROJECT.


Model List & Grain

Layer	Model Name	Materialization	Grain	Description

Staging	
1. stg_tpch__customers			View	One row per customer		Casts types & standardizes customer attributes
2. stg_tpch__orders				View	One row per order			Casts types & standardizes order header attributes
3. stg_tpch__lineitems			View	One row per order line		Standardizes line item metrics and dates
4. stg_tpch__parts				View	One row per part			Cleans up product catalog details
5. stg_tpch__nations & _regions	View	One row per nation/region	Geographic reference data
6. stg_raw__region_targets		View	One row per region & year	Loads raw CSV sales targets

Intermediate	
1. int_customers_with_region	View	One row per customer	Joins customer, nation, and region hierarchy
2. int_order_lines_enriched		View	One row per order line	Joins line items, orders, and customer geography; computes net_revenue

Marts		
1. dim_customers				Table				One row per customer		Customer dimension with full geography
2. dim_parts					Table				One row per part			Product dimension
3. dim_regions					Table				One row per region			Region dimension
4. fct_orders					Table				One row per order			Order-level aggregated metrics
5. fct_order_lines				Incremental Table	One row per order line		Detailed order line fact table, incremental on order_date
6. rpt_region_sales_vs_target	Table				One row per region & year	Actual revenue vs. target variance report

Snapshot	

region_targets_snapshot	Snapshot (SCD2)				One row per region & year	Slowly Changing Dimension Type 2 tracking target updates


How to Run

Setup Environment: Execute 00_setup.sql to create warehouse, resource monitor, role, and schemas.

Load Raw Data: Execute 01_load_raw.sql and upload region_targets.csv to your internal stage.

Build dbt Project: Open your Snowsight Workspace and run: dbt build

Deploy & Schedule: Deploy the project object and start the daily Snowflake Task: ALTER TASK run_sales_analytics_daily RESUME;


Key Design Choices
Incremental Fact Loading:
		fct_order_lines is built incrementally based on order_date to optimize query performance and minimize credit consumption on large datasets.

Native Snowflake Execution:
		Utilizes dbt Projects on Snowflake Workspaces, avoiding local installations or external cloud runners.

Custom Schema Macro: 
		Implemented a custom generate_schema_name macro to ensure clean database organization (STAGING, INTERMEDIATE, MARTS) without unintended prefix doubling.

Deliverables Checklist for Submission:

SQL Scripts: 00_setup.sql and 01_load_raw.sql

dbt Project Repository: Link to your GitHub repo containing models/, snapshots/, tests/, macros/, and dbt_project.yml.

Screenshots: 
1. dbt DAG lineage graph in Snowsight
2. Successful green dbt build run output
3. Scheduled task run history logs
4. Failed test run validation

Consumption Queries & Findings: 4–5 business queries executed against the marts schema.

Cost Note: Documented warehouse metering history showing total trial credits used (kept well under the 20-credit quota using auto-suspend).