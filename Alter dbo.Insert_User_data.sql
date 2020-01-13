USE [TeamProject]
GO

/****** Object: SqlProcedure [dbo].[Insert_User_data] Script Date: 16-12-2019 16:20:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER proc Insert_User_data(@ufname varchar(20),@ulname varchar(20),@dob date,
@pnumber varchar(20),@gmail varchar(20),@password varchar(20))
as
begin
insert into Airline_Registration values(@ufname,@ulname,@dob,@pnumber,@gmail,@password)
end
