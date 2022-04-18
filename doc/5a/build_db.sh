#! /bin/sh

python3 build_db.py
dropdb--if-exists "Fleet_Vehicle"
createdb "Fleet_Vehicle"
psql -d "Fleet_Vehicle" -f "database.sql"
psql "Fleet_Vehicle"
