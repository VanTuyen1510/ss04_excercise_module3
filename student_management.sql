drop database if exists student_management;

create database student_management;

use student_management;

create table class(
   classID int auto_increment not null primary key,
   className varchar(60)  not null,
   startDate datetime not null,
   status bit
);

create table student(
   studentID int auto_increment not null primary key,
   studentName varchar(30) not null,
   address varchar (50),
   phone varchar (20),
   status bit,
   
   classID int not null,
   constraint fk_class_ID_student foreign key (classID) references class(classID)
);

create table subject(
   subID int not null primary key auto_increment,
   subName varchar(30) not null,
   credit tinyint not null default 1 check (credit >= 1),
   status bit default 1
   

);
CREATE TABLE Mark
(
    MarkId    INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubId     INT NOT NULL,
    StudentId INT NOT NULL,
    Mark      FLOAT   DEFAULT 0 CHECK ( Mark BETWEEN 0 AND 100),
    ExamTimes TINYINT DEFAULT 1,
    UNIQUE (SubId, StudentId),
    FOREIGN KEY (SubId) REFERENCES Subject (SubId),
    FOREIGN KEY (StudentId) REFERENCES Student (StudentId)
);

INSERT INTO Class
VALUES (1, 'A1', '2008-12-20', 1);
INSERT INTO Class
VALUES (2, 'A2', '2008-12-22', 1);
INSERT INTO Class
VALUES (4, 'A3', '2008-05-22', 1);
INSERT INTO Class
VALUES (3, 'B3', current_date, 0);

INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES ('Hung', 'Ha Noi', '0912113113', 1, 1);
INSERT INTO Student (StudentName, Address, Status, ClassId)
VALUES ('Hoa', 'Hai phong', 1, 1);
INSERT INTO Student (StudentName, Address, Phone, Status, ClassId)
VALUES ('Manh', 'HCM', '0123123123', 0, 1);

INSERT INTO Subject
VALUES (1, 'CF', 5, 1),
       (2, 'C', 6, 1),
       (3, 'HDJ', 5, 1),
       (4, 'RDBMS', 10, 1);
       
INSERT INTO Mark (SubId, StudentId, Mark, ExamTimes)
VALUES (1, 1, 8, 1),
       (1, 2, 10, 2),
       (2, 1, 12, 1);
       
select studentName from student 
where studentName like 'h%';

select * from class
where month(startDate) = '12'; 

select credit from subject 
where  (credit between 3 and 5);		


-- SET SQL_SAFE_UPDATES = 0;
-- update student
-- set ClassId = 2
-- where StudentName = 'Hung';

select student.studentName , subject.subName , mark
from student 
join mark 
on student.studentID = mark.StudentId
join subject
on mark.SubId = subject.subID
order by mark desc;

select * from subject
where credit in (select max(credit) from subject);
-- max trả về bảng ,nên dùng in để tìm id để trả về 1 giá trị

select subject.subName , max(mark)
from subject
join mark on subject.subId = mark.subId
group by subject.subName;

-- group by gom lại 1 nhóm thành 1 cột chia thành các nhóm riêng biệt nên group by mark là sai

select student.* , avg(mark)
from student 
join mark on student.studentId = mark.studentId
group by  student.studentId order by avg(mark) desc;









