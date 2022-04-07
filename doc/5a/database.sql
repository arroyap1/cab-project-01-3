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

CREATE VIEW Temp1 as
SELECT V.Department, C.Initial_Cost, C.Maintenance_Cost, C.Fuel_Cost, SUM(C.Initial_Cost+ C.Maintenance_Cost+ C.Fuel_Cost) as Total_Cost
FROM Vehicle_Cost as C NATURAL JOIN Vehicle as V
GROUP BY V.Department, C.Initial_Cost, C.Maintenance_Cost, C.Fuel_Cost;
ORDER BY V.Department ASC;

CREATE VIEW Dep_Cost as
SELECT Department, Initial_Cost, Maintenance_Cost, Fuel_Cost, SUM(Total_Cost) as Total_Cost
FROM Temp1
GROUP BY Department, Initial_Cost, Maintenance_Cost, Fuel_Cost;
ORDER BY V.Department ASC;

CREATE VIEW Temp3 as
SELECT V.Vehicle_Type, C.Initial_Cost, C.Maintenance_Cost, C.Fuel_Cost, SUM(C.Initial_Cost+ C.Maintenance_Cost+ C.Fuel_Cost) as Total_Cost
FROM Vehicle_Cost as C NATURAL JOIN Vehicle as V
GROUP BY V.Vehicle_Type, C.Initial_Cost, C.Maintenance_Cost, C.Fuel_Cost;
ORDER BY V.Vehicle_Type ASC;

CREATE VIEW Type_Cost as
SELECT V.Vehicle_Type, C.Initial_Cost, C.Maintenance_Cost, C.Fuel_Cost, SUM(Total_Cost) as Total_Cost
FROM Temp3
GROUP BY Vehicle_Type, Initial_Cost, Maintenance_Cost, Fuel_Cost;
ORDER BY Vehicle_Type ASC;

CREATE VIEW Curr_Cost as
SELECT V.Vehicle_Type, C.Initial_Cost, C.Maintenance_Cost, C.Fuel_Cost, SUM(C.Initial_Cost+ C.Maintenance_Cost+ C.Fuel_Cost) as Total_Cost
FROM Vehicle_Cost as C NATURAL JOIN Vehicle as V
WHERE V.Vehicle_Type = 'C'
GROUP BY V.Vehicle_Type, C.Initial_Cost, C.Maintenance_Cost, C.Fuel_Cost;
ORDER BY Total_Cost ASC;

CREATE VIEW Prop_Cost as
SELECT V.Vehicle_Type, C.Initial_Cost, C.Maintenance_Cost, C.Fuel_Cost, SUM(C.Initial_Cost+ C.Maintenance_Cost+ C.Fuel_Cost) as Total_Cost
FROM Vehicle_Cost as C NATURAL JOIN Vehicle as V
WHERE V.Vehicle_Type = 'P'
GROUP BY V.Vehicle_Type, C.Initial_Cost, C.Maintenance_Cost, C.Fuel_Cost;
ORDER BY Total_Cost ASC;

CREATE VIEW Fut_Cost as
SELECT V.Vehicle_Type, C.Initial_Cost, C.Maintenance_Cost, C.Fuel_Cost, SUM(C.Initial_Cost+ C.Maintenance_Cost+ C.Fuel_Cost) as Total_Cost
FROM Vehicle_Cost as C NATURAL JOIN Vehicle as V
WHERE V.Vehicle_Type = 'F'
GROUP BY V.Vehicle_Type, C.Initial_Cost, C.Maintenance_Cost, C.Fuel_Cost;
ORDER BY Total_Cost ASC;

CREATE VIEW Id_Emis as 
SELECT V.Vehicle_Id, E.AEP, E.AEGHG, E.Engine_Type, SUM(AEP) as Total_AEP, SUM(AEGHG) as Total_AEGHG
FROM Vehicle as V NATURAL JOIN Runs_On NATURAL JOIN Engine as E
GROUP BY V.Vehicle_Id, E.AEP, E.AEGHG, E.Engine_Type
ORDER BY V.Vehicle_Id ASC;

