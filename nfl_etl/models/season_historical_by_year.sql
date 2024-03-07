SELECT
	2023 AS year,
    stnd."Tm" AS team,
	stnd."W" AS win,
	stnd."L" AS loss,
	stnd."T" AS tie,
	stnd."PD" AS margin,
	CAST(team_o."Cmp" AS FLOAT) / team_o."P_Att" AS "o_comp_%",
	team_o."P_TD" AS "o_pass_td",
	team_o."NY/A" AS "o_pass_ny/a",
	pass_o."Sk" AS "o_sack",
	-- air."CAY" AS "o_air_y",
	-- CAST(acc."BadTh" AS FLOAT) / (acc."Att" - (acc."ThAwy" + acc."Spikes")) AS "o_bad_%",
	-- rec_adv."YAC/R" AS "o_rec_yac/r",
	-- rec_adv."Rec/Br" AS "o_rec/bt",
	-- rec_adv."Drop%" AS "o_rec_drp/tgt",
	team_o."R_TD" AS "o_rush_td",
	team_o."Y/A" AS "o_rush_y/a",
	-- rush_adv."YAC/Att" AS "o_rush_yac/a",
	-- rush_adv."Att/Br" AS "o_rush_a/bt",
	team_o."Int" AS "o_int",
	team_o."TO" - team_o."Int" AS "o_fmb_lost",
	CAST(pass_d."Cmp" AS FLOAT) / pass_d."Att" AS "d_comp_%",
	team_d."P_TD" AS "d_pass_td",
	team_d."NY/A" AS "d_pass_ny/a",
	pass_d."Sk" AS "d_sack",
	-- d_adv."Air" AS "d_air_y",
	-- CAST(d_adv."YAC" AS FLOAT) / d_adv."Cmp" AS "d_rec_yac/c",
	team_d."R_TD" AS "d_rush_td",
	team_d."Y/A" AS "d_rush_y/a",
	team_d."Int" AS "d_int",
	team_d."TO" - team_d."Int" AS "d_fmb_rec"
	-- d_adv."MTkl" AS "miss_tkl"
FROM 
	nfl_etl.nfl_standings_2023 AS stnd
LEFT JOIN 
	nfl_etl.team_off_2023 AS team_o
ON
	stnd."Tm" = team_o."Tm"
LEFT JOIN
	nfl_etl.pass_off_2023 AS pass_o
ON 
	stnd."Tm" = pass_o."Tm"
LEFT JOIN
	nfl_etl.air_yards_2023 AS air
ON 
	stnd."Tm" = air."Tm"
LEFT JOIN
	nfl_etl.accuracy_2023 AS acc
ON 
	stnd."Tm" = acc."Tm"
LEFT JOIN
	nfl_etl.rush_off_2023 AS rush_o
ON 
	stnd."Tm" = rush_o."Tm"
LEFT JOIN
	nfl_etl.rush_off_adv_2023 AS rush_adv
ON 
	stnd."Tm" = rush_adv."Tm"
LEFT JOIN
	nfl_etl.rec_off_adv_2023 AS rec_adv
ON 
	stnd."Tm" = rec_adv."Tm"
LEFT JOIN 
	nfl_etl.team_def_2023 AS team_d
ON
	stnd."Tm" = team_d."Tm"
LEFT JOIN 
	nfl_etl.pass_def_2023 AS pass_d
ON 
	stnd."Tm" = pass_d."Tm"
LEFT JOIN
	nfl_etl.rush_def_2023 AS rush_d
ON 
	stnd."Tm" = rush_d."Tm"
LEFT JOIN
	nfl_etl.def_adv_2023 AS d_adv
ON 
	stnd."Tm" = d_adv."Tm"

UNION ALL
SELECT
	2022 AS year,
    stnd."Tm" AS team,
	stnd."W" AS win,
	stnd."L" AS loss,
	stnd."T" AS tie,
	stnd."PD" AS margin,
	CAST(team_o."Cmp" AS FLOAT) / team_o."P_Att" AS "o_comp_%",
	team_o."P_TD" AS "o_pass_td",
	team_o."NY/A" AS "o_pass_ny/a",
	pass_o."Sk" AS "o_sack",
	-- air."CAY" AS "o_air_y",
	-- CAST(acc."BadTh" AS FLOAT) / (acc."Att" - (acc."ThAwy" + acc."Spikes")) AS "o_bad_%",
	-- rec_adv."YAC/R" AS "o_rec_yac/r",
	-- rec_adv."Rec/Br" AS "o_rec/bt",
	-- rec_adv."Drop%" AS "o_rec_drp/tgt",
	team_o."R_TD" AS "o_rush_td",
	team_o."Y/A" AS "o_rush_y/a",
	-- rush_adv."YAC/Att" AS "o_rush_yac/a",
	-- rush_adv."Att/Br" AS "o_rush_a/bt",
	team_o."Int" AS "o_int",
	team_o."TO" - team_o."Int" AS "o_fmb_lost",
	CAST(pass_d."Cmp" AS FLOAT) / pass_d."Att" AS "d_comp_%",
	team_d."P_TD" AS "d_pass_td",
	team_d."NY/A" AS "d_pass_ny/a",
	pass_d."Sk" AS "d_sack",
	-- d_adv."Air" AS "d_air_y",
	-- CAST(d_adv."YAC" AS FLOAT) / d_adv."Cmp" AS "d_rec_yac/c",
	team_d."R_TD" AS "d_rush_td",
	team_d."Y/A" AS "d_rush_y/a",
	team_d."Int" AS "d_int",
	team_d."TO" - team_d."Int" AS "d_fmb_rec"
	-- d_adv."MTkl" AS "miss_tkl"
FROM 
	nfl_etl.nfl_standings_2022 AS stnd
LEFT JOIN 
	nfl_etl.team_off_2022 AS team_o
ON
	stnd."Tm" = team_o."Tm"
LEFT JOIN
	nfl_etl.pass_off_2022 AS pass_o
ON 
	stnd."Tm" = pass_o."Tm"
LEFT JOIN
	nfl_etl.air_yards_2022 AS air
ON 
	stnd."Tm" = air."Tm"
LEFT JOIN
	nfl_etl.accuracy_2022 AS acc
ON 
	stnd."Tm" = acc."Tm"
LEFT JOIN
	nfl_etl.rush_off_2022 AS rush_o
