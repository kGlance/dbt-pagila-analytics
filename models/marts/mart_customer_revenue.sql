with payments as (
    select * from {{ ref('stg_payments') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
),

rentals as (
    select * from {{ ref('stg_rentals') }}
),

customer_payments as (
    select
        p.customer_id,
        count(distinct p.payment_id)  as total_payments,
        sum(p.amount)                 as total_revenue,
        min(p.payment_date)           as first_payment_date,
        max(p.payment_date)           as last_payment_date
    from payments p
    group by p.customer_id
),

customer_rentals as (
    select
        customer_id,
        count(distinct rental_id) as total_rentals
    from rentals
    group by customer_id
)

select
    c.customer_id,
    c.customer_name,
    c.email,
    c.is_active,
    coalesce(cp.total_payments, 0) as total_payments,
    coalesce(cp.total_revenue, 0)  as total_revenue,
    coalesce(cr.total_rentals, 0)  as total_rentals,
    cp.first_payment_date,
    cp.last_payment_date
from customers c
left join customer_payments cp using (customer_id)
left join customer_rentals  cr using (customer_id)