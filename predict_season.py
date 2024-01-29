# This module will run a linear regression on 3 years of historical data, 
# the first 2 years being training data and the final year being testing data 
# to predict the upcoming season results

import sys
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
import psycopg2
from dotenv import load_dotenv
import os

# parse command line arguments
if len(sys.argv) != 2:
    raise Exception('Unexpected number of arguments, please review command. Terminating')

YEAR = int(sys.argv[1])

# Load environment variables from .env
load_dotenv()

conn = psycopg2.connect(
            database='nfletl_dev',
            user=os.getenv('DB_USER'), 
            password=os.getenv('DB_PASSWORD'), 
            host='127.0.0.1', 
            port= '5432',
        )

cursor = conn.cursor()

schema = 'nfl_etl'
table = 'season_historical_by_year'

query = f"SELECT * FROM {schema}.{table};"

df = pd.read_sql_query(query, conn)

cursor.close()
conn.close()

# we need data from the previous four years for our regression
# training data will be (0.3 * four_ago) + (0.7 * three_ago) yields two_ago
# and (0.3 * three_ago) + (0.7 * two_ago) yields one_ago
# test data will be (0.3 * two_ago) + (0.7 * one_ago) yields upcoming
four_ago = df[df['year'].isin([YEAR - 4])]
three_ago = df[df['year'].isin([YEAR - 3])]
two_ago = df[df['year'].isin([YEAR - 2])]
one_ago = df[df['year'].isin([YEAR - 1])]
upcoming = df[df['year'] == YEAR].reset_index(drop=True)

x_1 = four_ago.loc[:, ~four_ago.columns.isin(['year', 'team', 'win', 'loss', 'tie', 'margin'])].reset_index(drop=True)
x_2 = three_ago.loc[:, ~three_ago.columns.isin(['year', 'team', 'win', 'loss', 'tie', 'margin'])].reset_index(drop=True)
x_3 = two_ago.loc[:, ~two_ago.columns.isin(['year', 'team', 'win', 'loss', 'tie', 'margin'])].reset_index(drop=True)
x_4 = one_ago.loc[:, ~one_ago.columns.isin(['year', 'team', 'win', 'loss', 'tie', 'margin'])].reset_index(drop=True)

x_train_1 = (0.3 * x_1) + (0.7 * x_2) # (0.3 * four_ago) + (0.7 * three_ago)
x_train_2 = (0.3 * x_2) + (0.7 * x_3) # (0.3 * three_ago) + (0.7 * two_ago)
x_train = pd.concat([x_train_1, x_train_2], ignore_index=True)

y_train_1 = two_ago['margin'].reset_index(drop=True) # two_ago
y_train_2 = one_ago['margin'].reset_index(drop=True) # one_ago
y_train = pd.concat([y_train_1, y_train_2], ignore_index=True)

x_test = (0.3 * x_3) + (0.7 * x_4) # (0.3 * two_ago) + (0.7 * one_ago)
# y_test = upcoming['margin']

model = LinearRegression()
model.fit(x_train, y_train)
predictions_df = pd.DataFrame(model.predict(x_test))

analysis_df = pd.DataFrame({'team': upcoming['team'], 'actual_margin': upcoming['margin'], 'actual_win': upcoming['win'], 'actual_loss': upcoming['loss'], 'actual_tie': upcoming['tie']})
analysis_df.insert(1, "predicted_margin", predictions_df[0].round(0))

print(analysis_df)
