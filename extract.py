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

    # extracts the div wrapped in comments
    def decomment(self, div):
        try:
            cleaned = div.find(string=lambda text: isinstance(text, Comment))
            return cleaned
        except:
            return div
        
    # iterates corresponding offense/defense divs with same ID
    def iter_divs(self, inds, divs):
        div = []
        for i, d in enumerate(divs):
            if i in inds:
                div.append(self.decomment(d))

        return div

    def parse_html(self, div):
        return pd.read_html(div, flavor='html5lib')

    def build_stnd(self, afc, nfc):
        nfl = [afc, nfc]
        stnd = pd.concat(nfl)

        # drop unwanted rows
        stnd = stnd[stnd['Tm'].str.contains('AFC') == False]
        stnd = stnd[stnd['Tm'].str.contains('NFC') == False]
        
        # convert standings to numeric
        stnd = stnd.apply(pd.to_numeric, errors='ignore')

        # drop * and + from playoff teams
        stnd['Tm'] = stnd['Tm'].str.replace('*', '')
        stnd['Tm'] = stnd['Tm'].str.replace('+', '')

        # sort standings
        stnd = stnd.sort_values('W-L%', ascending=False)
        return stnd
