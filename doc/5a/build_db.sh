#! /bin/sh

python3 build_db.py
dropdb "Fleet_Vehicle"
createdb "Fleet_Vehicle"
psql -d "Fleet_Vehicle" -f "database.sql"
