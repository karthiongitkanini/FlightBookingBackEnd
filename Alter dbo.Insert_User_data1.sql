USE [TeamProject]
GO

/****** Object: SqlProcedure [dbo].[Insert_User_data] Script Date: 17-12-2019 11:13:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER proc Insert_User_data(@ufname varchar(20),@ulname varchar(20),
@pnumber varchar(20),@gmail varchar(20),@password varchar(20))
as
begin
insert into tbUser(User_fname,User_lname,phone_number,gmail,password) values(@ufname,@ulname,@pnumber,@gmail,@password)
end

exec Insert_User_data 'Mari','Muthu','8883128385','marimuthu.senthil@kanini.com','987654321'

select * from tbUser


