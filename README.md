# GlobantChallenge
For this challenge it was used python as language to create the script that will insert the data from csv files to a SQL base and Microsoft SQL Server as DataBase.

This is a python script designed for Globant Data Engineer Challenge.
It import OS to path local files, CSV to read csv files and PYODBC to connect to a SQL Server DataBase.

First step is set the connection parameters to log intothe DataBase
then it declare local path and bring the name of the csv file and table where the data will insert and set the connection to the DataBase.

After this, it start a For loop to read each row from CSV file and a nested for loop to insert each row into the table asigned.
When it finish it commit and close connection.
