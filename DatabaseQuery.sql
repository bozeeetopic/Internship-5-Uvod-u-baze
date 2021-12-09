DROP DATABASE MedicalDatabase
CREATE DATABASE MedicalDatabase

USE MedicalDatabase

CREATE TABLE Persons(
	Oib nvarchar(11) PRIMARY KEY,
	PersonName nvarchar(30) NOT NULL,
	Surame nvarchar(30) NOT NULL,
	PhoneNumber nvarchar(14) NOT NULL UNIQUE,
	Adress nvarchar(20) NOT NULL
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
	RoomNumber int IDENTITY(1,1) PRIMARY KEY,
	HospitalFloor int NOT NULL
)
CREATE TABLE OperatingRooms (
	RoomNumber int IDENTITY(1,1) PRIMARY KEY,
	HospitalFloor int NOT NULL
)
CREATE TABLE Nurses (
	PersonId nvarchar(11) PRIMARY KEY REFERENCES Person(Oib),
	RoomId int FOREIGN KEY REFERENCES Rooms(RoomNumber),
	OperatingRoomId int FOREIGN KEY REFERENCES OperatingRooms(RoomNumber)
)
CREATE TABLE Patients (
	PersonId nvarchar(11) PRIMARY KEY REFERENCES Person(Oib),
	DateOfArrival datetime2 NOT NULL,
	RoomId int FOREIGN KEY REFERENCES Rooms(RoomNumber) NOT NULL
)
CREATE TABLE Surgeries (
	Id int IDENTITY(1,1) PRIMARY KEY,
	SurgeonId int FOREIGN KEY REFERENCES Surgeons(Oib) NOT NULL,
	SurgeryRoomNumber int FOREIGN KEY REFERENCES OperatingRooms(RoomNumber) NOT NULL,
	PatientId int FOREIGN KEY REFERENCES Patients(Oib) NOT NULL,
	OperationType int FOREIGN KEY REFERENCES OperationTypes(Id) NOT NULL,
)

INSERT INTO Persons(Oib,PersonName,Surame,PhoneNumber,Adress) VALUES
('46553786499','Ante','Kraljiæ','0985433421','Imotski 4'),
('46511186499','Mate','Matiæ','098523421','Splitcka 21'),
('46552226499','Božena','Braica','0981113421','Omiška 2'),
('46552333499','Michelle','Šariæ','0982213421','Omiška 2'),
('46552244499','Ante','Èurkov','0981144421','Imotski 2'),
('88852226499','Ante','Pèelar','0999113421','Imotski 3'),
('46559996499','Ante','Lonèar','0987777421','Imotski 2')
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
('46559996499',200,301),
('46553786499',200,302)