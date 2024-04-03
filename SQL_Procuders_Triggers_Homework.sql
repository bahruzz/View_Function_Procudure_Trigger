create database CourseDatabase

create table Students(
[Id] int primary key identity(1,1),
[Name] nvarchar(100) ,
[Surname] nvarchar(100),
[Age] int,
[Email] nvarchar(100),
[Adress]nvarchar(100)
)



create procedure usp_createStudent

@name nvarchar (100),
@surname nvarchar(100),
@age int,
@email nvarchar(200),
@adress nvarchar(200)
as
begin
 insert into Students([Name],[Surname],[Age],[Email],[Adress])
 values (@name,@surname,@age,@email,@adress)
end

exec usp_createStudent 'Reshad','Agayev',21,'reshad@gmail.com','neftciler'

select * from Students

select GETDATE()

create table StudentArchivesLogs(
[Id] int primary key identity(1,1),
[StudentId] int,
[Name] nvarchar(50),
[Operation] nvarchar(20),
[Date] datetime
)
select * from StudentArchivesLogs

create trigger trg_deleteStudentArchivesLogs on Students
after delete 
as
begin 
 insert into StudentArchivesLogs([StudentId],[Name],[Operation],[Date])
 select [Id], [Name],'Delete',GETDATE() from deleted
 end

 create procedure usp_deleteStudentById

@id int
as
begin
 delete from Students where id =@id
end



exec usp_deleteStudentById 4

exec usp_deleteStudentById 1


select * from Students

select * from StudentArchivesLogs

