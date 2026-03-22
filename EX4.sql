create database ElearningDB;

create schema elearning;

create table Students(
	student_id serial primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	email varchar(255) not null unique
);

create table Instructors(
	instructor_id serial primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	email varchar(255) not null unique	
);

create table Courses(
	course_id serial primary key,
	course_name varchar(100) not null,
	instructor_id int references instructors(instructor_id)
);

create table Enrollments(
	enrollment_id serial primary key,
	student_id int references students(student_id),
	course_id int references courses(course_id),
	enroll_date Date
);

create table Assignments(
	assignment_id serial primary key,
	course_id int references courses(course_id),
	title varchar(100) not null,
	due_date Date
);

create table Submissions(
	submission_id serial primary key,
	assignment_id int references assignments(assignment_id),
	student_id int references students(student_id),
	submission_date Date,
	grade int check (grade between 0 and 100)
);