CREATE VIEW Temp2 as 
SELECT V.Department, E.AEP, E.AEGHG, E.Engine_Type, SUM(AEP) as Total_AEP, SUM(AEGHG) as Total_AEGHG
FROM Vehicle as V NATURAL JOIN Runs_On NATURAL JOIN Engine as E
GROUP BY V.Department, E.AEP, E.AEGHG, E.Engine_Type
ORDER BY V.Department ASC;

CREATE VIEW Dep_Emis as 
SELECT Department, AEP, AEGHG, Engine_Type, SUM(Total_AEP) as Total_AEP, SUM(Total_AEGHG) as Total_AEGHG
FROM Temp2
GROUP BY Department, AEP, AEGHG, Engine_Type
ORDER BY Department ASC;

CREATE VIEW Temp4 as 
SELECT V.Vehicle_Type, E.AEP, E.AEGHG, E.Engine_Type, SUM(AEP) as Total_AEP, SUM(AEGHG) as Total_AEGHG
FROM Vehicle as V NATURAL JOIN Runs_On NATURAL JOIN Engine as E
GROUP BY V.Vehicle_Type, E.AEP, E.AEGHG, E.Engine_Type
ORDER BY V.Vehicle_Type ASC;

CREATE VIEW Type_Emis as 
SELECT V.Vehicle_Type, E.AEP, E.AEGHG, E.Engine_Type, SUM(Total_AEP) as Total_AEP, SUM(Total_AEGHG) as Total_AEGHG
FROM Temp4
GROUP BY Vehicle_Type, AEP, AEGHG, Engine_Type
ORDER BY Vehicle_Type ASC;

CREATE VIEW Curr_Emis as 
SELECT V.Vehicle_Type, E.AEP, E.AEGHG, E.Engine_Type, SUM(AEP) as Total_AEP, SUM(AEGHG) as Total_AEGHG
FROM Vehicle as V NATURAL JOIN Runs_On NATURAL JOIN Engine as E
WHERE V.Vehicle_Type = 'C'
GROUP BY V.Vehicle_Type, E.AEP, E.AEGHG, E.Engine_Type
ORDER BY V.Vehicle_Type ASC;

CREATE VIEW Prop_Emis as 
SELECT V.Vehicle_Type, E.AEP, E.AEGHG, E.Engine_Type, SUM(AEP) as Total_AEP, SUM(AEGHG) as Total_AEGHG
FROM Vehicle as V NATURAL JOIN Runs_On NATURAL JOIN Engine as E
WHERE V.Vehicle_Type = 'P'
GROUP BY V.Vehicle_Type, E.AEP, E.AEGHG, E.Engine_Type
ORDER BY V.Vehicle_Type ASC;

CREATE VIEW Fut_Emis as 
SELECT V.Vehicle_Type, E.AEP, E.AEGHG, E.Engine_Type, SUM(AEP) as Total_AEP, SUM(AEGHG) as Total_AEGHG
FROM Vehicle as V NATURAL JOIN Runs_On NATURAL JOIN Engine as E
WHERE V.Vehicle_Type = 'F'
GROUP BY V.Vehicle_Type, E.AEP, E.AEGHG, E.Engine_Type
ORDER BY V.Vehicle_Type ASC;

CREATE VIEW Veh_Info as
SELECT Vehicle_Id, Year, Department, Model, Vehicle_Type
FROM Vehicle
GROUP BY Vehicle_Id, Year, Department, Model, Vehicle_Type
ORDER BY Vehicle_Id ASC;

CREATE VIEW Curr_Veh as
SELECT  Vehicle_Id, Department, Year, Model, Vehicle_Type
FROM Vehicle
WHERE Vehicle_Type = 'C'
GROUP BY Vehicle_Id, Year, Department, Model, Vehicle_Type
ORDER BY Vehicle_Id ASC;

CREATE VIEW Prop_Veh as
SELECT  Vehicle_Id, Department, Year, Model, Vehicle_Type
FROM Vehicle
WHERE Vehicle_Type = 'P'
GROUP BY Vehicle_Id, Year, Department, Model, Vehicle_Type
ORDER BY Vehicle_Id ASC;

CREATE VIEW Fut_Veh as
SELECT  Vehicle_Id, Department, Year, Model, Vehicle_Type
FROM Vehicle
WHERE Vehicle_Type = 'F'
GROUP BY Vehicle_Id, Year, Department, Model, Vehicle_Type
ORDER BY Vehicle_Id ASC;

