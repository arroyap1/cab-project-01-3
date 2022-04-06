
DROP TABLE IF EXISTS Vehicle CASCADE;
DROP TABLE IF EXISTS Vehicle_Cost CASCADE;
DROP TABLE IF EXISTS Van CASCADE;
DROP TABLE IF EXISTS Pickup CASCADE;
DROP TABLE  IF EXISTS Other CASCADE;
DROP TABLE  IF EXISTS Engine CASCADE;
DROP TABLE  IF EXISTS Runs_On CASCADE;
CREATE TABLE Vehicle (Vehicle_Id int PRIMARY KEY, Year int, Department text, Model text, Vehicle_Type char(1) NOT NULL);
CREATE TABLE Vehicle_Cost (Vehicle_Id int REFERENCES Vehicle, Maintence_Cost double precision, Initial_Cost double precision, Fuel_Cost double precision, PRIMARY KEY (Vehicle_Id));
CREATE TABLE Van (Vehicle_Id int REFERENCES Vehicle, Van_Type text, PRIMARY KEY (Vehicle_Id));
CREATE TABLE Pickup (Vehicle_Id int REFERENCES Vehicle, Pickup_Type text, PRIMARY KEY (Vehicle_Id));
CREATE TABLE Other (Vehicle_Id int REFERENCES Vehicle, Type text, PRIMARY KEY (Vehicle_Id));
CREATE TABLE Engine (Engine_Id int PRIMARY KEY, AEP double precision, AEGHG double precision, Engine_Type text);
CREATE TABLE Runs_On (Vehicle_Id int REFERENCES Vehicle, Engine_Id int REFERENCES Engine, PRIMARY KEY(Vehicle_Id, Engine_Id));