ON 
	stnd."Tm" = rush_o."Tm"
LEFT JOIN
	nfl_etl.rush_off_adv_2022 AS rush_adv
ON 
	stnd."Tm" = rush_adv."Tm"
LEFT JOIN
	nfl_etl.rec_off_adv_2022 AS rec_adv
ON 
	stnd."Tm" = rec_adv."Tm"
LEFT JOIN 
	nfl_etl.team_def_2022 AS team_d
ON
	stnd."Tm" = team_d."Tm"
LEFT JOIN 
	nfl_etl.pass_def_2022 AS pass_d
ON 
	stnd."Tm" = pass_d."Tm"
LEFT JOIN
	nfl_etl.rush_def_2022 AS rush_d
ON 
	stnd."Tm" = rush_d."Tm"
LEFT JOIN
	nfl_etl.def_adv_2022 AS d_adv
ON 
	stnd."Tm" = d_adv."Tm"
UNION ALL
SELECT
	2021 AS year,
    stnd."Tm" AS team,
	stnd."W" AS win,
	stnd."L" AS loss,
	stnd."T" AS tie,
	stnd."PD" AS margin,
	CAST(team_o."Cmp" AS FLOAT) / team_o."P_Att" AS "o_comp_%",
	team_o."P_TD" AS "o_pass_td",
	team_o."NY/A" AS "o_pass_ny/a",
	pass_o."Sk" AS "o_sack",
	-- air."CAY" AS "o_air_y",
	-- CAST(acc."BadTh" AS FLOAT) / (acc."Att" - (acc."ThAwy" + acc."Spikes")) AS "o_bad_%",
	-- rec_adv."YAC/R" AS "o_rec_yac/r",
	-- rec_adv."Rec/Br" AS "o_rec/bt",
	-- rec_adv."Drop%" AS "o_rec_drp/tgt",
	team_o."R_TD" AS "o_rush_td",
	team_o."Y/A" AS "o_rush_y/a",
	-- rush_adv."YAC/Att" AS "o_rush_yac/a",
	-- rush_adv."Att/Br" AS "o_rush_a/bt",
	team_o."Int" AS "o_int",
	team_o."TO" - team_o."Int" AS "o_fmb_lost",
	CAST(pass_d."Cmp" AS FLOAT) / pass_d."Att" AS "d_comp_%",
	team_d."P_TD" AS "d_pass_td",
	team_d."NY/A" AS "d_pass_ny/a",
	pass_d."Sk" AS "d_sack",
	-- d_adv."Air" AS "d_air_y",
	-- CAST(d_adv."YAC" AS FLOAT) / d_adv."Cmp" AS "d_rec_yac/c",
	team_d."R_TD" AS "d_rush_td",
	team_d."Y/A" AS "d_rush_y/a",
	team_d."Int" AS "d_int",
	team_d."TO" - team_d."Int" AS "d_fmb_rec"
	-- d_adv."MTkl" AS "miss_tkl"
FROM 
	nfl_etl.nfl_standings_2021 AS stnd
LEFT JOIN 
	nfl_etl.team_off_2021 AS team_o
ON
	stnd."Tm" = team_o."Tm"
LEFT JOIN
	nfl_etl.pass_off_2021 AS pass_o
ON 
	stnd."Tm" = pass_o."Tm"
LEFT JOIN
	nfl_etl.air_yards_2021 AS air
ON 
	stnd."Tm" = air."Tm"
LEFT JOIN
	nfl_etl.accuracy_2021 AS acc
ON 
	stnd."Tm" = acc."Tm"
LEFT JOIN
	nfl_etl.rush_off_2021 AS rush_o
ON 
	stnd."Tm" = rush_o."Tm"
LEFT JOIN
	nfl_etl.rush_off_adv_2021 AS rush_adv
ON 
	stnd."Tm" = rush_adv."Tm"
LEFT JOIN
	nfl_etl.rec_off_adv_2021 AS rec_adv
ON 
	stnd."Tm" = rec_adv."Tm"
LEFT JOIN 
	nfl_etl.team_def_2021 AS team_d
ON
	stnd."Tm" = team_d."Tm"
LEFT JOIN 
	nfl_etl.pass_def_2021 AS pass_d
ON 
	stnd."Tm" = pass_d."Tm"
LEFT JOIN
	nfl_etl.rush_def_2021 AS rush_d
ON 
	stnd."Tm" = rush_d."Tm"
LEFT JOIN
	nfl_etl.def_adv_2021 AS d_adv
ON 
	stnd."Tm" = d_adv."Tm"
UNION ALL
SELECT
	2020 AS year,
    stnd."Tm" AS team,
	stnd."W" AS win,
	stnd."L" AS loss,
	stnd."T" AS tie,
	stnd."PD" AS margin,
	CAST(team_o."Cmp" AS FLOAT) / team_o."P_Att" AS "o_comp_%",
	team_o."P_TD" AS "o_pass_td",
	team_o."NY/A" AS "o_pass_ny/a",
	pass_o."Sk" AS "o_sack",
	-- air."CAY" AS "o_air_y",
	-- CAST(acc."BadTh" AS FLOAT) / (acc."Att" - (acc."ThAwy" + acc."Spikes")) AS "o_bad_%",
	-- rec_adv."YAC/R" AS "o_rec_yac/r",
	-- rec_adv."Rec/Br" AS "o_rec/bt",
	-- rec_adv."Drop%" AS "o_rec_drp/tgt",
	team_o."R_TD" AS "o_rush_td",
	team_o."Y/A" AS "o_rush_y/a",
	-- rush_adv."YAC/Att" AS "o_rush_yac/a",
	-- rush_adv."Att/Br" AS "o_rush_a/bt",
	team_o."Int" AS "o_int",
	team_o."TO" - team_o."Int" AS "o_fmb_lost",
	CAST(pass_d."Cmp" AS FLOAT) / pass_d."Att" AS "d_comp_%",
	team_d."P_TD" AS "d_pass_td",
	team_d."NY/A" AS "d_pass_ny/a",
	pass_d."Sk" AS "d_sack",
	-- d_adv."Air" AS "d_air_y",
	-- CAST(d_adv."YAC" AS FLOAT) / d_adv."Cmp" AS "d_rec_yac/c",
	team_d."R_TD" AS "d_rush_td",
	team_d."Y/A" AS "d_rush_y/a",
	team_d."Int" AS "d_int",
	team_d."TO" - team_d."Int" AS "d_fmb_rec"
	-- d_adv."MTkl" AS "miss_tkl"
