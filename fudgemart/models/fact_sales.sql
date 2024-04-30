with stg_orders as 
(
    select
        Order_ID,   
        {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customerkey, 
        replace(to_date(order_date)::varchar,'-','')::int as orderdatekey,
    from {{source('fudgemart_v3','fm_orders')}}    
),
stg_order_details as
(
    select 
        Order_ID,
        Product_id,
        {{ dbt_utils.generate_surrogate_key(['product_id']) }} as productkey,
        order_qty as Quantity
    from {{source('fudgemart_v3','fm_order_details')}}
),
stg_products as
(
    select 
        Product_id,
        Product_Retail_Price as UnitPrice
    from {{source('fudgemart_v3','fm_products')}}
)
select o.*, 
    od.productkey, od.Quantity, 
    (od.Quantity*p.UnitPrice) as extendedpriceamount
from stg_orders o 
    join stg_order_details od on o.Order_ID = od.Order_id
    join stg_products p on od.Product_id = p.Product_id