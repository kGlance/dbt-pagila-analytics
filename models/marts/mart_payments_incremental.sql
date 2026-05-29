{{ config(materialized='incremental', unique_key='payment_id') }}

with payments as (
    select * from {{ ref('stg_payments') }}
),

customers as (
    select * from {{ ref('stg_customers') }}
)

select
    p.payment_id,
    p.customer_id,
    c.customer_name,
    p.amount,
    p.payment_date
from payments p
left join customers c using (customer_id)

{% if is_incremental() %}
    where p.payment_date > (select max(payment_date) from {{ this }})
{% endif %}