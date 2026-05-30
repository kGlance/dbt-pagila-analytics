-- Top 10 customers by revenue with rental activity
-- Use case: identify most valuable customers for retention analysis

select
    customer_name,
    email,
    is_active,
    {{ format_currency('total_revenue', '€') }} as total_revenue_formatted,
    total_payments,
    total_rentals,
    round(total_revenue / nullif(total_rentals, 0), 2) as revenue_per_rental
from {{ ref('mart_customer_revenue') }}
order by total_revenue desc
limit 10