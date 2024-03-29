import sys
import time
from bs4 import BeautifulSoup
from bs4 import Comment
import requests
import pandas as pd
import numpy as np
import psycopg2
from sqlalchemy import create_engine
from extract import Extract
from dotenv import load_dotenv
import os

def main():
    # parse command line arguments
    if len(sys.argv) != 2:
        raise Exception('Unexpected number of arguments, please review command. Terminating')
        
    # Load environment variables from .env
    load_dotenv()

    YEAR = int(sys.argv[1])

    if YEAR > 2017:
        df_names = [
            'nfl_standings_{year}'.format(year=YEAR),
            'team_off_{year}'.format(year=YEAR),
            'team_def_{year}'.format(year=YEAR),
            'pass_off_{year}'.format(year=YEAR), 
            'pass_def_{year}'.format(year=YEAR), 
            'rush_off_{year}'.format(year=YEAR), 
            'rush_def_{year}'.format(year=YEAR),
            'air_yards_{year}'.format(year=YEAR), 
            'accuracy_{year}'.format(year=YEAR),
            'pressure_{year}'.format(year=YEAR),
            'rush_off_adv_{year}'.format(year=YEAR), 
            'rec_off_adv_{year}'.format(year=YEAR),
            'def_adv_{year}'.format(year=YEAR)
        ]
    else:
        df_names = [
            'nfl_standings_{year}'.format(year=YEAR),
            'team_off_{year}'.format(year=YEAR),
            'team_def_{year}'.format(year=YEAR),
            'pass_off_{year}'.format(year=YEAR), 
            'pass_def_{year}'.format(year=YEAR), 
            'rush_off_{year}'.format(year=YEAR), 
            'rush_def_{year}'.format(year=YEAR),
        ]

    # print('running extraction script for {year} NFL season...'.format(year=YEAR))

    # setup requests to webpage and parser
    url_o = 'https://www.pro-football-reference.com/years/{year}/#team_stats'.format(year=YEAR)
    url_o_adv = 'https://www.pro-football-reference.com/years/{year}/advanced.htm'.format(year=YEAR)
    url_d = 'https://www.pro-football-reference.com/years/{year}/opp.htm'.format(year=YEAR)
    url_stnd = 'https://www.pro-football-reference.com/years/{year}/'.format(year=YEAR)
    
    if YEAR > 2017:
        urls = [url_o, url_o_adv, url_d, url_stnd]
    else:
        urls = [url_o, url_d, url_stnd]
    ex = Extract()

    resps = Extract.response(urls)
    soups = Extract.setup_parser(resps) 

    # retrieve all desired divs, offense and defense will have corresponding divs with the same name.
    # Indexes for decomment and iter_divs() correspond to the order of urls parsed from lines 40-43:
    # 0 - offense
    # 1 - advanced offense
    # 2 - defense
    # 3 - standings
    afc = [div.find('div', {'id': 'div_AFC'}) for div in soups][0]
    nfc = [div.find('div', {'id': 'div_NFC'}) for div in soups][0]
    divs_team = [div.find('div', {'id': 'all_team_stats'}) for div in soups]
    divs_pass = [div.find('div', {'id': 'all_passing'}) for div in soups]
    divs_rush = [div.find('div', {'id': 'all_rushing'}) for div in soups]
    
    if YEAR > 2017:
        divs_pass_o_adv = [div.select('#div_air_yards, #div_accuracy, #div_pressure, #div_play_type') for div in soups]     # used selector as this is a tabbed table, as opposed to above
        rush_adv = [div.find('div', {'id': 'all_advanced_rushing'}) for div in soups][1]
        rec_adv = [div.find('div', {'id': 'all_advanced_receiving'}) for div in soups][1]
        def_adv = [div.find('div', {'id': 'all_advanced_defense'}) for div in soups][2]
    
    if YEAR <= 2017:
        team_o, team_d = ex.iter_divs([0, 2], divs_team)     # this div was not wrapped in comments after 2017 so bypassed iter_divs(). for the above div, just went straight to decomment()
    else:
        team_o = ex.decomment(divs_team[0])
        team_d = divs_team[2]

    pass_o, pass_d = ex.iter_divs([0, 2], divs_pass)
    rush_o, rush_d = ex.iter_divs([0, 2], divs_rush)

    if YEAR > 2017:
        pass_o_adv = ex.iter_divs([1], divs_pass_o_adv)[0]
        air_yards =  pass_o_adv[0]
        accuracy =  pass_o_adv[1]
        pressure =  pass_o_adv[2]
    
    # loop through all divs and create df to correspond
    if YEAR > 2017:
        dfs = [afc, nfc, team_o, team_d, pass_o, pass_d, rush_o, rush_d, air_yards, accuracy, pressure, rush_adv, rec_adv, def_adv]
    else:
        dfs = [afc, nfc, team_o, team_d, pass_o, pass_d, rush_o, rush_d]
    
    
    for i in range(len(dfs)):
        dfs[i] = pd.read_html(dfs[i].encode('utf-8'), flavor='html5lib')[0]

    # reassign variables, drop unwanted columns, 
    # drop unwanted multilevel header and set index to team name 
    afc = dfs[0]
    nfc = dfs[1]
    team_o = dfs[2]
    team_o.columns = team_o.columns.droplevel()
    # rename ambiguous column names due to droplevel()
    team_o.columns = ['Rk', 'Tm', 'G', 'PF', 'Yds', 'Ply', 'Y/P', 'TO', 'FL', '1stD', 'Cmp',
       'P_Att', 'P_Yds', 'P_TD', 'Int', 'NY/A', 'P_1stD', 'R_Att', 'R_Yds', 'R_TD', 'Y/A',
       'R_1stD', 'Pen', 'Pen_Yds', '1stPy', 'Sc%', 'TO%', 'EXP']
    team_o = team_o.drop(columns=['Rk']).set_index('Tm')
    team_d = dfs[3]
    team_d.columns = team_d.columns.droplevel()
    # rename ambiguous column names due to droplevel()
    team_d.columns = ['Rk', 'Tm', 'G', 'PA', 'Yds', 'Ply', 'Y/P', 'TO', 'FL', '1stD', 'Cmp',
       'P_Att', 'P_Yds', 'P_TD', 'Int', 'NY/A', 'P_1stD', 'R_Att', 'R_Yds', 'R_TD', 'Y/A',
       'R_1stD', 'Pen', 'Pen_Yds', '1stPy', 'Sc%', 'TO%', 'EXP']
    team_d = team_d.drop(columns=['Rk']).set_index('Tm')
    pass_o = dfs[4].drop(columns=['Rk']).set_index('Tm') 
    pass_d = dfs[5].drop(columns=['Rk']).set_index('Tm')
    rush_o = dfs[6].drop(columns=['Rk']).set_index('Tm')
    rush_d = dfs[7].drop(columns=['Rk']).set_index('Tm')
    
    if YEAR > 2017:
        air_yards = dfs[8]
        air_yards.columns = air_yards.columns.droplevel()
        air_yards = air_yards.set_index('Tm')
        accuracy = dfs[9]
        accuracy.columns = accuracy.columns.droplevel()
        accuracy = accuracy.set_index('Tm')
        pressure = dfs[10]
        pressure.columns = pressure.columns.droplevel()
        pressure = pressure.set_index('Tm')
        rush_adv = dfs[11].set_index('Tm')
        rec_adv = dfs[12].set_index('Tm')
        def_adv = dfs[13].set_index('Tm')

    

    # concat standings and sort
    stnd = ex.build_stnd(afc, nfc).set_index('Tm')
    
    # populate Postgres
    if YEAR > 2017:
        dfs = [stnd, team_o, team_d, pass_o, pass_d, rush_o, rush_d, air_yards, accuracy, pressure, rush_adv, rec_adv, def_adv]
    else:
        dfs = [stnd, team_o, team_d, pass_o, pass_d, rush_o, rush_d]

    # create tie column if there were none that year
    if 'T' not in stnd:
        stnd['T'] = 0
  
    
    # setup connections to postgres DB
    try:
        conn_string = 'postgresql://moose:moose@127.0.0.1/nfletl_dev'

        db = create_engine(conn_string)
        conn = db.connect()
        conn1 = psycopg2.connect(
            database='nfletl_dev',
            user=os.getenv('DB_USER'), 
            password=os.getenv('DB_PASSWORD'),
            host='127.0.0.1', 
            port= '5432',
        )
        
        print('connection to PostgreSQL established')
        cursor = conn1.cursor()

        for i in range(len(dfs)):
            cursor.execute('DROP TABLE IF EXISTS nfl_etl.{table_name} CASCADE'.format(table_name=df_names[i]))
            conn1.commit()
            dfs[i].to_sql(name=df_names[i], con=conn, schema='nfl_etl', if_exists='replace')       # write dataframe to postgres

    except (Exception, psycopg2.Error) as error:
        print("Error while writing data to PostgreSQL", error)

    finally:
        if conn: conn.close()
        if conn1: 
            cursor.close()
            conn1.close()
            print('connection to PostgreSQL closed')

if __name__ == "__main__":
    main()


