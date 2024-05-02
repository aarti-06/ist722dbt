with stg_vendors as (
    select * from {{ source('fudgemart_v3','fm_vendors')}}
)
select  {{ dbt_utils.generate_surrogate_key(['stg_vendors.vendor_id']) }} as vendorkey, 
    stg_vendors.* 
from stg_vendors