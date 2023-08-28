import sys
import time
from bs4 import BeautifulSoup
from bs4 import Comment
import requests
import pandas as pd
import numpy as np
import psycopg2
from sqlalchemy import create_engine

class Extract():
    
    def __init__(self):
        pass
    
    def response(urls):
        resps = [''] * 4

        for i in range(len(urls)):
            resps[i] = requests.get(urls[i]).content

        return resps    

    def setup_parser(responses):
        soups = [''] * 4

        for i in range(len(responses)):
            soups[i] = BeautifulSoup(responses[i], 'html.parser')

        return soups    

    def decomment(self, div):
        try:
            cleaned = div.find(string=lambda text: isinstance(text, Comment))
            return cleaned
        except:
            return div
        

    def iter_divs(self, inds, divs):
        div = []
        for i, d in enumerate(divs):
            if i in inds:
                div.append(self.decomment(d))

        return div

    
    
# nfc_stnd = []
# for tr in div_afc_stnd.find_all('tr'):
#     if tr.get('class') != None:
#         divafc_stnd.append(tr)


# # parse html for list of dataframes
# print('parsing html...')
# pass_o_tbl = pd.read_html(pass_o, flavor='html5lib')
# pass_d_tbl = pd.read_html(pass_d, flavor='html5lib')
# rush_o_tbl = pd.read_html(rush_o, flavor='html5lib')
# rush_d_tbl = pd.read_html(rush_d, flavor='html5lib')
# pass_o_adv_tbl = pd.read_html(str(pass_o_adv), flavor='html5lib', header=1)
# rush_o_adv_tbl = pd.read_html(str(rush_o_adv), flavor='html5lib')
# rec_o_adv_tbl = pd.read_html(str(rec_o_adv), flavor='html5lib')
# afc_stnd_tbl = pd.read_html(str(afc_stnd), flavor='html5lib')
# nfc_stnd_tbl = pd.read_html(str(nfc_stnd), flavor='html5lib')

# # obtain dataframe from list
# print('creating dataframes...')
# pass_o_df = pass_o_tbl[0]
# pass_d_df = pass_d_tbl[0]
# rush_o_df = rush_o_tbl[0]
# rush_d_df = rush_d_tbl[0]
# pass_o_adv_df = pass_o_adv_tbl[0]
# rush_o_adv_df = rush_o_adv_tbl[0]
# rec_o_adv_df = rec_o_adv_tbl[0]
# afc_stnd_df = afc_stnd_tbl[0]
# nfc_stnd_df = nfc_stnd_tbl[0]
# stnd_dfs = [afc_stnd_df, nfc_stnd_df]
# nfl_stnd_df = pd.concat(stnd_dfs)

# # rename columns for postgres compatability
# print('renaming columns and dropping unwanted columns...')
# pass_o_df = pass_o_df.rename(columns={
#     'Tm': 'tm',
#     'G': 'gp',
#     'Cmp': 'c',
#     'Att': 'a',
#     'Cmp%': 'c_pct',
#     'Yds': 'yd',
#     'TD': 'td',
#     'TD%': 'td_pct',
#     'Int': 'intr',
#     'Int%': 'intr_pct',
#     'Y/A': 'yp_a',
#     'AY/A': 'ayp_a',
#     'Y/C': 'yp_c',
#     'Y/G': 'yp_g',
#     'Rate': 'qbr',
#     'Sk': 'sk',
#     'Yds.1': 'yds_sk',
#     'Sk%': 'sk_pct',
#     'NY/A': 'nyp_a',
#     'ANY/A': 'anyp_a',
#     '4QC': 'q4_cb',
#     'GWD': 'gwd',
#     'EXP': 'ex'
# })

# pass_d_df = pass_d_df.rename(columns={
#     'Tm': 'tm',
#     'G': 'gp',
#     'Cmp': 'c',
#     'Att': 'a',
#     'Cmp%': 'c_pct',
#     'Yds': 'yd',
#     'TD': 'td',
#     'TD%': 'td_pct',
#     'Int': 'intr',
#     'PD': 'pd',
#     'Int%': 'intr_pct',
#     'Y/A': 'yp_a',
#     'AY/A': 'ayp_a',
#     'Y/C': 'yp_c',
#     'Y/G': 'yp_g',
#     'Rate': 'qbr',
#     'Sk': 'sk',
#     'Yds.1': 'yds_sk',
#     'QBHits': 'qb_hit',
#     'TFL': 'tfl',
#     'Sk%': 'sk_pct',
#     'NY/A': 'nyp_a',
#     'ANY/A': 'anyp_a',
#     'EXP': 'ex'
# })

# rush_o_df = rush_o_df.rename(columns={
#     'Tm': 'tm',
#     'G': 'gp',
#     'Att': 'a',
#     'Yds': 'yd',
#     'TD': 'td',
#     'Y/A': 'yp_a',
#     'Y/G': 'yp_g',
#     'Fmb': 'fmb',
#     'EXP': 'ex'
# })

