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

# parse command line arguments
if len(sys.argv) != 2:
    raise Exception('Unexpected number of arguments, please review command. Terminating')

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

# print('running extraction script for {year} NFL season...'.format(year=YEAR))

# setup requests to webpage and parser
url_o = 'https://www.pro-football-reference.com/years/{year}/#team_stats'.format(year=YEAR)
url_o_adv = 'https://www.pro-football-reference.com/years/{year}/advanced.htm'.format(year=YEAR)
url_d = 'https://www.pro-football-reference.com/years/{year}/opp.htm'.format(year=YEAR)
url_stnd = 'https://www.pro-football-reference.com/years/{year}/'.format(year=YEAR)
urls = [url_o, url_o_adv, url_d, url_stnd]

ex = Extract()

resps = Extract.response(urls)
soups = Extract.setup_parser(resps) 

# retrieve all desired divs
divs_pass = [div.find('div', {'id': 'all_passing'}) for div in soups]
divs_rush = [div.find('div', {'id': 'all_rushing'}) for div in soups]
divs_pass_o_adv = [div.select('#div_air_yards, #div_accuracy, #div_pressure, #div_play_type') for div in soups]     # used selector as this is a tabbed table, as opposed to above
afc = [div.find('div', {'id': 'div_AFC'}) for div in soups][0]
nfc = [div.find('div', {'id': 'div_NFC'}) for div in soups][0]

# Indexes for iter_divs():
# 0 - offense
# 1 - advanced offense
# 2 - defense
# 3 - standings
pass_o, pass_d = ex.iter_divs([0, 2], divs_pass)
rush_o, rush_d = ex.iter_divs([0, 2], divs_rush)

pass_o_adv = ex.iter_divs([1], divs_pass_o_adv)[0]

air_yards =  pass_o_adv[0]
accuracy =  pass_o_adv[1]
pressure =  pass_o_adv[2]
play_type = pass_o_adv[3]



print(nfc)



    #     afc_stnd = soup.find('div', {'id': 'div_AFC'})
    #     nfc_stnd = soup.find('div', {'id': 'div_NFC'})
# print(pass_d)


