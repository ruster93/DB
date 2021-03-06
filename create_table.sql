--Classroom -----------------------------------------
IF OBJECT_ID('Classroom', 'U') IS NOT NULL
begin
  IF OBJECT_ID('Schedule', 'U') IS NOT NULL
  begin
	DROP TABLE Schedule;
  end
  DROP TABLE Classroom;
end
GO

CREATE TABLE Classroom
(
Number int,
PRIMARY KEY (Number)
)

--Course -----------------------------------------
IF OBJECT_ID('Course', 'U') IS NOT NULL
begin
  IF OBJECT_ID('Schedule', 'U') IS NOT NULL
  begin
	DROP TABLE Schedule;
  end
  DROP TABLE Course;
end
GO

CREATE TABLE Course
(
CourseID int,
Name	 varchar(256) NOT NULL,
PRIMARY KEY (CourseID)
)

--Lesson -----------------------------------------
IF OBJECT_ID('Lesson', 'U') IS NOT NULL
begin
  IF OBJECT_ID('Schedule', 'U') IS NOT NULL
  begin
	DROP TABLE Schedule;
  end
  DROP TABLE Lesson;
end
GO

CREATE TABLE Lesson
(
Number		int			NOT NULL,
LessonType  int			NOT NULL, --varchar(64) NOT NULL,
StartTime   TIME		NOT NULL,
EndTime		TIME		NOT NULL,
CHECK (LessonType IN (1, 2, 3)), --'�������', '��������', '�����������')),
INDEX LessonIndex CLUSTERED (StartTime,EndTime, LessonType, Number),
PRIMARY KEY (Number, LessonType)
)

--Schedule -----------------------------------------
IF OBJECT_ID('Schedule', 'U') IS NOT NULL
begin
  DROP TABLE Schedule;
end
GO

CREATE TABLE Schedule
(
DayWeek		 int		 NOT NULL, --varchar(64) NOT NULL,
LessonNumber int		 NOT NULL,
LessonType   int		 NOT NULL, --varchar(64) NOT NULL,
Classroom	 int		 NOT NULL,
CourseID	 int		 NOT NULL,
CHECK (DayWeek IN (1, 2, 3, 4, 5, 6, 7)),--('��', '��', '��', '��', '��', '��', '��')),
INDEX LessonIndex CLUSTERED (DayWeek, LessonNumber, LessonType),
PRIMARY KEY (LessonNumber, LessonType, Classroom, CourseID, DayWeek),
FOREIGN KEY (LessonNumber, LessonType) REFERENCES Lesson(Number, LessonType),
FOREIGN KEY (Classroom)			       REFERENCES Classroom(Number),
FOREIGN KEY (CourseID)				   REFERENCES Course(CourseID)
)
