import csv

rows1 = []

# create INSERT to populate Vehicle
with open('Vehicle.csv','r') as file1:
    reader = csv.reader(file1)
    header = []
    header = next(reader)
    for row in reader:
        rows1.append(row)
    
with open('database.sql','a') as file:
    for list in rows1:
        file.write("\nINSERT INTO Vehicle VALUES ({},{},'{}','{}','{}');".format(list[0],list[1],list[2],list[3],list[4]))
    
# Create INSERT to populate Other
rows2 = []

with open('Other.csv','r') as file2:
    reader = csv.reader(file2)
    header = []
    header = next(reader)
    for row in reader:
        rows2.append(row)
    
with open('database.sql','a') as file2:
    for list in rows2:
        file2.write("\nINSERT INTO Other VALUES ({},'{}');".format(list[0],list[1]))


# CREATE INSERT to populate Engine
rows3 = []
with open('EngineID.csv','r') as file:
    reader = csv.reader(file)
    header = []
    header = next(reader)
    for row in reader:
        rows3.append(row)
    
with open('database.sql','a') as file:
    for list in rows3:
        file.write("\nINSERT INTO Engine VALUES ({},{},'{}','{}');".format(list[0],list[1],list[2],list[3])) 


# create INSERT to populate Pickup
rows4 = []

with open('Pickup.csv','r') as file:
    reader = csv.reader(file)
    header = []
    header = next(reader)
    for row in reader:
        rows4.append(row)
    
with open('database.sql','a') as file:
    for list in rows4:
        file.write("\nINSERT INTO Pickup VALUES ({},'{}');".format(list[0],list[1]))

# create INSERT to populate Runs_On
rows5 = []

with open('Runs_On.csv','r') as file:
    reader = csv.reader(file)
    header = []
    header = next(reader)
    for row in reader:
        rows5.append(row)
    
with open('database.sql','a') as file:
    for list in rows5:
        file.write("\nINSERT INTO Runs_On VALUES ({},{});".format(list[0],list[1]))


# create INSERT to populate Van
rows6 = []

with open('Van.csv','r') as file:
    reader = csv.reader(file)
    header = []
    header = next(reader)
    for row in reader:
        rows6.append(row)
    
with open('database.sql','a') as file:
    for list in rows6:
        file.write("\nINSERT INTO Van VALUES ({},'{}');".format(list[0],list[1]))

# create INSERT to populate Vehicle_Cost
rows7 = []

with open('Vehicle_Cost.csv','r') as file1:
    reader = csv.reader(file1)
    header = []
    header = next(reader)
    for row in reader:
        rows7.append(row)
    
with open('database.sql','a') as file:
    for list in rows7:
        file.write("\nINSERT INTO Vehicle_Cost VALUES ({},{},{},{});".format(list[0],list[1],list[2],list[3]))