FROM 
	nfl_etl.nfl_standings_2020 AS stnd
LEFT JOIN 
	nfl_etl.team_off_2020 AS team_o
ON
	stnd."Tm" = team_o."Tm"
LEFT JOIN
	nfl_etl.pass_off_2020 AS pass_o
ON 
	stnd."Tm" = pass_o."Tm"
LEFT JOIN
	nfl_etl.air_yards_2020 AS air
ON 
	stnd."Tm" = air."Tm"
LEFT JOIN
	nfl_etl.accuracy_2020 AS acc
ON 
	stnd."Tm" = acc."Tm"
LEFT JOIN
	nfl_etl.rush_off_2020 AS rush_o
ON 
	stnd."Tm" = rush_o."Tm"
LEFT JOIN
	nfl_etl.rush_off_adv_2020 AS rush_adv
ON 
	stnd."Tm" = rush_adv."Tm"
LEFT JOIN
	nfl_etl.rec_off_adv_2020 AS rec_adv
ON 
	stnd."Tm" = rec_adv."Tm"
LEFT JOIN 
	nfl_etl.team_def_2020 AS team_d
ON
	stnd."Tm" = team_d."Tm"
LEFT JOIN 
	nfl_etl.pass_def_2020 AS pass_d
ON 
	stnd."Tm" = pass_d."Tm"
LEFT JOIN
	nfl_etl.rush_def_2020 AS rush_d
ON 
	stnd."Tm" = rush_d."Tm"
LEFT JOIN
	nfl_etl.def_adv_2020 AS d_adv
ON 
	stnd."Tm" = d_adv."Tm"
UNION ALL
SELECT
	2019 AS year,
   stnd."Tm" AS team,
	stnd."W" AS win,
	stnd."L" AS loss,
	stnd."T" AS tie,
	stnd."PD" AS margin,
	CAST(team_o."Cmp" AS FLOAT) / team_o."P_Att" AS "o_comp_%",
	team_o."P_TD" AS "o_pass_td",
	team_o."NY/A" AS "o_pass_ny/a",
	pass_o."Sk" AS "o_sack",
	-- air."CAY" AS "o_air_y",
	-- CAST(acc."BadTh" AS FLOAT) / (acc."Att" - (acc."ThAwy" + acc."Spikes")) AS "o_bad_%",
	-- rec_adv."YAC/R" AS "o_rec_yac/r",
	-- rec_adv."Rec/Br" AS "o_rec/bt",
	-- rec_adv."Drop%" AS "o_rec_drp/tgt",
	team_o."R_TD" AS "o_rush_td",
	team_o."Y/A" AS "o_rush_y/a",
	-- rush_adv."YAC/Att" AS "o_rush_yac/a",
	-- rush_adv."Att/Br" AS "o_rush_a/bt",
	team_o."Int" AS "o_int",
	team_o."TO" - team_o."Int" AS "o_fmb_lost",
	CAST(pass_d."Cmp" AS FLOAT) / pass_d."Att" AS "d_comp_%",
	team_d."P_TD" AS "d_pass_td",
	team_d."NY/A" AS "d_pass_ny/a",
	pass_d."Sk" AS "d_sack",
	-- d_adv."Air" AS "d_air_y",
	-- CAST(d_adv."YAC" AS FLOAT) / d_adv."Cmp" AS "d_rec_yac/c",
	team_d."R_TD" AS "d_rush_td",
	team_d."Y/A" AS "d_rush_y/a",
	team_d."Int" AS "d_int",
	team_d."TO" - team_d."Int" AS "d_fmb_rec"
	-- d_adv."MTkl" AS "miss_tkl"
FROM 
	nfl_etl.nfl_standings_2019 AS stnd
LEFT JOIN 
	nfl_etl.team_off_2019 AS team_o
ON
	stnd."Tm" = team_o."Tm"
LEFT JOIN
	nfl_etl.pass_off_2019 AS pass_o
ON 
	stnd."Tm" = pass_o."Tm"
LEFT JOIN
	nfl_etl.air_yards_2019 AS air
ON 
	stnd."Tm" = air."Tm"
LEFT JOIN
	nfl_etl.accuracy_2019 AS acc
ON 
	stnd."Tm" = acc."Tm"
LEFT JOIN
	nfl_etl.rush_off_2019 AS rush_o
ON 
	stnd."Tm" = rush_o."Tm"
LEFT JOIN
	nfl_etl.rush_off_adv_2019 AS rush_adv
ON 
	stnd."Tm" = rush_adv."Tm"
LEFT JOIN
	nfl_etl.rec_off_adv_2019 AS rec_adv
ON 
	stnd."Tm" = rec_adv."Tm"
LEFT JOIN 
	nfl_etl.team_def_2019 AS team_d
ON
	stnd."Tm" = team_d."Tm"
LEFT JOIN 
	nfl_etl.pass_def_2019 AS pass_d
ON 
	stnd."Tm" = pass_d."Tm"
LEFT JOIN
	nfl_etl.rush_def_2019 AS rush_d
ON 
	stnd."Tm" = rush_d."Tm"
LEFT JOIN
	nfl_etl.def_adv_2019 AS d_adv
ON 
	stnd."Tm" = d_adv."Tm"
