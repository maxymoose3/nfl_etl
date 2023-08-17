import numpy as np
from pandas import DataFrame
# from sklearn.linear_model import LinearRegression
import psycopg2
from sqlalchemy import create_engine

# setup connections to postgres DB
try:
    conn_string = 'postgresql://postgres:Khruangbin95@127.0.0.1/nfletl_dev'

    db = create_engine(conn_string)
    conn = db.connect()
    conn1 = psycopg2.connect(
        database="nfletl_dev",
        user='postgres', 
        password='Khruangbin95', 
        host='127.0.0.1', 
        port= '5432'
    )

    print('connection to PostgreSQL established')
    cursor = conn1.cursor()
    cursor.execute("SELECT * FROM nfl_standings_2022 ORDER BY w DESC")
    cols = [col[0] for col in cursor.description]
    rows = cursor.fetchall()
    df = DataFrame(rows, columns=cols)
    df = df.set_index('tm') 
    print(df)


except (Exception, psycopg2.Error) as error:
    print("Error while fetching data from PostgreSQL", error)

finally:
    if conn: conn.close()
    if conn1: 
        cursor.close()
        conn1.close()
        print('connection to PostgreSQL closed')