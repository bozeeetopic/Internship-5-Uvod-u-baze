CREATE DATABASE HospitalDatabase
USE HospitalDatabase

CREATE TABLE People(
	Oib nvarchar(11) PRIMARY KEY CHECK (LEN(Oib) = 11),
	[Name] nvarchar(30) NOT NULL,
	Surname nvarchar(30) NOT NULL,
	PhoneNumber nvarchar(14) NOT NULL UNIQUE,
	Adress nvarchar(50) NOT NULL,
	PlaceOfBirth nvarchar(20) NOT NULL
)
CREATE TABLE Specialisations (
	Id int IDENTITY(1,1) PRIMARY KEY,
	SpecialisationName nvarchar(40) NOT NULL UNIQUE
)
CREATE TABLE OperationTypes (
	Id int IDENTITY(1,1) PRIMARY KEY,
	OperationType nvarchar(30) NOT NULL UNIQUE
)
CREATE TABLE Surgeons (
	PersonOib nvarchar(11) PRIMARY KEY REFERENCES People(Oib),
	SpecialisationId int FOREIGN KEY REFERENCES Specialisations(Id) NOT NULL
)
CREATE TABLE Rooms (
	Id int IDENTITY(1,1) PRIMARY KEY,
	RoomNumber int UNIQUE,
	HospitalFloor int NOT NULL
)
CREATE TABLE OperatingRooms (
	Id int IDENTITY(1,1) PRIMARY KEY,
	RoomNumber int UNIQUE,
	HospitalFloor int NOT NULL
)
CREATE TABLE Nurses (
	PersonId nvarchar(11) PRIMARY KEY REFERENCES People(Oib),
	RoomNumber int FOREIGN KEY REFERENCES Rooms(RoomNumber),
	OperatingRoomNumber int FOREIGN KEY REFERENCES OperatingRooms(RoomNumber)
)
CREATE TABLE Patients (
	PersonOib nvarchar(11) PRIMARY KEY REFERENCES People(Oib),
	DateOfArrival datetime2 NOT NULL,
	RoomNumber int FOREIGN KEY REFERENCES Rooms(RoomNumber) NOT NULL
)
CREATE TABLE Surgeries (
	Id int IDENTITY(1,1) PRIMARY KEY,
	DateOfOperation datetime2 NOT NULL,
	SurgeonOib nvarchar(11) FOREIGN KEY REFERENCES Surgeons(PersonOib) NOT NULL,
	SurgeryRoomNumber int FOREIGN KEY REFERENCES OperatingRooms(RoomNumber) NOT NULL,
	PatientOib nvarchar(11) FOREIGN KEY REFERENCES Patients(PersonOib) NOT NULL,
	OperationType int FOREIGN KEY REFERENCES OperationTypes(Id) NOT NULL,
)

