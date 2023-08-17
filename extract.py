import sys
import time
from bs4 import BeautifulSoup
from bs4 import Comment
import requests
import pandas as pd
import numpy as np
import psycopg2
from sqlalchemy import create_engine

# parse command line arguments
if len(sys.argv) != 2:
    print('Unexpected number of arguments, please review command. Terminating')
    exit()

YEAR = sys.argv[1]

df_names = [
    'pass_off_{year}'.format(year=YEAR), 
    'pass_def_{year}'.format(year=YEAR), 
    'rush_off_{year}'.format(year=YEAR), 
    'rush_def_{year}'.format(year=YEAR),
    'pass_off_adv_{year}'.format(year=YEAR), 
    'rush_off_adv_{year}'.format(year=YEAR), 
    'rec_off_adv_{year}'.format(year=YEAR),
    'nfl_standings_{year}'.format(year=YEAR)
]

print('running extraction script for {year} NFL season...'.format(year=YEAR))

# setup requests to webpage
print('setting up requests to webpage...')
url_o = 'https://www.pro-football-reference.com/years/{year}/#team_stats'.format(year=YEAR)
url_o_adv = 'https://www.pro-football-reference.com/years/{year}/advanced.htm'.format(year=YEAR)
url_d = 'https://www.pro-football-reference.com/years/{year}/opp.htm'.format(year=YEAR)
url_stnd = 'https://www.pro-football-reference.com/years/{year}/'.format(year=YEAR)

response_o = requests.get(url_o).content
response_d = requests.get(url_d).content
response_o_adv = requests.get(url_o_adv).content
response_stnd = requests.get(url_stnd).content

# setup parser 
print('setting up HTML parser...')
soup_o = BeautifulSoup(response_o, 'html.parser')
soup_d = BeautifulSoup(response_d, 'html.parser')
soup_o_adv = BeautifulSoup(response_o_adv, 'html.parser')
soup_stnd = BeautifulSoup(response_stnd, 'html.parser')

# extract table divs
print('extracting desired divs...')
div_pass_o = soup_o.find('div', {'id': 'all_passing'})
div_pass_d = soup_d.find('div', {'id': 'all_passing'})
div_rush_o = soup_o.find('div', {'id': 'all_rushing'})
div_rush_d = soup_d.find('div', {'id': 'all_rushing'})
pass_o = div_pass_o.find(string=lambda text: isinstance(text, Comment))     # tables wrapped in comments, must be extracted further 
pass_d = div_pass_d.find(string=lambda text: isinstance(text, Comment))     # tables wrapped in comments, must be extracted further 
rush_o = div_rush_o.find(string=lambda text: isinstance(text, Comment))     # tables wrapped in comments, must be extracted further 
rush_d = div_rush_d.find(string=lambda text: isinstance(text, Comment))     # tables wrapped in comments, must be extracted further 
pass_o_adv = soup_o_adv.find("table", {"id": "air_yards"})
rush_o_adv = soup_o_adv.find("table", {"id": "advanced_rushing"})
rec_o_adv = soup_o_adv.find("div", {"id": "div_advanced_receiving"})
afc_stnd = soup_stnd.find('div', {'id': 'div_AFC'})
nfc_stnd = soup_stnd.find('div', {'id': 'div_NFC'})
# nfc_stnd = []
# for tr in div_afc_stnd.find_all('tr'):
#     if tr.get('class') != None:
#         divafc_stnd.append(tr)


# parse html for list of dataframes
print('parsing html...')
pass_o_tbl = pd.read_html(pass_o, flavor='html5lib')
pass_d_tbl = pd.read_html(pass_d, flavor='html5lib')
rush_o_tbl = pd.read_html(rush_o, flavor='html5lib')
rush_d_tbl = pd.read_html(rush_d, flavor='html5lib')
pass_o_adv_tbl = pd.read_html(str(pass_o_adv), flavor='html5lib', header=1)
rush_o_adv_tbl = pd.read_html(str(rush_o_adv), flavor='html5lib')
rec_o_adv_tbl = pd.read_html(str(rec_o_adv), flavor='html5lib')
afc_stnd_tbl = pd.read_html(str(afc_stnd), flavor='html5lib')
nfc_stnd_tbl = pd.read_html(str(nfc_stnd), flavor='html5lib')

# obtain dataframe from list
print('creating dataframes...')
pass_o_df = pass_o_tbl[0]
pass_d_df = pass_d_tbl[0]
rush_o_df = rush_o_tbl[0]
rush_d_df = rush_d_tbl[0]
pass_o_adv_df = pass_o_adv_tbl[0]
rush_o_adv_df = rush_o_adv_tbl[0]
rec_o_adv_df = rec_o_adv_tbl[0]
afc_stnd_df = afc_stnd_tbl[0]
nfc_stnd_df = nfc_stnd_tbl[0]
stnd_dfs = [afc_stnd_df, nfc_stnd_df]
nfl_stnd_df = pd.concat(stnd_dfs)

# rename columns for postgres compatability
print('renaming columns and dropping unwanted columns...')
pass_o_df = pass_o_df.rename(columns={
    'Tm': 'tm',
    'G': 'gp',
    'Cmp': 'c',
    'Att': 'a',
    'Cmp%': 'c_pct',
    'Yds': 'yd',
    'TD': 'td',
    'TD%': 'td_pct',
    'Int': 'intr',
    'Int%': 'intr_pct',
    'Y/A': 'yp_a',
    'AY/A': 'ayp_a',
    'Y/C': 'yp_c',
    'Y/G': 'yp_g',
    'Rate': 'qbr',
    'Sk': 'sk',
    'Yds.1': 'yds_sk',
    'Sk%': 'sk_pct',
    'NY/A': 'nyp_a',
    'ANY/A': 'anyp_a',
    '4QC': 'q4_cb',
    'GWD': 'gwd',
    'EXP': 'ex'
})

