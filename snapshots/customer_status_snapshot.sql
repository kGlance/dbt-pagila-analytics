. 
{% snapshot customer_status_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='customer_id',
        strategy='check',
        check_cols=['is_active']
    )
}}

select * from {{ ref('stg_customers') }}

{% endsnapshot %}