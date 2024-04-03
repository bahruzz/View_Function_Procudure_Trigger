
select * from Teachers

create view getTeacherWithId
as
select * from Teachers where [Id]>3

select * from getTeacherWithId

create view getTeacherWithAge
as
select TOP 3 * from Teachers where [Age]>19

select * from getTeacherWithAge

create function dbo.sayHelloWorld()
returns nvarchar(50)
as
begin
 return 'Hello World'
end

select dbo.sayHelloWorld()

declare @data nvarchar(30)=(select dbo.sayHelloWorld())
print @data

create function dbo.showText(@text nvarchar(50))
returns nvarchar(50)
as
begin
 return @text
end

select dbo.showText('Elasiz Resad bey')

create function dbo.sumOfNums(@num1 int,@num2 int)
returns int
as
begin
 return @num1+@num2
end

select dbo.sumOFNums(100,55)

declare @id int= (select dbo.sumOFNums(1,2))
select * from Teachers where[Id]=@id

create function dbo.getTeacherByAge(@age int)
returns int
as
begin
 declare @count int;
 select @count =Count (*) from Teachers where [Age]>@age
 return @count
end

select * from Teachers

select dbo.getTeacherByAge(18) as 'Teacher count'

create function dbo.getAllTeachers()
returns table
as
return (select * from Teachers)

select * from getAllTeachers()


create function dbo.searchTeachersByName(@searchtext nvarchar(50))
returns table
as
return (select * from Teachers where [Name] like '%' + @searchtext + '%')

select * from searchTeachersByName('a')


select * from Teachers


create procedure usp_ShowText
as
begin
 print 'salamlar'
end

usp_ShowText

create procedure usp_ShowText2
@text nvarchar (50)
as
begin
 print @text
end

usp_ShowText2 'Salam Fatime xanim'

create procedure usp_createTeacher
@name nvarchar (100),
@surname nvarchar(100),
@email nvarchar(200),
@age int
as
begin
 insert into Teachers([Name],[Surname],[Email],[Age])
 values (@name,@surname,@email,@age)
end


exec usp_createTeacher 'Fexriyye','Tagizade','fexriyye@gmail.com',21

select * from Teachers

create procedure usp_deleteTeacherById

@id int
as
begin
 delete from Teachers where id =@id
end

exec usp_deleteTeacherById 4

create function dbo.getTeachersAvgAges(@id int)
returns int
as
begin
declare @avgAge int;
select @avgAge=AVG(Age) from Teachers where [Id] > @id
return @avgAge
end

select dbo.getTeachersAvgAges(3)
select * from Teachers



create procedure usp_chanegTeachersNameByCondition

@id int,
@name nvarchar(50)
as
begin
 declare @avgAge int=(select dbo.getTeachersAvgAges(@id))
 update Teachers
 set [Name]= @name
 where [Age] > @avgAge
end


exec usp_chanegTeachersNameByCondition 3, 'XXX'

select * from Teachers order by [Age] asc

select GETDATE()

create table TeacherLogs(
[Id] int primary key identity(1,1),
[TeacherId] int,
[Operation] nvarchar(20),
[Date] datetime
)

create trigger trg_createTeacherLogs on Teachers
after insert 
as
begin 
 insert into TeacherLogs([TeacherId],[Operation],[Date])
 select [Id], 'Insert',GETDATE() from inserted
 end

exec usp_createTeacher 'Zeygem','Ashurov','zeygem@gmail.com',39

select * from TeacherLogs

create trigger trg_deleteTeacherLogs on Teachers
after delete 
as
begin 
 insert into TeacherLogs([TeacherId],[Operation],[Date])
 select [Id], 'Delete',GETDATE() from deleted
 end


 select * from Teachers

exec usp_deleteTeacherById 2


create trigger trg_updateTeacherLogs on Teachers
after update
as
begin 
 
 insert into TeacherLogs([TeacherId],[Operation],[Date])
 select [Id], 'Update',GETDATE() from deleted
 end