UNION ALL
SELECT
	2018 AS year,
    stnd."Tm" AS team,
	stnd."W" AS win,
	stnd."L" AS loss,
	stnd."T" AS tie,
	stnd."PD" AS margin,
	CAST(team_o."Cmp" AS FLOAT) / team_o."P_Att" AS "o_comp_%",
	team_o."P_TD" AS "o_pass_td",
	team_o."NY/A" AS "o_pass_ny/a",
	pass_o."Sk" AS "o_sack",
	-- air."CAY" AS "o_air_y",
	-- CAST(acc."BadTh" AS FLOAT) / (acc."Att" - (acc."ThAwy" + acc."Spikes")) AS "o_bad_%",
	-- rec_adv."YAC/R" AS "o_rec_yac/r",
	-- rec_adv."Rec/Br" AS "o_rec/bt",
	-- rec_adv."Drop%" AS "o_rec_drp/tgt",
	team_o."R_TD" AS "o_rush_td",
	team_o."Y/A" AS "o_rush_y/a",
	-- rush_adv."YAC/Att" AS "o_rush_yac/a",
	-- rush_adv."Att/Br" AS "o_rush_a/bt",
	team_o."Int" AS "o_int",
	team_o."TO" - team_o."Int" AS "o_fmb_lost",
	CAST(pass_d."Cmp" AS FLOAT) / pass_d."Att" AS "d_comp_%",
	team_d."P_TD" AS "d_pass_td",
	team_d."NY/A" AS "d_pass_ny/a",
	pass_d."Sk" AS "d_sack",
	-- d_adv."Air" AS "d_air_y",
	-- CAST(d_adv."YAC" AS FLOAT) / d_adv."Cmp" AS "d_rec_yac/c",
	team_d."R_TD" AS "d_rush_td",
	team_d."Y/A" AS "d_rush_y/a",
	team_d."Int" AS "d_int",
	team_d."TO" - team_d."Int" AS "d_fmb_rec"
	-- d_adv."MTkl" AS "miss_tkl"
FROM 
	nfl_etl.nfl_standings_2018 AS stnd
LEFT JOIN 
	nfl_etl.team_off_2018 AS team_o
ON
	stnd."Tm" = team_o."Tm"
LEFT JOIN
	nfl_etl.pass_off_2018 AS pass_o
ON 
	stnd."Tm" = pass_o."Tm"
LEFT JOIN
	nfl_etl.air_yards_2018 AS air
ON 
	stnd."Tm" = air."Tm"
LEFT JOIN
	nfl_etl.accuracy_2018 AS acc
ON 
	stnd."Tm" = acc."Tm"
LEFT JOIN
	nfl_etl.rush_off_2018 AS rush_o
ON 
	stnd."Tm" = rush_o."Tm"
LEFT JOIN
	nfl_etl.rush_off_adv_2018 AS rush_adv
ON 
	stnd."Tm" = rush_adv."Tm"
LEFT JOIN
	nfl_etl.rec_off_adv_2018 AS rec_adv
ON 
	stnd."Tm" = rec_adv."Tm"
LEFT JOIN 
	nfl_etl.team_def_2018 AS team_d
ON
	stnd."Tm" = team_d."Tm"
LEFT JOIN 
	nfl_etl.pass_def_2018 AS pass_d
ON 
	stnd."Tm" = pass_d."Tm"
LEFT JOIN
	nfl_etl.rush_def_2018 AS rush_d
ON 
	stnd."Tm" = rush_d."Tm"
LEFT JOIN
	nfl_etl.def_adv_2018 AS d_adv
ON 
	stnd."Tm" = d_adv."Tm"
UNION ALL
SELECT
	2017 AS year,
    stnd."Tm" AS team,
	stnd."W" AS win,
	stnd."L" AS loss,
	stnd."T" AS tie,
	stnd."PD" AS margin,
	CAST(team_o."Cmp" AS FLOAT) / team_o."P_Att" AS "o_comp_%",
	team_o."P_TD" AS "o_pass_td",
	team_o."NY/A" AS "o_pass_ny/a",
	pass_o."Sk" AS "o_sack",
	-- air."CAY" AS "o_air_y",
	-- CAST(acc."BadTh" AS FLOAT) / (acc."Att" - (acc."ThAwy" + acc."Spikes")) AS "o_bad_%",
	-- rec_adv."YAC/R" AS "o_rec_yac/r",
	-- rec_adv."Rec/Br" AS "o_rec/bt",
	-- rec_adv."Drop%" AS "o_rec_drp/tgt",
	team_o."R_TD" AS "o_rush_td",
	team_o."Y/A" AS "o_rush_y/a",
	-- rush_adv."YAC/Att" AS "o_rush_yac/a",
	-- rush_adv."Att/Br" AS "o_rush_a/bt",
	team_o."Int" AS "o_int",
	team_o."TO" - team_o."Int" AS "o_fmb_lost",
	CAST(pass_d."Cmp" AS FLOAT) / pass_d."Att" AS "d_comp_%",
	team_d."P_TD" AS "d_pass_td",
	team_d."NY/A" AS "d_pass_ny/a",
	pass_d."Sk" AS "d_sack",
	-- d_adv."Air" AS "d_air_y",
	-- CAST(d_adv."YAC" AS FLOAT) / d_adv."Cmp" AS "d_rec_yac/c",
	team_d."R_TD" AS "d_rush_td",
	team_d."Y/A" AS "d_rush_y/a",
	team_d."Int" AS "d_int",
	team_d."TO" - team_d."Int" AS "d_fmb_rec"
	-- d_adv."MTkl" AS "miss_tkl"
FROM 
	nfl_etl.nfl_standings_2017 AS stnd
LEFT JOIN 
	nfl_etl.team_off_2017 AS team_o
ON
	stnd."Tm" = team_o."Tm"
LEFT JOIN
	nfl_etl.pass_off_2017 AS pass_o
ON 
	stnd."Tm" = pass_o."Tm"
-- LEFT JOIN
-- 	nfl_etl.air_yards_2018 AS air
-- ON 
-- 	stnd."Tm" = air."Tm"
-- LEFT JOIN
-- 	nfl_etl.accuracy_2018 AS acc
-- ON 
-- 	stnd."Tm" = acc."Tm"
-- LEFT JOIN
-- 	nfl_etl.rush_off_2018 AS rush_o
-- ON 
-- 	stnd."Tm" = rush_o."Tm"
-- LEFT JOIN
-- 	nfl_etl.rush_off_adv_2018 AS rush_adv
-- ON 
-- 	stnd."Tm" = rush_adv."Tm"
-- LEFT JOIN
-- 	nfl_etl.rec_off_adv_2018 AS rec_adv
-- ON 
-- 	stnd."Tm" = rec_adv."Tm"
LEFT JOIN 
	nfl_etl.team_def_2017 AS team_d
ON
	stnd."Tm" = team_d."Tm"
LEFT JOIN 
	nfl_etl.pass_def_2017 AS pass_d
ON 
	stnd."Tm" = pass_d."Tm"
LEFT JOIN
	nfl_etl.rush_def_2017 AS rush_d
ON 
	stnd."Tm" = rush_d."Tm"
