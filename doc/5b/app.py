#! /usr/bin/python3

"""
This is an example Flask | Python | Psycopg2 | PostgreSQL
application that connects to the 7dbs database from Chapter 2 of
_Seven Databases in Seven Weeks Second Edition_
by Luc Perkins with Eric Redmond and Jim R. Wilson.
The CSC 315 Virtual Machine is assumed.

John DeGood
degoodj@tcnj.edu
The College of New Jersey
Spring 2020

----

One-Time Installation

You must perform this one-time installation in the CSC 315 VM:

# install python pip and psycopg2 packages
sudo pacman -Syu
sudo pacman -S python-pip python-psycopg2

# install flask
pip install flask

----

Usage

To run the Flask application, simply execute:

export FLASK_APP=app.py 
flask run
# then browse to http://127.0.0.1:5000/

----

References

Flask documentation:  
https://flask.palletsprojects.com/  

Psycopg documentation:
https://www.psycopg.org/

This example code is derived from:
https://www.postgresqltutorial.com/postgresql-python/
https://scoutapm.com/blog/python-flask-tutorial-getting-started-with-flask
https://www.geeksforgeeks.org/python-using-for-loop-in-flask/
"""

import psycopg2
from config import config
from flask import Flask, render_template, request

# Connect to the PostgreSQL database server
def connect(query):
    conn = None
    try:
        # read connection parameters
        params = config()
 
        # connect to the PostgreSQL server
        print('Connecting to the %s database...' % (params['database']))
        conn = psycopg2.connect(**params)
        print('Connected.')
      
        # create a cursor
        cur = conn.cursor()
        
        # execute a query using fetchall()
        cur.execute(query)
        rows = cur.fetchall()

        # close the communication with the PostgreSQL
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            print('Database connection closed.')
    # return the query result from fetchall()
    return rows
 
# app.py
app = Flask(__name__)


# serve form web page
@app.route("/")
def form():
    return render_template('my-form.html')


@app.route('/aeghg-handler', methods=['POST'])
def aep_handler():
    rows = connect('SELECT * FROM ' + request.form.get('vehicle category') + ' WHERE AEGHG ' + request.form.get("options") + " " + request.form['aeghg'] + ' ORDER BY Vehicle_id ASC;')
    if request.form.get('vehicle category') == 'Curr_Emis':
        heads = ['Vehicle_id', 'Category', 'Model', 'AEG', 'AEGHG', 'Engine']
    elif request.form.get('vehicle category') == 'Type_Emis':
        heads = ['Vehicle_id', 'Model', 'Category', 'AEG', 'AEGHG', 'Engine']
    else:
        heads = ['Vehicle_id', 'Category', 'AEG', 'AEGHG', 'Engine']
    return render_template('my-result.html', rows=rows, heads=heads)

@app.route('/cost-handler', methods=['POST'])
def cost_handler():
    rows = connect('SELECT * FROM ' + request.form.get('vehicle category') + ' WHERE Total_Cost ' + request.form.get("options") + " " + request.form['cost'] + ' ORDER BY Vehicle_id ASC;')
    if request.form.get('vehicle category') == 'Curr_Cost':
        heads = ['Vehicle_id', 'Category', 'Model', 'Initial', 'Maintenance', 'Fuel', 'Total']
    else:
        heads = ['Vehicle_id', 'Category', 'Initial', 'Maintenance', 'Fuel', 'Total']
    return render_template('my-result.html', rows=rows, heads=heads)

@app.route('/info-handler', methods=['POST'])
def info_handler():
    rows = connect('SELECT * FROM ' + request.form.get('vehicle category') + ' ORDER BY Vehicle_id ASC;')
    if request.form.get('vehicle category') == 'Curr_Veh':
        heads = ['Vehicle_id', 'Department', 'Year', 'Model', 'Type']
    elif request.form.get('vehicle category') == 'Veh_Info':
        heads = ['Vehicle_id', 'Category', 'Year', 'Department', 'Model']
    else:
        heads = ['Vehicle_id', 'Department', 'Year','Category']
    return render_template('my-result.html', rows=rows, heads=heads)

@app.route('/type-handler', methods=['POST'])
def type_handler():
    rows = connect('SELECT * FROM ' + request.form.get('vehicle type') + ' ORDER BY Vehicle_id ASC;')
    heads = ['Vehicle_id','Model', 'Type', 'Department', 'Year']
    return render_template('my-result.html', rows=rows, heads=heads)

@app.route('/dep-handler', methods=['POST'])
def dep_handler():
    rows = connect("SELECT * FROM Vehicle NATURAL JOIN Id_Emis WHERE Department = '" + request.form.get('dep') +  "' ORDER BY Vehicle_id ASC;")
    heads = ['Vehicle_id', 'Model', 'Year', 'Department', 'Cateogry', 'AEP', 'AEGHG', 'Engine']
    return render_template('my-result.html', rows=rows, heads=heads)



if __name__ == '__main__':
    app.run(debug = True)
