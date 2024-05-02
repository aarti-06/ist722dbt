with f_sales as (
    select * from {{ ref('fact_sales') }}
),
d_customer as (
    select * from {{ ref('dim_customer') }}
),
d_date as (
    select * from {{ ref('dim_date') }}
),
d_product as (
    select * from {{ ref('dim_product') }}
)
select
    d_customer.*,d_date.*,d_product.*,f.Order_id,f.orderdatekey,f.Quantity,f.extendedpriceamount
    from f_sales as f 
    Left join d_customer on f.customerkey = d_customer.customerkey
    Left join d_date on f.orderdatekey = d_date.datekey
    left join d_product on f.productkey = d_product.productkey
