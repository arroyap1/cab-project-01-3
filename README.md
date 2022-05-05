## Topic Fleet Vehicle Management
Group Members: Paula Arroyave, James Blair, Faiza Hoque, Drake Lam, Nicole Lenge, Matt Machado, and Corinne Scheddin
1. [Topic: Fleet Vehicle Management](#desc)
2. [Problem Statement](#usage)
3. [Objective](#usage)
4. [Description of the Database](#usage)
5. [Description of the need for module](#usage)
6. [How To Install](#usage)
<a name="desc"></a>
## 

<a name="usage"></a>
## Problem Statement
We have been tasked with finding a more cost effective and
environmentally friendly way for TCNJ’s fleet to operate. To address the issue of the economical and enviromental composition of TCNJ's vehicle fleet, the vehicles should
undergo a transition from ICE vehicles to zero vehicles by retiring the older vehicles first and replacing them with zero emission vehicles. This will allow for a slow, steady replacement of vehicles in order to avoid having the school have high expenses and be able to make the most use out of the current vehicle fleet before replacing them. 

## Objective
Address the TCNJ vehicle fleet composition in an effective approach for reducing emmissions and reducing cost. Create a database that holds and operates the data
for TCNJ's vehicle fleet such as fuel source, emmissons, service life, and depreciations.

## Description of the Database
Database will consist of an interactive user interface that allows both a user and adminstrator to input and retrieve information regarding TCNJ's vehicle fleet. The input for the database will contain boolean expressions in coordinance with each categorical search. There will be ten attributes of information regarding the vehicle composition with boolean expressions for the user to pick what information they are looking for. The database highlights difference characteristics per vehicle and can also be updated
annually by the adminstrator. 

## Description of the need for module
The module is necessary in addressing the problem because it provides
information about how fuel source, emissions, age, quantity, and operational costs
influences our solution. By examining the variables and outputs, we will be able to properly determine which
vehicles need to be replaced, hopefully in accordance with FIFO.

## How To Install:
### One time installation:
    #install python pip and psycopg2 packages
    sudo pacman -Syu
    sudo pacman -S python-pip python-psycopg2

    #install flask
    pip install flask
### Clone our GitHub
    git clone https://github.com/TCNJ-degoodj/cab-project-01-3
    #log into you GitHub account

    cd cab-project-01-3/doc/5a/
    chmod 755 build_db.sh #must change access rights
    ./build_db.sh
    cd ../5b/
### Usage
    export FLASK_APP=app.py
    flask run
    #then browse to http://127.0.0.1:5000/

[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-f059dc9a6f8d3a56e377f745f24479a46679e63a5d9fe6f495e02850cd0d8118.svg)](https://classroom.github.com/online_ide?assignment_repo_id=6871314&assignment_repo_type=AssignmentRepo)