# rush_d_df = rush_d_df.rename(columns={
#     'Tm': 'tm',
#     'G': 'gp',
#     'Att': 'a',
#     'Yds': 'yd',
#     'TD': 'td',
#     'Y/A': 'yp_a',
#     'Y/G': 'yp_g',
#     'EXP': 'ex'
# })

# pass_o_adv_df = pass_o_adv_df.rename(columns={
#     'Tm': 'tm',
#     'G': 'gp',
#     'Cmp': 'c',
#     'Att': 'a',
#     'Yds': 'yd',
#     'IAY': 'iay',
#     'IAY/PA': 'iay_pa',
#     'CAY': 'cay',
#     'CAY/PA': 'cay_pa',
#     'YAC': 'yac',
#     'YAC/Cmp': 'yac_cmp'
# })

# rush_o_adv_df = rush_o_adv_df.rename(columns={
#     'Tm': 'tm',
#     'G': 'gp',
#     'Att': 'a',
#     'Yds': 'yd',
#     'TD': 'td',
#     '1D': 'fd',
#     'YBC': 'ybc',
#     'YBC/ATT': 'ybc_pa',
#     'YAC': 'yac',
#     'YAC/ATT': 'yac_pa',
#     'BrkTkl': 'bt',
#     'Att/Br': 'a_pbt'
# })

# rec_o_adv_df = rec_o_adv_df.rename(columns={
#     'Tm': 'tm',
#     'G': 'gp',
#     'Tgt': 'tgt',
#     'Rec': 'rec',
#     'Yds': 'yd',
#     'TD': 'td',
#     '1D': 'fd',
#     'YBC': 'ybc',
#     'YBC/R': 'ybc_pr',
#     'YAC': 'yac',
#     'YAC/R': 'yac_pr',
#     'ADOT': 'adot',
#     'BrkTkl': 'bt',
#     'Rec/Br': 'rec_pbt',
#     'Drop': 'drp',
#     'Drop%': 'drp_pct',
# })

# nfl_stnd_df = nfl_stnd_df.rename(columns={
#     'Tm': 'tm',
#     'W': 'w',
#     'L': 'l',
#     'T': 't',
#     'W-L%': 'w_pct',
#     'PF': 'pf',
#     'PA': 'pa',
#     'PD': 'pd',
#     'MoV': 'mov',
#     'SoS': 'sos',
#     'SRS': 'srs',
#     'OSRS': 'osrs',
#     'DSRS': 'dsrs'
# })

# # drop unwanted columns
# pass_o_df = pass_o_df.drop(columns=['Rk', 'Lng'])
# pass_d_df = pass_d_df.drop(columns=['Rk'])
# rush_o_df = rush_o_df.drop(columns=['Rk', 'Lng'])
# rush_d_df = rush_d_df.drop(columns=['Rk'])
# rec_o_adv_df = rec_o_adv_df.drop(columns=['Int', 'Rat'])

# # drop unwanted rows
# nfl_stnd_df = nfl_stnd_df[nfl_stnd_df['tm'].str.contains('AFC') == False]
# nfl_stnd_df = nfl_stnd_df[nfl_stnd_df['tm'].str.contains('NFC') == False]

# # convert standings to numeric
# nfl_stnd_df = nfl_stnd_df.apply(pd.to_numeric, errors='ignore')

# # drop * and + from playoff teams
# nfl_stnd_df['tm'] = nfl_stnd_df['tm'].str.replace('*', '')
# nfl_stnd_df['tm'] = nfl_stnd_df['tm'].str.replace('+', '')

# dfs = [pass_o_df, pass_d_df, rush_o_df, rush_d_df, pass_o_adv_df, rush_o_adv_df, rec_o_adv_df, nfl_stnd_df]

# # setup connections to postgres DB
# try:
#     conn_string = 'postgresql://moose:moose@127.0.0.1/nfletl_dev'

#     db = create_engine(conn_string)
#     conn = db.connect()
#     conn1 = psycopg2.connect(
#         database="nfletl_dev",
#         user='moose', 
#         password='moose', 
#         host='127.0.0.1', 
#         port= '5432'
#     )
    
#     print('connection to PostgreSQL established')
#     cursor = conn1.cursor()

#     for i in range(len(dfs)):
#         dfs[i] = dfs[i].set_index('tm')                             # drop unnecessary index column, use team name as index
#         dfs[i].to_sql(df_names[i], conn, if_exists='replace')       # write dataframe to postgres

# except (Exception, psycopg2.Error) as error:
#     print("Error while fetching data from PostgreSQL", error)

# finally:
#     if conn: conn.close()
#     if conn1: 
#         cursor.close()
#         conn1.close()
#         print('connection to PostgreSQL closed')