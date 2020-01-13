USE [TeamProject]
GO

/****** Object: SqlProcedure [dbo].[Proc_UserLogin] Script Date: 17-12-2019 11:42:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER proc Proc_UserLogin(@email varchar(20),@password varchar(20) out)
as
begin
  set @password=(select password from tbUser where gmail=@email)
end
