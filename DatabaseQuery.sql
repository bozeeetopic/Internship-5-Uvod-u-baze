USE PostDatabase
DROP DATABASE MedicalDatabase
CREATE DATABASE MedicalDatabase

USE MedicalDatabase

CREATE TABLE Persons(
	Oib nvarchar(11) PRIMARY KEY,
	PersonName nvarchar(30) NOT NULL,
	Surame nvarchar(30) NOT NULL,
	PhoneNumber nvarchar(14) NOT NULL UNIQUE,
	Adress nvarchar(20) NOT NULL,
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
	PersonOib nvarchar(11) PRIMARY KEY REFERENCES Persons(Oib),
	SpecialisationId int FOREIGN KEY REFERENCES Specialisations(Id) NOT NULL
)
CREATE TABLE Rooms (
	RoomNumber int PRIMARY KEY,
	HospitalFloor int NOT NULL
)
CREATE TABLE OperatingRooms (
	RoomNumber int PRIMARY KEY,
	HospitalFloor int NOT NULL
)
CREATE TABLE Nurses (
	PersonId nvarchar(11) PRIMARY KEY REFERENCES Persons(Oib),
	RoomId int FOREIGN KEY REFERENCES Rooms(RoomNumber),
	OperatingRoomId int FOREIGN KEY REFERENCES OperatingRooms(RoomNumber)
)
CREATE TABLE Patients (
	PersonOib nvarchar(11) PRIMARY KEY REFERENCES Persons(Oib),
	DateOfArrival datetime2 NOT NULL,
	RoomId int FOREIGN KEY REFERENCES Rooms(RoomNumber) NOT NULL
)
CREATE TABLE Surgeries (
	Id int IDENTITY(1,1) PRIMARY KEY,
	DateOfOperation datetime2 NOT NULL,
	SurgeonOib nvarchar(11) FOREIGN KEY REFERENCES Surgeons(PersonOib) NOT NULL,
	SurgeryRoomNumber int FOREIGN KEY REFERENCES OperatingRooms(RoomNumber) NOT NULL,
	PatientOib nvarchar(11) FOREIGN KEY REFERENCES Patients(PersonOib) NOT NULL,
	OperationType int FOREIGN KEY REFERENCES OperationTypes(Id) NOT NULL,
)

INSERT INTO Persons(Oib,PersonName,Surame,PhoneNumber,Adress,PlaceOfBirth) VALUES
('46553786499','Ante','Kraljiæ','0985433421','Vukovarska 24','Imacki'),
('46511186499','Mate','Matiæ','098523421','Splitcka 21','Split'),
('46552226499','Božena','Braica','0981113421','Omiška 2','Omiš'),
('46552333499','Michelle','Šariæ','0982213421','Omiška 2','Split'),
('46552244499','Ante','Èurkov','0981144421','Imotski 2','Imacki'),
('88852226499','Ante','Pèelar','0999113421','Imotski 3','Imacki'),
('46559996499','Ante','Lonèar','0987777421','Imotski 2','Imacki')
INSERT INTO Specialisations(SpecialisationName) VALUES
('Obiteljska medicina'),
('Kardiolog'),
('Ekstraktiranje bubrežnog kamenca'),
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
INSERT INTO Nurses(PersonId,RoomId,OperatingRoomId) VALUES
('46552226499',101,null),
('46552244499',101,null),
('88852226499',102,300),
('46559996499',null,301),
('46553786499',200,302)
INSERT INTO Patients(PersonOib,DateOfArrival,RoomId) VALUES
('46553786499','2000-01-01',100),
('46511186499','2000-01-01',100),
('46552226499','2000-01-01',100),
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
WHERE DateOfOperation BETWEEN '2020-02-02' AND '2000-03-03' 
ORDER BY DateOfOperation