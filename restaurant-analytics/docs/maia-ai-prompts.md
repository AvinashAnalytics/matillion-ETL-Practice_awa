# 🤖 Complete Maia AI Implementation Guide

## 🎯 One-Command Full Implementation

For complete project creation in one go:

```
Hi Maia, please create a comprehensive restaurant analytics platform with the following requirements:

1. Create folder structure: restaurant-analytics/orchestration/ and restaurant-analytics/transformation/

2. Build data-ingestion.orch.yaml orchestration pipeline that:
   - Creates a file registry mapping restaurant CSV files to table names
   - Uses table iterator to process each file dynamically
   - Creates tables with schema inference using SQL executor
   - Includes error handling and logging
   - Runs business analytics and executive dashboard transformations
   
3. Build file-registry.tran.yaml that maps:
   - rest_menus.csv → REST_MENUS
   - rest_orders.csv → REST_ORDER
   - rest_customers.csv → REST_CUSTOMERS  
   - rest_employees.csv → REST_EMPLOYEES

4. Build business-analytics.tran.yaml that:
   - Joins all restaurant tables
   - Calculates KPIs: CLV, AOV, top selling items, employee performance
   - Creates 5 output tables with proper transformations

5. Build executive-dashboard.tran.yaml that:
   - Reads analytics tables and creates executive summaries
   - Generates 3 executive dashboard tables

Use variables: stage_name='mat_pro.resturant', file_format='mat_pro.infer_fmt'
Make it production-ready with proper error handling and documentation.
```

---

## 🔧 Step-by-Step Implementation Prompts

### 1️⃣ Project Structure Setup

```
Create a new project folder structure for a restaurant analytics platform:
- restaurant-analytics/orchestration/
- restaurant-analytics/transformation/ 
- restaurant-analytics/docs/

This will be a comprehensive ELT pipeline for business intelligence.
```

### 2️⃣ File Registry Creation

```
Create a transformation pipeline called 'restaurant-analytics/transformation/file-registry.tran.yaml' with:

1. A fixed-flow component that defines these file mappings:
   - rest_menus.csv → REST_MENUS (menu_data)
   - rest_orders.csv → REST_ORDER (transaction_data)
   - rest_customers.csv → REST_CUSTOMERS (customer_data)
   - rest_employees.csv → REST_EMPLOYEES (employee_data)

2. Output to a table called 'file_list' with columns: file_name, table_name, file_type
3. Sort by file_type ascending

This registry will control which files get processed by the main pipeline.
```

### 3️⃣ Main Data Ingestion Orchestration

```
Create an orchestration pipeline 'restaurant-analytics/orchestration/data-ingestion.orch.yaml' that:

1. Starts with a Start component
2. Runs the file-registry transformation to create the file list
3. Uses a table-iterator to process each file from the file_list table:
   - Iterates through file_name and table_name columns
   - Uses sequential processing
   - Maps variables: file_name → file_name, table_name → table_name
4. The iterator target is a SQL executor that:
   - Creates tables dynamically using Snowflake's INFER_SCHEMA
   - Loads data with COPY INTO and error handling
   - Uses stage '@${stage_name}/${file_name}' and file format '${file_format}'
5. After iteration, logs completion status
6. Runs business analytics transformation pipeline
7. Runs executive dashboard transformation pipeline

Add these variables:
- file_name (TEXT, shared, public)
- stage_name (TEXT, shared, public, default: 'mat_pro.resturant')
- table_name (TEXT, shared, public)
- file_format (TEXT, shared, public, default: 'mat_pro.infer_fmt')

Include proper notes explaining the pipeline flow.
```

### 4️⃣ Business Analytics Transformation

```
Create 'restaurant-analytics/transformation/business-analytics.tran.yaml' that performs comprehensive restaurant KPI analysis:

1. Load all 4 restaurant tables:
   - REST_CUSTOMERS (customer_id, customer_name, join_date, loyalty_level, age, city)
   - REST_EMPLOYEES (employee_id, employee_name, hire_date, position)
   - REST_MENUS (menu_id, item_name, category, price)
   - REST_ORDER (order_id, order_date, customer_id, employee_id, menu_id, quantity)

2. Create master dataset by joining all tables on their relationships

3. Calculate order values using calculator: total_price = price × quantity

4. Generate these KPI outputs:
   - CLV table: Group by customer, sum total_price → rename to total_spent, order by total_spent desc
   - AOV table: Calculate average of total_price → rename to avg_order_value
   - TOP_SELLING table: Group by item_name and category, sum quantity and total_price → rename to total_quantity_sold and total_revenue, order by total_revenue desc
   - SALES_PERFO table: Group by employee_name and position, count customers and sum total_price → rename to total_orders_handled and total_revenue_generated, order by total_revenue_generated desc
   - CUSTOMER_RETENTION table: LEFT join customers with orders, group by loyalty_level, calculate retention rates
   - master_rest_table: Complete joined dataset

5. Use proper rename components for clean column names
6. Add visual notes explaining each KPI branch
```

