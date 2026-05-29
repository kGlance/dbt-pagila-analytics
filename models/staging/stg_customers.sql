with source as (
    select * from {{ source('pagila', 'customer') }}
),

renamed as (
    select
        customer_id,
        first_name || ' ' || last_name as customer_name,
        email,
        active::boolean as is_active,
        create_date
    from source
)

select * from renamed
