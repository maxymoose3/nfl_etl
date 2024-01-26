
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
	2023 AS year,
    stnd."Tm" AS team,
	stnd."W" AS win,
	stnd."L" AS loss,
	stnd."T" AS tie,
	pass_o."Cmp%" AS comp_pct_o,
	pass_o."TD" AS pass_td_o,
	pass_o."Int" AS intr_o,
	pass_o."NY/A" AS pass_nypa_o,
	pass_o."Sk" AS sack_o,
	rush_o."TD" AS rush_td_o,
	rush_o."Y/A" AS rush_ypa_o,
	rush_o."Fmb" AS rush_fmb_o,
	pass_d."Cmp%" AS comp_pct_d,
	pass_d."TD" AS pass_td_d,
	pass_d."Int" AS intr_d,
	pass_d."NY/A" AS pass_nypa_d,
	pass_d."Sk" AS sack_d,
	rush_d."TD" AS rush_td_d,
	rush_d."Y/A" AS rush_ypa_d
FROM 
	nfl_etl.nfl_standings_2023 AS stnd
LEFT JOIN
	nfl_etl.pass_off_2023 AS pass_o
ON 
	stnd."Tm" = pass_o."Tm"
LEFT JOIN
	nfl_etl.rush_off_2023 AS rush_o
ON 
	stnd."Tm" = rush_o."Tm"
LEFT JOIN 
	nfl_etl.pass_def_2023 AS pass_d
ON 
	stnd."Tm" = pass_d."Tm"
LEFT JOIN
	nfl_etl.rush_def_2023 AS rush_d
ON 
	stnd."Tm" = rush_d."Tm"
UNION ALL
SELECT
	2022 AS year,
    stnd."Tm" AS team,
	stnd."W" AS win,
	stnd."L" AS loss,
	stnd."T" AS tie,
	pass_o."Cmp%" AS comp_pct_o,
	pass_o."TD" AS pass_td_o,
	pass_o."Int" AS intr_o,
	pass_o."NY/A" AS pass_nypa_o,
	pass_o."Sk" AS sack_o,
	rush_o."TD" AS rush_td_o,
	rush_o."Y/A" AS rush_ypa_o,
	rush_o."Fmb" AS rush_fmb_o,
	pass_d."Cmp%" AS comp_pct_d,
	pass_d."TD" AS pass_td_d,
	pass_d."Int" AS intr_d,
	pass_d."NY/A" AS pass_nypa_d,
	pass_d."Sk" AS sack_d,
	rush_d."TD" AS rush_td_d,
	rush_d."Y/A" AS rush_ypa_d
FROM 
	nfl_etl.nfl_standings_2022 AS stnd
LEFT JOIN
	nfl_etl.pass_off_2022 AS pass_o
ON 
	stnd."Tm" = pass_o."Tm"
LEFT JOIN
	nfl_etl.rush_off_2022 AS rush_o
ON 
	stnd."Tm" = rush_o."Tm"
LEFT JOIN 
	nfl_etl.pass_def_2022 AS pass_d
ON 
	stnd."Tm" = pass_d."Tm"
LEFT JOIN
	nfl_etl.rush_def_2022 AS rush_d
ON 
	stnd."Tm" = rush_d."Tm"
UNION ALL
SELECT
	2021 AS year,
    stnd."Tm" AS team,
	stnd."W" AS win,
	stnd."L" AS loss,
	stnd."T" AS tie,
	pass_o."Cmp%" AS comp_pct_o,
	pass_o."TD" AS pass_td_o,
	pass_o."Int" AS intr_o,
	pass_o."NY/A" AS pass_nypa_o,
	pass_o."Sk" AS sack_o,
	rush_o."TD" AS rush_td_o,
	rush_o."Y/A" AS rush_ypa_o,
	rush_o."Fmb" AS rush_fmb_o,
	pass_d."Cmp%" AS comp_pct_d,
	pass_d."TD" AS pass_td_d,
	pass_d."Int" AS intr_d,
	pass_d."NY/A" AS pass_nypa_d,
	pass_d."Sk" AS sack_d,
	rush_d."TD" AS rush_td_d,
	rush_d."Y/A" AS rush_ypa_d
FROM 
	nfl_etl.nfl_standings_2021 AS stnd
LEFT JOIN
	nfl_etl.pass_off_2021 AS pass_o
ON 
	stnd."Tm" = pass_o."Tm"
LEFT JOIN
	nfl_etl.rush_off_2021 AS rush_o
ON 
	stnd."Tm" = rush_o."Tm"
LEFT JOIN 
	nfl_etl.pass_def_2021 AS pass_d
ON 
	stnd."Tm" = pass_d."Tm"
LEFT JOIN
	nfl_etl.rush_def_2021 AS rush_d
ON 
	stnd."Tm" = rush_d."Tm"
