CREATE DATABASE MedicalDatabase

USE MedicalDatabase

CREATE TABLE Specialisations (
	Id int IDENTITY(1,1) PRIMARY KEY,
	SpecialisationName nvarchar(30) NOT NULL UNIQUE
)
CREATE TABLE OperationTypes (
	Id int IDENTITY(1,1) PRIMARY KEY,
	OperationType nvarchar(30) NOT NULL UNIQUE
)
CREATE TABLE Surgeons (
	Oib int IDENTITY(1,1) PRIMARY KEY,
	PersonName nvarchar(30) NOT NULL,
	Surame nvarchar(30) NOT NULL,
	PhoneNumber nvarchar(10) NOT NULL,
	Adress nvarchar(10) NOT NULL,
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
	Oib int IDENTITY(1,1) PRIMARY KEY,
	PersonName nvarchar(30) NOT NULL,
	Surame nvarchar(30) NOT NULL,
	PhoneNumber nvarchar(10) NOT NULL,
	Adress nvarchar(10) NOT NULL,
	RoomId int FOREIGN KEY REFERENCES Rooms(RoomNumber),
	OperatingRoomId int FOREIGN KEY REFERENCES OperatingRooms(RoomNumber)
)
CREATE TABLE Patients (
	Oib int IDENTITY(1,1) PRIMARY KEY,
	PersonName nvarchar(30) NOT NULL,
	Surame nvarchar(30) NOT NULL,
	PhoneNumber nvarchar(10) NOT NULL,
	Adress nvarchar(10) NOT NULL,
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