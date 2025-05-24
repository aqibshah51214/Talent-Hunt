-- Create Database and Use it
CREATE DATABASE TalentHunt;
USE TalentHunt;

-- Create Users Table
CREATE TABLE Users (
    Id INT PRIMARY KEY,
    Password VARCHAR(50),
    Email VARCHAR(100),
    Role VARCHAR(20)
);

-- Create Student Table
CREATE TABLE Student (
    Id INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(50),
    Password VARCHAR(30),
    Gender VARCHAR(10),
    UserID INT,
    FOREIGN KEY (UserID) REFERENCES Users(Id)
);

-- Create CommitteeMember Table
CREATE TABLE CommitteeMember (
    Id INT PRIMARY KEY,
    Name VARCHAR(30),
    Email VARCHAR(30),
    Password VARCHAR(30),
    Gender VARCHAR(10),
    UserID INT,
    FOREIGN KEY (UserID) REFERENCES Users(Id)
);

-- Create Event Table
CREATE TABLE Event (
    Id INT PRIMARY KEY,
    Title VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    RegistrationDate DATE,
    Details TEXT,
    Fees VARCHAR(20)
);

-- Create AssignedMember Table
CREATE TABLE AssignedMember (
    Id INT PRIMARY KEY,
    EventID INT,
    CommitteeMemberID INT,
    FOREIGN KEY (EventID) REFERENCES Event(Id),
    FOREIGN KEY (CommitteeMemberID) REFERENCES CommitteeMember(Id)
);

-- Create Task Table
CREATE TABLE Task (
    Id INT PRIMARY KEY,
    TaskId INT FOREIGN KEY REFERENCES Event(Id),
    Name VARCHAR(50),
    Description TEXT,
    PathofSubmission TEXT,
    TaskDate DATE
);

-- Create Submission Table
CREATE TABLE Submission (
    Id INT PRIMARY KEY identity(1,1),
    PathofSubmission varchar(500),
	EventId Int,
    TaskID INT,
    StudentID INT,
    SubmitTime Time
     
);
--drop table Submission
-- Create Marks Table
CREATE TABLE Mark(
    Id INT PRIMARY KEY  identity(1,1),
	EventId Int,
    SubmissionID INT,
	StudentId Int,
    CommitteeMemberID INT,
    Marks DECIMAL
);

-- Create Apply Table
CREATE TABLE Apply(
    Id INT PRIMARY KEY  identity(1,1),
    StudentID INT,
    EventID INT,
    Status VARCHAR(10)
);
drop table Request
-- Create Rules Table
CREATE TABLE [Rule](
    Id INT PRIMARY KEY  identity(1,1),
    EventID INT,
    Description TEXT
    
);

-- Insert Data into Users Table
INSERT INTO [user] VALUES
('5555', 'Faizy@example.com', 'Student'),
('4444', 'awais@example.com', 'Student');
select * from [User]

-- Insert Data into Student Table
INSERT INTO Student (Id, Name, Email, Password, Gender, UserID) VALUES
(2, 'Faizyab Khan', 'faizy@gmail.com', '4444', 'Male', 6),
(3, 'Awais Ali Khan', 'ali@gmail.com', '5555', 'Male', 7);

-- Insert Data into CommitteeMember Table
INSERT INTO CommitteeMember VALUES
('Aqib', 'Male', 1),
('Nomi', 'Male', 2);
select * from CommitteeMember

-- Insert Data into Event Table
INSERT INTO Event VALUES
('Tech Expo', '2024-01-15', '2024-01-20', '2024-02-10', '2:10','2:30','A technology exhibition and workshops'),
('Art Competition', '2024-02-10', '2024-02-12', '2024-02-05','2:10','2:40', 'A creative art competition for students'),
('Science Fair', '2024-03-01', '2024-03-05', '2024-02-20','2:20','2:50', 'Science projects exhibition'),
('Sports Gala', '2024-04-10', '2024-04-15', '2024-03-25', '2:10','2:55','Various sports activities'),
('Music Concert', '2024-05-05', '2024-05-05', '2024-04-25','1:40','2:10', 'Live music performance by famous bands');
select * from AssignedMember
-- Insert Data into AssignedMember Table
INSERT INTO AssignedMember (EventID, CommitteeMemberID) VALUES
(1, 1),
(2, 2),
(3, 2),
(4, 1),
(5, 2);

-- Insert Data into Task Table
INSERT INTO Task VALUES
 
 
(3, 'Art Submission Review', 'Review submitted artworks for the competition.', '2024-03-01','1:10','1:40')
(4, 'Science Demo Setup', 'Set up the science project demonstration area.', 2024-04-01,'1:20','1:45'),
(5, 'Sports Arrangements', 'Arrange equipment and venues for sports events.', 2024-05-01,'1:30','1:55')
select * from Task
-- Insert Data into Submission Table
INSERT INTO Submission  VALUES
('Booth Design Draft',2, 1, 2, '10:00 AM'),
('Artwork Sketch', 2,2, 3, '11:00 AM');
select * from Submission
-- Insert Data into Marks Table
INSERT INTO Mark VALUES
(4, 3, 1,3, 9.5),
(2, 2, 2,2, 8.0);
select * from Apply
-- Insert Data into Apply Table
INSERT INTO Apply VALUES
(3, 2,  'Accept'),
(2, 3,  'Reject');

-- Insert Data into Rules Table
INSERT INTO Rule VALUES
(3, 'No late submissions allowed.'),
(2, 'Original artwork only.');
select * from [Rule]