-- LEFT JOIN
-- 	nfl_etl.def_adv_2018 AS d_adv
-- ON 
-- 	stnd."Tm" = d_adv."Tm"
UNION ALL
SELECT
	2016 AS year,
    stnd."Tm" AS team,
	stnd."W" AS win,
	stnd."L" AS loss,
	stnd."T" AS tie,
	stnd."PD" AS margin,
	CAST(team_o."Cmp" AS FLOAT) / team_o."P_Att" AS "o_comp_%",
	team_o."P_TD" AS "o_pass_td",
	team_o."NY/A" AS "o_pass_ny/a",
	pass_o."Sk" AS "o_sack",
	-- air."CAY" AS "o_air_y",
	-- CAST(acc."BadTh" AS FLOAT) / (acc."Att" - (acc."ThAwy" + acc."Spikes")) AS "o_bad_%",
	-- rec_adv."YAC/R" AS "o_rec_yac/r",
	-- rec_adv."Rec/Br" AS "o_rec/bt",
	-- rec_adv."Drop%" AS "o_rec_drp/tgt",
	team_o."R_TD" AS "o_rush_td",
	team_o."Y/A" AS "o_rush_y/a",
	-- rush_adv."YAC/Att" AS "o_rush_yac/a",
	-- rush_adv."Att/Br" AS "o_rush_a/bt",
	team_o."Int" AS "o_int",
	team_o."TO" - team_o."Int" AS "o_fmb_lost",
	CAST(pass_d."Cmp" AS FLOAT) / pass_d."Att" AS "d_comp_%",
	team_d."P_TD" AS "d_pass_td",
	team_d."NY/A" AS "d_pass_ny/a",
	pass_d."Sk" AS "d_sack",
	-- d_adv."Air" AS "d_air_y",
	-- CAST(d_adv."YAC" AS FLOAT) / d_adv."Cmp" AS "d_rec_yac/c",
	team_d."R_TD" AS "d_rush_td",
	team_d."Y/A" AS "d_rush_y/a",
	team_d."Int" AS "d_int",
	team_d."TO" - team_d."Int" AS "d_fmb_rec"
	-- d_adv."MTkl" AS "miss_tkl"
FROM 
	nfl_etl.nfl_standings_2016 AS stnd
LEFT JOIN 
	nfl_etl.team_off_2016 AS team_o
ON
	stnd."Tm" = team_o."Tm"
LEFT JOIN
	nfl_etl.pass_off_2016 AS pass_o
ON 
	stnd."Tm" = pass_o."Tm"
-- LEFT JOIN
-- 	nfl_etl.air_yards_2018 AS air
-- ON 
-- 	stnd."Tm" = air."Tm"
-- LEFT JOIN
-- 	nfl_etl.accuracy_2018 AS acc
-- ON 
-- 	stnd."Tm" = acc."Tm"
-- LEFT JOIN
-- 	nfl_etl.rush_off_2018 AS rush_o
-- ON 
-- 	stnd."Tm" = rush_o."Tm"
-- LEFT JOIN
-- 	nfl_etl.rush_off_adv_2018 AS rush_adv
-- ON 
-- 	stnd."Tm" = rush_adv."Tm"
-- LEFT JOIN
-- 	nfl_etl.rec_off_adv_2018 AS rec_adv
-- ON 
-- 	stnd."Tm" = rec_adv."Tm"
LEFT JOIN 
	nfl_etl.team_def_2016 AS team_d
ON
	stnd."Tm" = team_d."Tm"
LEFT JOIN 
	nfl_etl.pass_def_2016 AS pass_d
ON 
	stnd."Tm" = pass_d."Tm"
LEFT JOIN
	nfl_etl.rush_def_2016 AS rush_d
ON 
	stnd."Tm" = rush_d."Tm"
UNION ALL
SELECT
	2015 AS year,
    stnd."Tm" AS team,
	stnd."W" AS win,
	stnd."L" AS loss,
	stnd."T" AS tie,
	stnd."PD" AS margin,
	CAST(team_o."Cmp" AS FLOAT) / team_o."P_Att" AS "o_comp_%",
	team_o."P_TD" AS "o_pass_td",
	team_o."NY/A" AS "o_pass_ny/a",
	pass_o."Sk" AS "o_sack",
	-- air."CAY" AS "o_air_y",
	-- CAST(acc."BadTh" AS FLOAT) / (acc."Att" - (acc."ThAwy" + acc."Spikes")) AS "o_bad_%",
	-- rec_adv."YAC/R" AS "o_rec_yac/r",
	-- rec_adv."Rec/Br" AS "o_rec/bt",
	-- rec_adv."Drop%" AS "o_rec_drp/tgt",
	team_o."R_TD" AS "o_rush_td",
	team_o."Y/A" AS "o_rush_y/a",
	-- rush_adv."YAC/Att" AS "o_rush_yac/a",
	-- rush_adv."Att/Br" AS "o_rush_a/bt",
	team_o."Int" AS "o_int",
	team_o."TO" - team_o."Int" AS "o_fmb_lost",
	CAST(pass_d."Cmp" AS FLOAT) / pass_d."Att" AS "d_comp_%",
	team_d."P_TD" AS "d_pass_td",
	team_d."NY/A" AS "d_pass_ny/a",
	pass_d."Sk" AS "d_sack",
	-- d_adv."Air" AS "d_air_y",
	-- CAST(d_adv."YAC" AS FLOAT) / d_adv."Cmp" AS "d_rec_yac/c",
	team_d."R_TD" AS "d_rush_td",
	team_d."Y/A" AS "d_rush_y/a",
	team_d."Int" AS "d_int",
	team_d."TO" - team_d."Int" AS "d_fmb_rec"
	-- d_adv."MTkl" AS "miss_tkl"
FROM 
	nfl_etl.nfl_standings_2015 AS stnd
LEFT JOIN 
	nfl_etl.team_off_2015 AS team_o
ON
	stnd."Tm" = team_o."Tm"
LEFT JOIN
	nfl_etl.pass_off_2015 AS pass_o
ON 
	stnd."Tm" = pass_o."Tm"
