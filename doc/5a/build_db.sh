#! /bin/sh

python3 create_db.py
createdb "Fleet_Vehicle"
psql -d "Fleet_Vehicle" -f "database.sql"
psql "Fleet_Vehicle"
