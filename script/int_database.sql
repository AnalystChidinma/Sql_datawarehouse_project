/* Create a database called Datawarehouse. we use the GO separtor to seprate the various schema
*/

USE MASTER;

CREATE DATABASE Datawarehouse;

USE Datawarehouse;

create Schema Bronze;

Go 
Create Schema Silver;

Go
Create Schema Gold;