UNION ALL
SELECT
	2020 AS year,
    stnd."Tm" AS team,
	stnd."W" AS win,
	stnd."L" AS loss,
	stnd."T" AS tie,
	pass_o."Cmp%" AS comp_pct_o,
	pass_o."TD" AS pass_td_o,
	pass_o."Int" AS intr_o,
	pass_o."NY/A" AS pass_nypa_o,
	pass_o."Sk" AS sack_o,
	rush_o."TD" AS rush_td_o,
	rush_o."Y/A" AS rush_ypa_o,
	rush_o."Fmb" AS rush_fmb_o,
	pass_d."Cmp%" AS comp_pct_d,
	pass_d."TD" AS pass_td_d,
	pass_d."Int" AS intr_d,
	pass_d."NY/A" AS pass_nypa_d,
	pass_d."Sk" AS sack_d,
	rush_d."TD" AS rush_td_d,
	rush_d."Y/A" AS rush_ypa_d
FROM 
	nfl_etl.nfl_standings_2020 AS stnd
LEFT JOIN
	nfl_etl.pass_off_2020 AS pass_o
ON 
	stnd."Tm" = pass_o."Tm"
LEFT JOIN
	nfl_etl.rush_off_2020 AS rush_o
ON 
	stnd."Tm" = rush_o."Tm"
LEFT JOIN 
	nfl_etl.pass_def_2020 AS pass_d
ON 
	stnd."Tm" = pass_d."Tm"
LEFT JOIN
	nfl_etl.rush_def_2020 AS rush_d
ON 
	stnd."Tm" = rush_d."Tm"
UNION ALL
SELECT
	2019 AS year,
    stnd."Tm" AS team,
	stnd."W" AS win,
	stnd."L" AS loss,
	stnd."T" AS tie,
	pass_o."Cmp%" AS comp_pct_o,
	pass_o."TD" AS pass_td_o,
	pass_o."Int" AS intr_o,
	pass_o."NY/A" AS pass_nypa_o,
	pass_o."Sk" AS sack_o,
	rush_o."TD" AS rush_td_o,
	rush_o."Y/A" AS rush_ypa_o,
	rush_o."Fmb" AS rush_fmb_o,
	pass_d."Cmp%" AS comp_pct_d,
	pass_d."TD" AS pass_td_d,
	pass_d."Int" AS intr_d,
	pass_d."NY/A" AS pass_nypa_d,
	pass_d."Sk" AS sack_d,
	rush_d."TD" AS rush_td_d,
	rush_d."Y/A" AS rush_ypa_d
FROM 
	nfl_etl.nfl_standings_2019 AS stnd
LEFT JOIN
	nfl_etl.pass_off_2019 AS pass_o
ON 
	stnd."Tm" = pass_o."Tm"
LEFT JOIN
	nfl_etl.rush_off_2019 AS rush_o
ON 
	stnd."Tm" = rush_o."Tm"
LEFT JOIN 
	nfl_etl.pass_def_2019 AS pass_d
ON 
	stnd."Tm" = pass_d."Tm"
LEFT JOIN
	nfl_etl.rush_def_2019 AS rush_d
ON 
	stnd."Tm" = rush_d."Tm"
UNION ALL
SELECT
	2018 AS year,
    stnd."Tm" AS team,
	stnd."W" AS win,
	stnd."L" AS loss,
	stnd."T" AS tie,
	pass_o."Cmp%" AS comp_pct_o,
	pass_o."TD" AS pass_td_o,
	pass_o."Int" AS intr_o,
	pass_o."NY/A" AS pass_nypa_o,
	pass_o."Sk" AS sack_o,
	rush_o."TD" AS rush_td_o,
	rush_o."Y/A" AS rush_ypa_o,
	rush_o."Fmb" AS rush_fmb_o,
	pass_d."Cmp%" AS comp_pct_d,
	pass_d."TD" AS pass_td_d,
	pass_d."Int" AS intr_d,
	pass_d."NY/A" AS pass_nypa_d,
	pass_d."Sk" AS sack_d,
	rush_d."TD" AS rush_td_d,
	rush_d."Y/A" AS rush_ypa_d
FROM 
	nfl_etl.nfl_standings_2018 AS stnd
LEFT JOIN
	nfl_etl.pass_off_2018 AS pass_o
ON 
	stnd."Tm" = pass_o."Tm"
LEFT JOIN
	nfl_etl.rush_off_2018 AS rush_o
ON 
	stnd."Tm" = rush_o."Tm"
LEFT JOIN 
	nfl_etl.pass_def_2018 AS pass_d
ON 
	stnd."Tm" = pass_d."Tm"
LEFT JOIN
	nfl_etl.rush_def_2018 AS rush_d
ON 
	stnd."Tm" = rush_d."Tm"
ORDER BY 
    year DESC, 
	team ASC
