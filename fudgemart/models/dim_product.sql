with stg_products as (
    select * from {{ source('fudgemart_v3','fm_products')}}
)
select  {{ dbt_utils.generate_surrogate_key(['stg_products.product_id']) }} as productkey, 
    stg_products.* 
from stg_products