-- LEFT JOIN
-- 	nfl_etl.air_yards_2018 AS air
-- ON 
-- 	stnd."Tm" = air."Tm"
-- LEFT JOIN
-- 	nfl_etl.accuracy_2018 AS acc
-- ON 
-- 	stnd."Tm" = acc."Tm"
-- LEFT JOIN
-- 	nfl_etl.rush_off_2018 AS rush_o
-- ON 
-- 	stnd."Tm" = rush_o."Tm"
-- LEFT JOIN
-- 	nfl_etl.rush_off_adv_2018 AS rush_adv
-- ON 
-- 	stnd."Tm" = rush_adv."Tm"
-- LEFT JOIN
-- 	nfl_etl.rec_off_adv_2018 AS rec_adv
-- ON 
-- 	stnd."Tm" = rec_adv."Tm"
LEFT JOIN 
	nfl_etl.team_def_2015 AS team_d
ON
	stnd."Tm" = team_d."Tm"
LEFT JOIN 
	nfl_etl.pass_def_2015 AS pass_d
ON 
	stnd."Tm" = pass_d."Tm"
LEFT JOIN
	nfl_etl.rush_def_2015 AS rush_d
ON 
	stnd."Tm" = rush_d."Tm"
UNION ALL
SELECT
	2014 AS year,
    stnd."Tm" AS team,
	stnd."W" AS win,
	stnd."L" AS loss,
	stnd."T" AS tie,
	stnd."PD" AS margin,
	CAST(team_o."Cmp" AS FLOAT) / team_o."P_Att" AS "o_comp_%",
	team_o."P_TD" AS "o_pass_td",
	team_o."NY/A" AS "o_pass_ny/a",
	pass_o."Sk" AS "o_sack",
	-- air."CAY" AS "o_air_y",
	-- CAST(acc."BadTh" AS FLOAT) / (acc."Att" - (acc."ThAwy" + acc."Spikes")) AS "o_bad_%",
	-- rec_adv."YAC/R" AS "o_rec_yac/r",
	-- rec_adv."Rec/Br" AS "o_rec/bt",
	-- rec_adv."Drop%" AS "o_rec_drp/tgt",
	team_o."R_TD" AS "o_rush_td",
	team_o."Y/A" AS "o_rush_y/a",
	-- rush_adv."YAC/Att" AS "o_rush_yac/a",
	-- rush_adv."Att/Br" AS "o_rush_a/bt",
	team_o."Int" AS "o_int",
	team_o."TO" - team_o."Int" AS "o_fmb_lost",
	CAST(pass_d."Cmp" AS FLOAT) / pass_d."Att" AS "d_comp_%",
	team_d."P_TD" AS "d_pass_td",
	team_d."NY/A" AS "d_pass_ny/a",
	pass_d."Sk" AS "d_sack",
	-- d_adv."Air" AS "d_air_y",
	-- CAST(d_adv."YAC" AS FLOAT) / d_adv."Cmp" AS "d_rec_yac/c",
	team_d."R_TD" AS "d_rush_td",
	team_d."Y/A" AS "d_rush_y/a",
	team_d."Int" AS "d_int",
	team_d."TO" - team_d."Int" AS "d_fmb_rec"
	-- d_adv."MTkl" AS "miss_tkl"
FROM 
	nfl_etl.nfl_standings_2014 AS stnd
LEFT JOIN 
	nfl_etl.team_off_2014 AS team_o
ON
	stnd."Tm" = team_o."Tm"
LEFT JOIN
	nfl_etl.pass_off_2014 AS pass_o
ON 
	stnd."Tm" = pass_o."Tm"
-- LEFT JOIN
-- 	nfl_etl.air_yards_2018 AS air
-- ON 
-- 	stnd."Tm" = air."Tm"
-- LEFT JOIN
-- 	nfl_etl.accuracy_2018 AS acc
-- ON 
-- 	stnd."Tm" = acc."Tm"
-- LEFT JOIN
-- 	nfl_etl.rush_off_2018 AS rush_o
-- ON 
-- 	stnd."Tm" = rush_o."Tm"
-- LEFT JOIN
-- 	nfl_etl.rush_off_adv_2018 AS rush_adv
-- ON 
-- 	stnd."Tm" = rush_adv."Tm"
-- LEFT JOIN
-- 	nfl_etl.rec_off_adv_2018 AS rec_adv
-- ON 
-- 	stnd."Tm" = rec_adv."Tm"
LEFT JOIN 
	nfl_etl.team_def_2014 AS team_d
ON
	stnd."Tm" = team_d."Tm"
LEFT JOIN 
	nfl_etl.pass_def_2014 AS pass_d
ON 
	stnd."Tm" = pass_d."Tm"
LEFT JOIN
	nfl_etl.rush_def_2014 AS rush_d
ON 
	stnd."Tm" = rush_d."Tm"
UNION ALL
SELECT
	2013 AS year,
    stnd."Tm" AS team,
	stnd."W" AS win,
	stnd."L" AS loss,
	stnd."T" AS tie,
	stnd."PD" AS margin,
	CAST(team_o."Cmp" AS FLOAT) / team_o."P_Att" AS "o_comp_%",
	team_o."P_TD" AS "o_pass_td",
	team_o."NY/A" AS "o_pass_ny/a",
	pass_o."Sk" AS "o_sack",
	-- air."CAY" AS "o_air_y",
	-- CAST(acc."BadTh" AS FLOAT) / (acc."Att" - (acc."ThAwy" + acc."Spikes")) AS "o_bad_%",
	-- rec_adv."YAC/R" AS "o_rec_yac/r",
	-- rec_adv."Rec/Br" AS "o_rec/bt",
	-- rec_adv."Drop%" AS "o_rec_drp/tgt",
	team_o."R_TD" AS "o_rush_td",
	team_o."Y/A" AS "o_rush_y/a",
	-- rush_adv."YAC/Att" AS "o_rush_yac/a",
	-- rush_adv."Att/Br" AS "o_rush_a/bt",
	team_o."Int" AS "o_int",
	team_o."TO" - team_o."Int" AS "o_fmb_lost",
	CAST(pass_d."Cmp" AS FLOAT) / pass_d."Att" AS "d_comp_%",
	team_d."P_TD" AS "d_pass_td",
	team_d."NY/A" AS "d_pass_ny/a",
	pass_d."Sk" AS "d_sack",
	-- d_adv."Air" AS "d_air_y",
	-- CAST(d_adv."YAC" AS FLOAT) / d_adv."Cmp" AS "d_rec_yac/c",
	team_d."R_TD" AS "d_rush_td",
	team_d."Y/A" AS "d_rush_y/a",
	team_d."Int" AS "d_int",
	team_d."TO" - team_d."Int" AS "d_fmb_rec"
	-- d_adv."MTkl" AS "miss_tkl"