INSERT INTO People(Oib,[Name],Surname,PhoneNumber,Adress,PlaceOfBirth) VALUES
('46553786499','Ante','Kralji?','0985433421','Vukovarska 24','Imacki'),
('46511186499','Mate','Mati?','098523421','Splitcka 21','Split'),
('46552226499','Bo?ena','Braica','0981113421','Omi?ka 2','Omi?'),
('46552333499','Michelle','?ari?','0982213421','Omi?ka 2','Split'),
('46552244499','Ante','?urkov','0981144421','Imotski 2','Imacki'),
('88852226499','Ante','P?elar','0999113421','Imotski 3','Imacki'),
('46559996499','Ante','Lon?ar','0987777421','Imotski 2','Imacki')
INSERT INTO Specialisations(SpecialisationName) VALUES
('Obiteljska medicina'),
('Kardiolog'),
('Ekstraktiranje bubre?nog kamenca'),
('Traumatolog'),
('Otorinolaringolog')
INSERT INTO OperationTypes(OperationType) VALUES
('Pregled'),
('Operacija srca'),
('Tetoviranje'),
('Gips')
INSERT INTO Surgeons(PersonOib,SpecialisationId) VALUES
('46553786499',3),
('46511186499',2),
('46552226499',1)
INSERT INTO Rooms(RoomNumber,HospitalFloor) VALUES
(7,0),
(4,0),
(100,1),
(101,1),
(102,1),
(200,2),
(201,2)
INSERT INTO OperatingRooms(RoomNumber,HospitalFloor) VALUES
(204,2),
(205,2),
(300,3),
(301,3),
(302,3)
INSERT INTO Nurses(PersonId,RoomNumber,OperatingRoomNumber) VALUES
('46552226499',101,null),
('46552244499',101,null),
('88852226499',4,300),
('46559996499',null,301),
('46553786499',200,302)
INSERT INTO Patients(PersonOib,DateOfArrival,RoomNumber) VALUES
('46553786499','2000-01-01',7),
('46511186499','2000-01-01',7),
('46552226499','2000-01-01',7),
('46552333499','2000-01-01',100),
('46552244499','2000-01-01',101),
('88852226499','2000-01-01',102),
('46559996499','2000-01-01',200)
INSERT INTO Surgeries(DateOfOperation,SurgeonOib,SurgeryRoomNumber,PatientOib,OperationType) VALUES
('2020-02-02 01:00:00','46552226499',300,'46552333499',1),
('2020-02-02 02:00:00','46552226499',300,'46552333499',1),
('2020-02-02 03:00:00','46552226499',300,'46552333499',1),
('2020-02-02 04:00:00','46552226499',300,'46552333499',1),
('2020-04-02 05:00:00','46553786499',301,'46552333499',3),
('2020-04-02 06:30:00','46553786499',301,'46552333499',3),
('2020-04-02 06:30:50','46553786499',302,'46552333499',3),
('2020-05-02 07:00:00','46511186499',204,'46552226499',2),
('2020-06-02 19:00:00','46552226499',205,'46553786499',1),
('2020-07-02 21:00:00','46552226499',300,'46511186499',1),
(SYSDATETIME(),'46552226499',300,'46552244499',1),
(SYSDATETIME(),'46552226499',300,'88852226499',1),
(SYSDATETIME(),'46552226499',300,'46559996499',1)


SELECT * FROM Surgeries
WHERE DateOfOperation BETWEEN '2021-02-02' AND '2021-02-03' 
ORDER BY DateOfOperation
SELECT * FROM Surgeries

SELECT [Name],Surname
FROM Surgeons INNER JOIN People ON Surgeons.PersonOib = People.Oib
WHERE PlaceOfBirth NOT IN ('Split') 
SELECT * FROM Surgeons INNER JOIN People ON Surgeons.PersonOib = People.Oib

UPDATE Nurses SET RoomNumber=100 WHERE RoomNumber=4
SELECT * FROM Nurses INNER JOIN People ON PersonId=Oib

SELECT PersonOib,[Name],Surname
FROM Patients INNER JOIN People ON Patients.PersonOib = People.Oib
WHERE RoomNumber = 7
ORDER BY Surname
SELECT * FROM Patients INNER JOIN People ON Patients.PersonOib = People.Oib

SELECT * FROM Surgeries
WHERE DateOfOperation BETWEEN DATEADD (DAY , -1 , SYSDATETIME())  AND  SYSDATETIME()
SELECT * FROM Surgeries


/*
SELECT SurgeryRoomNumber, OperationTypes.OperationType,
		SurgeonData.[Name] AS Surgeon_Name,SurgeonData.Surname AS Surgeon_Surame,SpecialisationName AS Specialisation,
		Patients.RoomNumber,PatientData.[Name] AS Patient_Name,PatientData.Surname AS Patient_Surame,PatientData.Adress,PatientData.PlaceOfBirth
FROM Surgeries INNER JOIN Surgeons ON SurgeonOib=Surgeons.PersonOib
				INNER JOIN Patients ON PatientOib=Patients.PersonOib 
				INNER JOIN Specialisations ON Surgeons.SpecialisationId = Specialisations.Id
				INNER JOIN OperationTypes ON Surgeries.OperationType = OperationTypes.Id
				INNER JOIN People SurgeonData ON SurgeonOib=SurgeonData.Oib
				INNER JOIN People PatientData ON PatientOib=PatientData.Oib
				
				extra query za znatizeljne
				*/ 