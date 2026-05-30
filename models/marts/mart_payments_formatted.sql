{{ config(materialized='view') }}

select
    payment_id,
    customer_id,
    {{ format_currency('amount', '€') }} as amount_formatted,
    payment_date
from {{ ref('stg_payments') }}