FROM 
	nfl_etl.nfl_standings_2013 AS stnd
LEFT JOIN 
	nfl_etl.team_off_2013 AS team_o
ON
	stnd."Tm" = team_o."Tm"
LEFT JOIN
	nfl_etl.pass_off_2013 AS pass_o
ON 
	stnd."Tm" = pass_o."Tm"
-- LEFT JOIN
-- 	nfl_etl.air_yards_2018 AS air
-- ON 
-- 	stnd."Tm" = air."Tm"
-- LEFT JOIN
-- 	nfl_etl.accuracy_2018 AS acc
-- ON 
-- 	stnd."Tm" = acc."Tm"
-- LEFT JOIN
-- 	nfl_etl.rush_off_2018 AS rush_o
-- ON 
-- 	stnd."Tm" = rush_o."Tm"
-- LEFT JOIN
-- 	nfl_etl.rush_off_adv_2018 AS rush_adv
-- ON 
-- 	stnd."Tm" = rush_adv."Tm"
-- LEFT JOIN
-- 	nfl_etl.rec_off_adv_2018 AS rec_adv
-- ON 
-- 	stnd."Tm" = rec_adv."Tm"
LEFT JOIN 
	nfl_etl.team_def_2013 AS team_d
ON
	stnd."Tm" = team_d."Tm"
LEFT JOIN 
	nfl_etl.pass_def_2013 AS pass_d
ON 
	stnd."Tm" = pass_d."Tm"
LEFT JOIN
	nfl_etl.rush_def_2013 AS rush_d
ON 
	stnd."Tm" = rush_d."Tm"
UNION ALL
SELECT
	2012 AS year,
    stnd."Tm" AS team,
	stnd."W" AS win,
	stnd."L" AS loss,
	stnd."T" AS tie,
	stnd."PD" AS margin,
	CAST(team_o."Cmp" AS FLOAT) / team_o."P_Att" AS "o_comp_%",
	team_o."P_TD" AS "o_pass_td",
	team_o."NY/A" AS "o_pass_ny/a",
	pass_o."Sk" AS "o_sack",
	-- air."CAY" AS "o_air_y",
	-- CAST(acc."BadTh" AS FLOAT) / (acc."Att" - (acc."ThAwy" + acc."Spikes")) AS "o_bad_%",
	-- rec_adv."YAC/R" AS "o_rec_yac/r",
	-- rec_adv."Rec/Br" AS "o_rec/bt",
	-- rec_adv."Drop%" AS "o_rec_drp/tgt",
	team_o."R_TD" AS "o_rush_td",
	team_o."Y/A" AS "o_rush_y/a",
	-- rush_adv."YAC/Att" AS "o_rush_yac/a",
	-- rush_adv."Att/Br" AS "o_rush_a/bt",
	team_o."Int" AS "o_int",
	team_o."TO" - team_o."Int" AS "o_fmb_lost",
	CAST(pass_d."Cmp" AS FLOAT) / pass_d."Att" AS "d_comp_%",
	team_d."P_TD" AS "d_pass_td",
	team_d."NY/A" AS "d_pass_ny/a",
	pass_d."Sk" AS "d_sack",
	-- d_adv."Air" AS "d_air_y",
	-- CAST(d_adv."YAC" AS FLOAT) / d_adv."Cmp" AS "d_rec_yac/c",
	team_d."R_TD" AS "d_rush_td",
	team_d."Y/A" AS "d_rush_y/a",
	team_d."Int" AS "d_int",
	team_d."TO" - team_d."Int" AS "d_fmb_rec"
	-- d_adv."MTkl" AS "miss_tkl"
FROM 
	nfl_etl.nfl_standings_2012 AS stnd
LEFT JOIN 
	nfl_etl.team_off_2012 AS team_o
ON
	stnd."Tm" = team_o."Tm"
LEFT JOIN
	nfl_etl.pass_off_2012 AS pass_o
ON 
	stnd."Tm" = pass_o."Tm"
-- LEFT JOIN
-- 	nfl_etl.air_yards_2018 AS air
-- ON 
-- 	stnd."Tm" = air."Tm"
-- LEFT JOIN
-- 	nfl_etl.accuracy_2018 AS acc
-- ON 
-- 	stnd."Tm" = acc."Tm"
-- LEFT JOIN
-- 	nfl_etl.rush_off_2018 AS rush_o
-- ON 
-- 	stnd."Tm" = rush_o."Tm"
-- LEFT JOIN
-- 	nfl_etl.rush_off_adv_2018 AS rush_adv
-- ON 
-- 	stnd."Tm" = rush_adv."Tm"
-- LEFT JOIN
-- 	nfl_etl.rec_off_adv_2018 AS rec_adv
-- ON 
-- 	stnd."Tm" = rec_adv."Tm"
LEFT JOIN 
	nfl_etl.team_def_2012 AS team_d
ON
	stnd."Tm" = team_d."Tm"
LEFT JOIN 
	nfl_etl.pass_def_2012 AS pass_d
ON 
	stnd."Tm" = pass_d."Tm"
LEFT JOIN
	nfl_etl.rush_def_2012 AS rush_d
ON 
	stnd."Tm" = rush_d."Tm"
