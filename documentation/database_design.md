# TaskFlow Database Design

## Company Overview

TaskFlow is a SaaS productivity management platform that helps businesses organize projects, manage tasks, collaborate with teams, and improve productivity.

The platform offers multiple subscription plans with different features, allowing companies of different sizes to choose the solution that best fits their needs.

This database was designed to support both business operations and product analytics by storing information about employees, customers, subscriptions, product features, sales, and platform usage.

---

# Database Goals

The database should help TaskFlow answer important business questions such as:

- Which employees generate the highest revenue?
- Which departments perform best?
- Which subscription plan is the most popular?
- Which customers generate the highest lifetime value?
- Which product features are available in each subscription plan?
- How actively do customers use the platform?
- Which industries purchase TaskFlow most frequently?

---

# Entity Relationship Overview

```
Departments
      │
      │
Employees ───────────────┐
                          │
                          ▼
                        Sales
                       ▲     ▲
                       │     │
                 Customers   SubscriptionPlans
                      │              │
                      ▼              ▼
               ProductUsage    PlanFeatures
                                      │
                                      ▼
                                  Features
                      
Customers
      │
      ▼
Subscriptions
      │
      ▼
SubscriptionPlans
```

---

# Database Tables

---

# 1. Departments

## Business Purpose

Stores the departments within TaskFlow.

Separating departments into their own table reduces duplicate data and creates a normalized database structure.

## Primary Key

- department_id

## Columns

| Column | Data Type | Description |
|----------|-----------|-------------|
| department_id | INT | Unique department identifier |
| department_name | VARCHAR | Department name |
| manager_name | VARCHAR | Department manager |

## Relationships

- One department has many employees.

## Business Questions

- How many employees work in each department?
- Which department has the highest payroll?
- Which department generates the most sales?

---

# 2. Employees

## Business Purpose

Stores information about every employee working at TaskFlow.

Employees can belong to different departments and sales employees can close customer deals.

## Primary Key

- employee_id

## Foreign Keys

- department_id → Departments.department_id

## Columns

| Column | Data Type | Description |
|----------|-----------|-------------|
| employee_id | INT | Unique employee identifier |
| first_name | VARCHAR | First name |
| last_name | VARCHAR | Last name |
| date_of_birth | DATE | Employee date of birth |
| job_title | VARCHAR | Employee job title |
| department_id | INT | Employee department |
| salary | DECIMAL | Annual salary |
| hire_date | DATE | Hiring date |

## Relationships

- Many employees belong to one department.
- One employee can create many sales.

## Business Questions

- What is the average salary by department?
- Who is the oldest employee?
- Who generates the highest sales revenue?
- How many employees were hired this year?

---

# 3. Customers

## Business Purpose

Stores companies that subscribe to TaskFlow.

Each customer represents one business using the platform.

## Primary Key

- customer_id

## Columns

| Column | Data Type | Description |
|----------|-----------|-------------|
| customer_id | INT | Unique customer identifier |
| company_name | VARCHAR | Company name |
| industry | VARCHAR | Industry |
| country | VARCHAR | Country |
| company_size | VARCHAR | Company size |
| created_date | DATE | Customer registration date |

## Relationships

- One customer can have many sales.
- One customer can have many product usage records.
- One customer can have many subscriptions.

## Business Questions

- Which industries buy TaskFlow most often?
- Which countries generate the most revenue?
- Which customers joined this month?

---

# 4. SubscriptionPlans

## Business Purpose

Stores all available subscription plans.

Each plan offers different pricing and features.

## Primary Key

- plan_id

## Columns

| Column | Data Type | Description |
|----------|-----------|-------------|
| plan_id | INT | Unique plan identifier |
| plan_name | VARCHAR | Plan name |
| monthly_price | DECIMAL | Monthly subscription price |
| max_users | INT | Maximum allowed users |
| ai_features | BOOLEAN | Indicates whether AI features are included |

## Relationships

- One plan can be purchased many times.
- One plan contains multiple features.
- One plan can have many subscriptions.

## Business Questions

- Which plan is the most popular?
- Which plan generates the most revenue?

---

# 5. Subscriptions

## Business Purpose

