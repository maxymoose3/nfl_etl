
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(
    materialized='view'
) }}

SELECT
    st.tm,
    st.w,
    st.l,
    st.t,
    po.td as pass_o_td,
    po.intr as pass_o_intr,
    po.anyp_a as pass_o_anyp_a,
    po.sk as pass_o_sk,
    ro.td as rush_o_td,
    ro.yp_a as rush_o_yp_a,
    ro.fmb,
    pd.td as pass_d_td,
    pd.intr as pass_d_intr,
    pd.anyp_a as pass_d_anyp_a,
    pd.sk as pass_d_sk,
    pd.tfl,
    rd.td as rush_d_td,
    rd.yp_a as rush_d_yp_a
FROM 
    nfl_standings_2022 AS st
LEFT JOIN 
    pass_off_2022 AS po ON st.tm = po.tm
LEFT JOIN 
    rush_off_2022 AS ro ON st.tm = ro.tm
LEFT JOIN
    pass_def_2022 AS pd ON st.tm = pd.tm
LEFT JOIN 
    rush_def_2022 AS rd ON st.tm = rd.tm
ORDER BY 
    W DESC