UNION ALL
SELECT
	2011 AS year,
    stnd."Tm" AS team,
	stnd."W" AS win,
	stnd."L" AS loss,
	stnd."T" AS tie,
	stnd."PD" AS margin,
	CAST(team_o."Cmp" AS FLOAT) / team_o."P_Att" AS "o_comp_%",
	team_o."P_TD" AS "o_pass_td",
	team_o."NY/A" AS "o_pass_ny/a",
	pass_o."Sk" AS "o_sack",
	-- air."CAY" AS "o_air_y",
	-- CAST(acc."BadTh" AS FLOAT) / (acc."Att" - (acc."ThAwy" + acc."Spikes")) AS "o_bad_%",
	-- rec_adv."YAC/R" AS "o_rec_yac/r",
	-- rec_adv."Rec/Br" AS "o_rec/bt",
	-- rec_adv."Drop%" AS "o_rec_drp/tgt",
	team_o."R_TD" AS "o_rush_td",
	team_o."Y/A" AS "o_rush_y/a",
	-- rush_adv."YAC/Att" AS "o_rush_yac/a",
	-- rush_adv."Att/Br" AS "o_rush_a/bt",
	team_o."Int" AS "o_int",
	team_o."TO" - team_o."Int" AS "o_fmb_lost",
	CAST(pass_d."Cmp" AS FLOAT) / pass_d."Att" AS "d_comp_%",
	team_d."P_TD" AS "d_pass_td",
	team_d."NY/A" AS "d_pass_ny/a",
	pass_d."Sk" AS "d_sack",
	-- d_adv."Air" AS "d_air_y",
	-- CAST(d_adv."YAC" AS FLOAT) / d_adv."Cmp" AS "d_rec_yac/c",
	team_d."R_TD" AS "d_rush_td",
	team_d."Y/A" AS "d_rush_y/a",
	team_d."Int" AS "d_int",
	team_d."TO" - team_d."Int" AS "d_fmb_rec"
	-- d_adv."MTkl" AS "miss_tkl"
FROM 
	nfl_etl.nfl_standings_2011 AS stnd
LEFT JOIN 
	nfl_etl.team_off_2011 AS team_o
ON
	stnd."Tm" = team_o."Tm"
LEFT JOIN
	nfl_etl.pass_off_2011 AS pass_o
ON 
	stnd."Tm" = pass_o."Tm"
-- LEFT JOIN
-- 	nfl_etl.air_yards_2018 AS air
-- ON 
-- 	stnd."Tm" = air."Tm"
-- LEFT JOIN
-- 	nfl_etl.accuracy_2018 AS acc
-- ON 
-- 	stnd."Tm" = acc."Tm"
-- LEFT JOIN
-- 	nfl_etl.rush_off_2018 AS rush_o
-- ON 
-- 	stnd."Tm" = rush_o."Tm"
-- LEFT JOIN
-- 	nfl_etl.rush_off_adv_2018 AS rush_adv
-- ON 
-- 	stnd."Tm" = rush_adv."Tm"
-- LEFT JOIN
-- 	nfl_etl.rec_off_adv_2018 AS rec_adv
-- ON 
-- 	stnd."Tm" = rec_adv."Tm"
LEFT JOIN 
	nfl_etl.team_def_2011 AS team_d
ON
	stnd."Tm" = team_d."Tm"
LEFT JOIN 
	nfl_etl.pass_def_2011 AS pass_d
ON 
	stnd."Tm" = pass_d."Tm"
LEFT JOIN
	nfl_etl.rush_def_2011 AS rush_d
ON 
	stnd."Tm" = rush_d."Tm"
UNION ALL
SELECT
	2010 AS year,
    stnd."Tm" AS team,
	stnd."W" AS win,
	stnd."L" AS loss,
	stnd."T" AS tie,
	stnd."PD" AS margin,
	CAST(team_o."Cmp" AS FLOAT) / team_o."P_Att" AS "o_comp_%",
	team_o."P_TD" AS "o_pass_td",
	team_o."NY/A" AS "o_pass_ny/a",
	pass_o."Sk" AS "o_sack",
	-- air."CAY" AS "o_air_y",
	-- CAST(acc."BadTh" AS FLOAT) / (acc."Att" - (acc."ThAwy" + acc."Spikes")) AS "o_bad_%",
	-- rec_adv."YAC/R" AS "o_rec_yac/r",
	-- rec_adv."Rec/Br" AS "o_rec/bt",
	-- rec_adv."Drop%" AS "o_rec_drp/tgt",
	team_o."R_TD" AS "o_rush_td",
	team_o."Y/A" AS "o_rush_y/a",
	-- rush_adv."YAC/Att" AS "o_rush_yac/a",
	-- rush_adv."Att/Br" AS "o_rush_a/bt",
	team_o."Int" AS "o_int",
	team_o."TO" - team_o."Int" AS "o_fmb_lost",
	CAST(pass_d."Cmp" AS FLOAT) / pass_d."Att" AS "d_comp_%",
	team_d."P_TD" AS "d_pass_td",
	team_d."NY/A" AS "d_pass_ny/a",
	pass_d."Sk" AS "d_sack",
	-- d_adv."Air" AS "d_air_y",
	-- CAST(d_adv."YAC" AS FLOAT) / d_adv."Cmp" AS "d_rec_yac/c",
	team_d."R_TD" AS "d_rush_td",
	team_d."Y/A" AS "d_rush_y/a",
	team_d."Int" AS "d_int",
	team_d."TO" - team_d."Int" AS "d_fmb_rec"
	-- d_adv."MTkl" AS "miss_tkl"
FROM 
	nfl_etl.nfl_standings_2010 AS stnd
LEFT JOIN 
	nfl_etl.team_off_2010 AS team_o
ON
	stnd."Tm" = team_o."Tm"
LEFT JOIN
	nfl_etl.pass_off_2010 AS pass_o
ON 
	stnd."Tm" = pass_o."Tm"
-- LEFT JOIN
-- 	nfl_etl.air_yards_2018 AS air
-- ON 
-- 	stnd."Tm" = air."Tm"
-- LEFT JOIN
-- 	nfl_etl.accuracy_2018 AS acc
-- ON 
-- 	stnd."Tm" = acc."Tm"
-- LEFT JOIN
-- 	nfl_etl.rush_off_2018 AS rush_o
-- ON 
-- 	stnd."Tm" = rush_o."Tm"
-- LEFT JOIN
-- 	nfl_etl.rush_off_adv_2018 AS rush_adv
-- ON 
-- 	stnd."Tm" = rush_adv."Tm"
-- LEFT JOIN
-- 	nfl_etl.rec_off_adv_2018 AS rec_adv
-- ON 
-- 	stnd."Tm" = rec_adv."Tm"
LEFT JOIN 
	nfl_etl.team_def_2010 AS team_d
ON
	stnd."Tm" = team_d."Tm"
LEFT JOIN 
	nfl_etl.pass_def_2010 AS pass_d
ON 
	stnd."Tm" = pass_d."Tm"
LEFT JOIN
	nfl_etl.rush_def_2010 AS rush_d
ON 
	stnd."Tm" = rush_d."Tm"
ORDER BY 
    year DESC, 
	team ASC