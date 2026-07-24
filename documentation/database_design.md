# TaskFlow Database Design

## Company Overview

TaskFlow is a SaaS productivity management platform that helps companies organize their teams, manage projects, and improve workplace collaboration.

TaskFlow offers different subscription plans with different features. The database manages internal employees, customers, sales activity, product features, subscriptions, and customer usage analytics.

## Database Goals

The database should help TaskFlow answer business questions such as:

- Which employees generate the most revenue?
- Which customers generate the highest value?
- Which subscription plan is the most popular?
- Which features are included in each plan?
- How do customers use the platform?


# Database Tables

---

# 1. Employees

## Purpose

Stores information about TaskFlow employees.

This table helps analyze employee performance, departments, salaries, and sales activities.

## Columns

| Column Name | Data Type | Description |
|---|---|---|
| employee_id | INT | Unique identifier for each employee |
| first_name | VARCHAR | Employee first name |
| last_name | VARCHAR | Employee last name |
| job_title | VARCHAR | Employee position |
| department | VARCHAR | Employee department |
| salary | DECIMAL | Annual employee salary |
| date_of_birth | DATE | Employee date of birth |
| hire_date | DATE | Date employee joined TaskFlow |

## Relationships

- One employee can create multiple deals.


---

# 2. Customers

## Purpose

Stores information about companies using TaskFlow.

Customers are businesses that purchase TaskFlow subscription plans.

## Columns

| Column Name | Data Type | Description |
|---|---|---|
| customer_id | INT | Unique identifier for each customer |
| company_name | VARCHAR | Customer company name |
| industry | VARCHAR | Business industry |
| country | VARCHAR | Customer country |
| company_size | VARCHAR | Number of employees category |
| created_date | DATE | Date customer joined TaskFlow |

## Relationships

- One customer can have multiple deals.
- One customer can have multiple usage records.


---

# 3. Subscription Plans

## Purpose

Stores available TaskFlow pricing plans.

Different plans provide different features.

## Columns

| Column Name | Data Type | Description |
|---|---|---|
| plan_id | INT | Unique identifier for each plan |
| plan_name | VARCHAR | Name of subscription plan |
| monthly_price | DECIMAL | Monthly subscription price |
| max_users | INT | Maximum users allowed |
| description | VARCHAR | Plan description |

## Relationships

- One subscription plan can have multiple customers.
- One subscription plan can contain multiple features.


---

# 4. Deals

## Purpose

Stores sales transactions between TaskFlow employees and customers.

## Columns

| Column Name | Data Type | Description |
|---|---|---|
| deal_id | INT | Unique identifier for each deal |
| employee_id | INT | Employee responsible for deal |
| customer_id | INT | Customer purchasing the product |
| plan_id | INT | Purchased subscription plan |
| deal_value | DECIMAL | Revenue generated |
| deal_status | VARCHAR | Deal status |
| deal_date | DATE | Date deal was created |

## Relationships

- Many deals belong to one employee.
- Many deals belong to one customer.
- Many deals belong to one subscription plan.


---

# 5. Features

## Purpose

Stores product features available in TaskFlow.

Examples:
- AI Assistant
- Task Management
- Reports
- Automation

## Columns

| Column Name | Data Type | Description |
|---|---|---|
| feature_id | INT | Unique identifier |
| feature_name | VARCHAR | Feature name |
| description | VARCHAR | Feature explanation |

## Relationships

- Features can belong to multiple subscription plans.


---

# 6. Plan Features

## Purpose

Connects subscription plans with their available features.

This table manages the many-to-many relationship between plans and features.

## Columns

| Column Name | Data Type | Description |
|---|---|---|
| plan_id | INT | Subscription plan identifier |
| feature_id | INT | Feature identifier |

## Relationships

- One plan can have many features.
- One feature can belong to many plans.


---

# 7. Usage Analytics

## Purpose

Tracks how customers use the TaskFlow platform.

This helps the product team understand user behavior.

## Columns

| Column Name | Data Type | Description |
|---|---|---|
| usage_id | INT | Unique identifier |
| customer_id | INT | Customer identifier |
| month | DATE | Usage month |
| tasks_created | INT | Number of tasks created |
| active_users | INT | Number of active users |
| ai_requests | INT | Number of AI feature requests |

## Relationships

- One customer can have multiple usage records.


---

# Database Relationships Overview

```
Employees
       |
       |
     Deals
  /         \
Customers SubscriptionPlans
    |          |
    |          |
 Usage     PlanFeatures
                |
            Features
```