pass_d_df = pass_d_df.rename(columns={
    'Tm': 'tm',
    'G': 'gp',
    'Cmp': 'c',
    'Att': 'a',
    'Cmp%': 'c_pct',
    'Yds': 'yd',
    'TD': 'td',
    'TD%': 'td_pct',
    'Int': 'intr',
    'PD': 'pd',
    'Int%': 'intr_pct',
    'Y/A': 'yp_a',
    'AY/A': 'ayp_a',
    'Y/C': 'yp_c',
    'Y/G': 'yp_g',
    'Rate': 'qbr',
    'Sk': 'sk',
    'Yds.1': 'yds_sk',
    'QBHits': 'qb_hit',
    'TFL': 'tfl',
    'Sk%': 'sk_pct',
    'NY/A': 'nyp_a',
    'ANY/A': 'anyp_a',
    'EXP': 'ex'
})

rush_o_df = rush_o_df.rename(columns={
    'Tm': 'tm',
    'G': 'gp',
    'Att': 'a',
    'Yds': 'yd',
    'TD': 'td',
    'Y/A': 'yp_a',
    'Y/G': 'yp_g',
    'Fmb': 'fmb',
    'EXP': 'ex'
})

rush_d_df = rush_d_df.rename(columns={
    'Tm': 'tm',
    'G': 'gp',
    'Att': 'a',
    'Yds': 'yd',
    'TD': 'td',
    'Y/A': 'yp_a',
    'Y/G': 'yp_g',
    'EXP': 'ex'
})

pass_o_adv_df = pass_o_adv_df.rename(columns={
    'Tm': 'tm',
    'G': 'gp',
    'Cmp': 'c',
    'Att': 'a',
    'Yds': 'yd',
    'IAY': 'iay',
    'IAY/PA': 'iay_pa',
    'CAY': 'cay',
    'CAY/PA': 'cay_pa',
    'YAC': 'yac',
    'YAC/Cmp': 'yac_cmp'
})

rush_o_adv_df = rush_o_adv_df.rename(columns={
    'Tm': 'tm',
    'G': 'gp',
    'Att': 'a',
    'Yds': 'yd',
    'TD': 'td',
    '1D': 'fd',
    'YBC': 'ybc',
    'YBC/ATT': 'ybc_pa',
    'YAC': 'yac',
    'YAC/ATT': 'yac_pa',
    'BrkTkl': 'bt',
    'Att/Br': 'a_pbt'
})

rec_o_adv_df = rec_o_adv_df.rename(columns={
    'Tm': 'tm',
    'G': 'gp',
    'Tgt': 'tgt',
    'Rec': 'rec',
    'Yds': 'yd',
    'TD': 'td',
    '1D': 'fd',
    'YBC': 'ybc',
    'YBC/R': 'ybc_pr',
    'YAC': 'yac',
    'YAC/R': 'yac_pr',
    'ADOT': 'adot',
    'BrkTkl': 'bt',
    'Rec/Br': 'rec_pbt',
    'Drop': 'drp',
    'Drop%': 'drp_pct',
})

nfl_stnd_df = nfl_stnd_df.rename(columns={
    'Tm': 'tm',
    'W': 'w',
    'L': 'l',
    'T': 't',
    'W-L%': 'w_pct',
    'PF': 'pf',
    'PA': 'pa',
    'PD': 'pd',
    'MoV': 'mov',
    'SoS': 'sos',
    'SRS': 'srs',
    'OSRS': 'osrs',
    'DSRS': 'dsrs'
})

# drop unwanted columns
pass_o_df = pass_o_df.drop(columns=['Rk', 'Lng'])
pass_d_df = pass_d_df.drop(columns=['Rk'])
rush_o_df = rush_o_df.drop(columns=['Rk', 'Lng'])
rush_d_df = rush_d_df.drop(columns=['Rk'])
rec_o_adv_df = rec_o_adv_df.drop(columns=['Int', 'Rat'])

# drop unwanted rows
nfl_stnd_df = nfl_stnd_df[nfl_stnd_df['tm'].str.contains('AFC') == False]
nfl_stnd_df = nfl_stnd_df[nfl_stnd_df['tm'].str.contains('NFC') == False]

# convert standings to numeric
nfl_stnd_df = nfl_stnd_df.apply(pd.to_numeric, errors='ignore')

# drop * and + from playoff teams
nfl_stnd_df['tm'] = nfl_stnd_df['tm'].str.replace('*', '')
nfl_stnd_df['tm'] = nfl_stnd_df['tm'].str.replace('+', '')

dfs = [pass_o_df, pass_d_df, rush_o_df, rush_d_df, pass_o_adv_df, rush_o_adv_df, rec_o_adv_df, nfl_stnd_df]

# setup connections to postgres DB
try:
    conn_string = 'postgresql://moose:moose@127.0.0.1/nfletl_dev'

    db = create_engine(conn_string)
    conn = db.connect()
    conn1 = psycopg2.connect(
        database="nfletl_dev",
        user='moose', 
        password='moose', 
        host='127.0.0.1', 
        port= '5432'
    )
    
    print('connection to PostgreSQL established')
    cursor = conn1.cursor()

    for i in range(len(dfs)):
        dfs[i] = dfs[i].set_index('tm')                             # drop unnecessary index column, use team name as index
        dfs[i].to_sql(df_names[i], conn, if_exists='replace')       # write dataframe to postgres

except (Exception, psycopg2.Error) as error:
    print("Error while fetching data from PostgreSQL", error)

finally:
    if conn: conn.close()
    if conn1: 
        cursor.close()
        conn1.close()
        print('connection to PostgreSQL closed')