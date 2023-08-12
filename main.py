import os
import csv
import pyodbc

# Set connection parameters
server = 'DESKTOP-K7G5BRS'
database = 'globant'
username = 'globant'
password = 'challenge'
connection_string = (f'DRIVER=ODBC Driver 17 for SQL Server;SERVER={server};'
                     f'DATABASE={database};UID={username};PWD={password}')

# set CSV PATH
file_path = r'C:\csv'

# bring files and table names
files_tables = {
    'departments.csv': 'departments',
    'hired_employees.csv': 'hired_employees',
    'jobs.csv': 'jobs'
}

# Set connection to Database
connection = pyodbc.connect(connection_string)
cursor = connection.cursor()

# read and load data from csv to table
for file, table in files_tables.items():
    ruta_archivo = os.path.join(file_path, file)
    with open(ruta_archivo, 'r', newline='', encoding='utf-8') as csv_file:
        csv_reader = csv.reader(csv_file)
        # in case it need to skip 1st line
        # next(lector_csv, None)
        for line in csv_reader:
            value = ','.join(['?' for _ in line])
            query = f'INSERT INTO {table} VALUES ({value})'
            cursor.execute(query, line)
    connection.commit()

# close connection
connection.close()
