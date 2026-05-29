with source as (
    select * from {{ source('pagila', 'rental') }}
),

renamed as (
    select
        rental_id,
        customer_id,
        inventory_id,
        staff_id,
        rental_date::date as rental_date,
        return_date::date as return_date
    from source
)

select * from renamed