Stores customer subscription records.

This table connects customers with their selected subscription plans and tracks the subscription lifecycle.

## Primary Key

- subscription_id

## Foreign Keys

- customer_id → Customers.customer_id
- plan_id → SubscriptionPlans.plan_id

## Columns

| Column | Data Type | Description |
|----------|-----------|-------------|
| subscription_id | INT | Unique subscription identifier |
| customer_id | INT | Customer using the subscription |
| plan_id | INT | Selected subscription plan |
| subscription_status | VARCHAR | Subscription status (Trial, Active, Cancelled, Expired) |
| start_date | DATE | Subscription start date |
| end_date | DATE | Subscription end date |

## Relationships

- Many subscriptions belong to one customer.
- Many subscriptions belong to one subscription plan.

## Business Questions

- How many customers are currently in trial?
- How many active subscriptions exist?
- Which plans have the highest retention?
- Which customers cancelled their subscriptions?

---

# 6. Features

## Business Purpose

Stores all features available inside TaskFlow.

Examples include AI Assistant, Reports, Calendar, and Task Management.

## Primary Key

- feature_id

## Columns

| Column | Data Type | Description |
|----------|-----------|-------------|
| feature_id | INT | Unique feature identifier |
| feature_name | VARCHAR | Feature name |
| description | VARCHAR | Feature description |

## Relationships

- One feature can belong to many subscription plans.

## Business Questions

- Which features are included in each subscription plan?

---

# 7. PlanFeatures

## Business Purpose

Creates the many-to-many relationship between subscription plans and product features.

## Composite Primary Key

- plan_id
- feature_id

## Foreign Keys

- plan_id → SubscriptionPlans.plan_id
- feature_id → Features.feature_id

## Columns

| Column | Data Type | Description |
|----------|-----------|-------------|
| plan_id | INT | Subscription plan |
| feature_id | INT | Product feature |

## Relationships

- Many features belong to many plans.

## Business Questions

- Which features belong to each plan?
- Which plans include AI Assistant?

---

# 8. Sales

## Business Purpose

Stores every subscription purchase made by customers.

Each sale connects an employee, a customer, and a subscription plan.

## Primary Key

- sale_id

## Foreign Keys

- employee_id → Employees.employee_id
- customer_id → Customers.customer_id
- plan_id → SubscriptionPlans.plan_id

## Columns

| Column | Data Type | Description |
|----------|-----------|-------------|
| sale_id | INT | Unique sale identifier |
| employee_id | INT | Sales employee |
| customer_id | INT | Purchasing customer |
| plan_id | INT | Purchased plan |
| sale_amount | DECIMAL | Revenue generated |
| sale_status | VARCHAR | Sale status |
| sale_date | DATE | Sale date |

## Relationships

- Many sales belong to one employee.
- Many sales belong to one customer.
- Many sales belong to one subscription plan.

## Business Questions

- Who generated the highest revenue?
- What is the monthly revenue?
- Which customers spend the most?

---

# 9. ProductUsage

## Business Purpose

Tracks how customers use TaskFlow after purchasing a subscription.

This information helps the Product Team understand customer engagement.

## Primary Key

- usage_id

## Foreign Keys

- customer_id → Customers.customer_id

## Columns

| Column | Data Type | Description |
|----------|-----------|-------------|
| usage_id | INT | Unique usage record |
| customer_id | INT | Customer |
| usage_month | DATE | Reporting month |
| tasks_created | INT | Number of created tasks |
| active_users | INT | Active users |
| ai_requests | INT | Number of AI requests |

## Relationships

- Many usage records belong to one customer.

## Business Questions

- Which customers actively use TaskFlow?
- Which customers rarely use the platform?
- How popular is the AI feature?
- Which customers create the most tasks?

---

# Summary

This database follows relational database design principles by:

- Using Primary Keys to uniquely identify records.
- Using Foreign Keys to create relationships between tables.
- Separating related information into different tables to reduce duplicate data.
- Supporting CRM, Product Management, Sales Analytics, and Business Intelligence use cases.

The design provides a strong foundation for writing SQL queries, generating business reports, and analyzing customer behavior within the TaskFlow platform.