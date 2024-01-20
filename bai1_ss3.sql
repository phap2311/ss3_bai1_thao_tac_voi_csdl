drop database if exists quan_ly_sinh_vien_a;
create database if not exists quan_ly_sinh_vien_a;
use quan_ly_sinh_vien_a;

create table classes(
class_id int not null auto_increment primary key,
class_name varchar(60) not null,
start_date date not null,
status bit

);

create table student(
student_id int not null auto_increment primary key,
student_name varchar(30) not null,
address varchar(50),
phone varchar(20),
status_s bit,
class_id int not null,
foreign key (class_id) references classes (class_id)

);
create table subject_s(
sub_id int not null auto_increment primary key,
sub_name varchar (30) not null,
credit tinyint not null default 1 check (credit >=1 ),
status bit default 1
);
create table mark(
mark_id int not null auto_increment primary key,
sub_id int not null ,
student_id int not null,
mark_s float default 0 check (mark_s between 0 and 100),
exam_times tinyint default 1,
foreign key (sub_id) references subject_s (sub_id),
foreign key (student_id) references student(student_id)
);
insert into classes
values(1,'A1', '2008-12-20',1);
insert into classes
values (2,'A2','2008-12-22',1);
insert into classes
values (3,'B3', current_date(),0);
insert into student (student_name,address,phone,status_s,class_id)
values ('Hung','Ha Noi',0123456789,1,1);
insert into student (student_name,address,status_s,class_id)
values ('Hoa','Sai Gon',1,1);
insert into student (student_name,address,phone,status_s,class_id)
values ('Manh','Hue',0147258369,0,2);
insert into subject_s
values (1,'CF',5,1),
(2,'C',6,1),
(3,'HDJ',5,1),
(4,'RDBMS',5,1);
insert into mark (sub_id,student_id,mark_s,exam_times)
values (1,1,8,1),
(1,2,10,2),
(2,1,12,1);

-- Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’
select * from student 
where student_name like 'h%' ;

-- Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12

select * from classes
where month(start_date) = 12;

-- Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5
 select * from subject_s 
 where credit between 3 and 5;
 
 -- Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2
 SET SQL_SAFE_UPDATES = 0;
update student set class_id = 2
where student_name = 'hung'; 
select * from student;

-- Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu sắp xếp theo điểm thi (mark) giảm dần. nếu trùng sắp theo tên tăng dần.
select student_name, sub_name, mark_s
from student join mark on student.student_id = mark.student_id
join subject_s on mark.sub_id = subject_s.sub_id
order by mark_s desc , student_name asc;

