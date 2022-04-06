DROP TABLE IF EXISTS Vehicle CASCADE;
DROP TABLE IF EXISTS Vehicle_Cost CASCADE;
DROP TABLE IF EXISTS Van CASCADE;
DROP TABLE IF EXISTS Pickup CASCADE;
DROP TABLE  IF EXISTS Other CASCADE;
DROP TABLE  IF EXISTS Engine CASCADE;
DROP TABLE  IF EXISTS Runs_On CASCADE;
CREATE TABLE Vehicle (Vehicle_Id int PRIMARY KEY, Year int, Department text, Model text, Vehicle_Type char(1) NOT NULL);
CREATE TABLE Vehicle_Cost (Vehicle_Id int REFERENCES Vehicle, Maintenance_Cost double precision, Initial_Cost double precision, Fuel_Cost double precision, PRIMARY KEY (Vehicle_Id));
CREATE TABLE Van (Vehicle_Id int REFERENCES Vehicle, Van_Type text, PRIMARY KEY (Vehicle_Id));
CREATE TABLE Pickup (Vehicle_Id int REFERENCES Vehicle, Pickup_Type text, PRIMARY KEY (Vehicle_Id));
CREATE TABLE Other (Vehicle_Id int REFERENCES Vehicle, Type text, PRIMARY KEY (Vehicle_Id));
CREATE TABLE Engine (Engine_Id int PRIMARY KEY, AEP double precision, AEGHG double precision, Engine_Type text);
CREATE TABLE Runs_On (Vehicle_Id int REFERENCES Vehicle, Engine_Id int REFERENCES Engine, PRIMARY KEY(Vehicle_Id, Engine_Id));

CREATE VIEW Id_Cost as
SELECT Vehicle_Id, Initial_Cost, Maintenance_Cost, Fuel_Cost, SUM(Initial_Cost+ Maintenance_Cost+ Fuel_Cost) as Total_Cost
FROM Vehicle_Cost
GROUP BY Vehicle_Id, Initial_Cost, Maintenance_Cost, Fuel_Cost
ORDER BY Vehicle_Id ASC;

CREATE VIEW Dep_Cost as
SELECT V.Department, C.Initial_Cost, C.Maintenance_Cost, C.Fuel_Cost, SUM(C.Initial_Cost+ C.Maintenance_Cost+ C.Fuel_Cost) as Total_Cost
FROM Vehicle_Cost as C NATURAL JOIN Vehicle as V
GROUP BY V.Department, C.InitialCost, C.MaintenanceCost, C.FuelCost;
ORDER BY V.Department ASC;

CREATE VIEW Type_Cost as
SELECT V.Vehicle_Type, C.Initial_Cost, C.Maintenance_Cost, C.Fuel_Cost, SUM(C.Initial_Cost+ C.Maintenance_Cost+ C.Fuel_Cost) as Total_Cost
FROM Vehicle_Cost as C NATURAL JOIN Vehicle as V
GROUP BY V.Vehicle_Type, C.InitialCost, C.MaintenanceCost, C.FuelCost;
ORDER BY V.Vehicle_Type ASC;

CREATE VIEW Curr_Cost as
SELECT V.Vehicle_Type, C.Initial_Cost, C.Maintenance_Cost, C.Fuel_Cost, SUM(C.Initial_Cost+ C.Maintenance_Cost+ C.Fuel_Cost) as Total_Cost
FROM Vehicle_Cost as C NATURAL JOIN Vehicle as V
WHERE V.Vehicle_Type = 'C'
GROUP BY V.Vehicle_Type, C.InitialCost, C.MaintenanceCost, C.FuelCost;
ORDER BY Total_Cost ASC;

CREATE VIEW Prop_Cost as
SELECT V.Vehicle_Type, C.Initial_Cost, C.Maintenance_Cost, C.Fuel_Cost, SUM(C.Initial_Cost+ C.Maintenance_Cost+ C.Fuel_Cost) as Total_Cost
FROM Vehicle_Cost as C NATURAL JOIN Vehicle as V
WHERE V.Vehicle_Type = 'P'
GROUP BY V.Vehicle_Type, C.InitialCost, C.MaintenanceCost, C.FuelCost;
ORDER BY Total_Cost ASC;

CREATE VIEW Fut_Cost as
SELECT V.Vehicle_Type, C.Initial_Cost, C.Maintenance_Cost, C.Fuel_Cost, SUM(C.Initial_Cost+ C.Maintenance_Cost+ C.Fuel_Cost) as Total_Cost
FROM Vehicle_Cost as C NATURAL JOIN Vehicle as V
WHERE V.Vehicle_Type = 'F'
GROUP BY V.Vehicle_Type, C.InitialCost, C.MaintenanceCost, C.FuelCost;
ORDER BY Total_Cost ASC;