### 5️⃣ Executive Dashboard Creation

```
Create 'restaurant-analytics/transformation/executive-dashboard.tran.yaml' for C-suite reporting:

1. Load analytics tables:
   - CLV table (customer_id, customer_name, total_spent)
   - AOV table (avg_order_value)
   - TOP_SELLING table (item_name, category, total_quantity_sold, total_revenue)

2. Create executive summary calculations:
   - Add dashboard metadata: title='Restaurant Performance Dashboard', report_date=CURRENT_DATE()
   - Calculate Customer Lifetime Value aggregates: sum, count, average, max of total_spent
   - Calculate Category performance: group by category, sum revenue and quantity, count items

3. Output executive tables:
   - EXEC_SUMMARY: Dashboard metadata and key metrics
   - EXEC_CLV_DATA: Customer lifetime value executive summary
   - EXEC_CATEGORY_DASHBOARD: Category performance rankings ordered by revenue desc

4. Add success messages to each output component
5. Include visual notes showing the executive dashboard flow
```

### 6️⃣ Documentation Creation

```
Create comprehensive documentation in 'restaurant-analytics/README.md' that includes:

1. Project overview and business impact
2. Complete folder structure
3. Quick start guide with one-command implementation
4. Step-by-step manual implementation instructions
5. Data pipeline architecture diagram
6. Output tables reference with all column definitions
7. Interview presentation points highlighting technical excellence
8. Advanced customization examples
9. Success metrics and validation steps

Make it professional and interview-ready with proper formatting and emojis.
```

---

## 🔄 Execution Order Prompts

### Pipeline Execution Sequence

```
Now let's execute the restaurant analytics platform:

1. First, run the data-ingestion orchestration pipeline to:
   - Create the file registry
   - Process all 4 CSV files
   - Create and populate restaurant tables
   - Generate all business analytics KPIs
   - Create executive dashboard summaries

2. Sample key components to validate data quality

3. Verify all output tables are created successfully with expected data

This should demonstrate a complete end-to-end data platform.
```

### Data Validation

```
Validate the restaurant analytics implementation by:

1. Sampling the file_list table to confirm file registry
2. Sampling each restaurant table (REST_CUSTOMERS, REST_EMPLOYEES, etc.)
3. Sampling the CLV table to see top customers
4. Sampling the TOP_SELLING table for menu insights
5. Sampling executive dashboard tables for C-suite metrics

Show the data quality and business insights generated.
```

---

## 🎯 Customization Prompts

### Adding New KPIs

```
Extend the business-analytics pipeline to add customer retention analysis:
1. Calculate retention rate by loyalty level
2. Create a new output table called CUSTOMER_RETENTION
3. Include percentage calculations and proper formatting
```

### New Data Sources

```
Add support for a new restaurant data source:
1. Update the file registry to include 'rest_promotions.csv' → 'REST_PROMOTIONS'
2. The pipeline should automatically process this new file
3. Add promotion analysis to the business analytics transformation
```

### Advanced Analytics

```
Create an advanced analytics extension that:
1. Calculates seasonal trends from order dates
2. Performs customer segmentation based on spending patterns
3. Creates predictive models for menu item popularity
4. Generates recommendation insights for business optimization
```

---

## 🛠️ Troubleshooting Prompts

### Pipeline Issues

```
If the restaurant pipeline encounters errors:
1. Check that all CSV files exist in the Snowflake stage 'mat_pro.resturant'
2. Verify the file format 'mat_pro.infer_fmt' is properly configured
3. Validate table permissions in the target database/schema
4. Sample intermediate components to identify transformation issues
```

### Data Quality

```
Add data quality checks to the restaurant pipeline:
1. Validate that customer_id exists in both customers and orders tables
2. Check for NULL values in critical fields
3. Ensure price and quantity are positive numbers
4. Verify employee_id relationships between employees and orders
```

---

## 🎆 Success Validation

After implementation, verify success with:

```
Confirm the restaurant analytics platform is working by:
1. Running the complete data-ingestion pipeline successfully
2. Validating all 11 output tables are created (4 source + 5 analytics + 3 executive)
3. Sampling key business metrics like top customers, best-selling items, and top employees
4. Confirming executive dashboards show meaningful business insights
5. Testing the scalability by adding a new file to the registry

This demonstrates a production-ready, enterprise-level data platform.
```

---

*These prompts will create a complete, interview-ready restaurant analytics platform using Maia AI with zero manual coding required!* 🎆