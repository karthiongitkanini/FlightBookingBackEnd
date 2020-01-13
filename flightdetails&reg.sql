create database TeamProject
use TeamProject

drop table tbUser
drop table tbCity
drop table tbDate
drop table tbFlight_Type
drop table tbFlight_Details
drop table Booking_Details
drop table Passengers
drop table Payment
select * from Booking_Details
select * from Passengers

--create table tbUser(User_Id int identity(1,1) constraint pk_UserId primary key,F_Name varchar(20),L_Name varchar(20),DOB Date,Nationality varchar(15),
--Mobile_Number varchar(11),Email varchar(20),Password varchar(20))

create table tbUser(User_Id int identity(1,1) constraint pk_UserId primary key,User_fname varchar(20),User_lname varchar(20),
phone_number varchar(20),gmail varchar(20) not null unique,password varchar(20))

insert into tbUser values('aaa','bbb','9485979489','m@gmail.com','123456789')

create table tbCity(City_Id varchar(6) constraint pk_cid primary key,City_Name varchar(20))

create table tbFlight_Type(Fl_Id varchar(6) constraint pk_fid primary key,Fl_Name varchar(20),Fl_Type varchar(15))

create table tbDate(D_Id varchar(6) primary key,D_Date varchar(10))

create table tbFlight_Details(FD_Id int identity(0001,1) constraint pk_fdid primary key,FT_Id varchar(6) constraint fk_ftid foreign key
references tbFlight_Type(Fl_Id),S_Id varchar(6) constraint fk_sid foreign key references tbCity(City_Id),
Des_Id varchar(6) constraint fk_did foreign key references tbCity(City_Id),Departure_Time varchar(10),Arrival_Time varchar(10),
FDate_Id varchar(6) foreign key references tbDate(D_Id),Duration varchar(10),Fare varchar(15))

create table Booking_Details(Book_Id int identity(0001,1) constraint pk_bid primary key,BFD_Id int foreign key references tbFlight_Details(FD_Id),
User_Id int foreign key references tbUser(User_Id), Booked_Date varchar(6) 
foreign key references tbDate(D_Id))

alter proc proc_bookingflight(@flightid int,@username varchar(20))
as
declare @date varchar(6),@userid int
begin
	select @userid = (select User_Id from tbUser where gmail = @username)
	select @date = (select FDate_Id from tbFlight_Details where FD_Id = @flightid)
	insert into Booking_Details values(@flightid,@userid,@date)
end
exec proc_bookingflight '123',''
select * from Booking_Details
select * from tbUser
	

create table Passengers(Ps_Id int IDENTITY(0001,1) primary key,BP_Id int foreign key references Booking_Details(Book_Id),
Ps_Name varchar(20),Ps_Age varchar(2),Ps_Gender varchar(20))

select * from Passengers
select * from Booking_Details

--create table Payment(Pay_Id int identity(0001,1) primary key,Pay_Type varchar(15),Book_Id int foreign key references Booking_Details(Book_Id))

------Stored Procedure---------------
alter proc proc_SearchFlight(@date varchar(10),@source varchar(20),@destination varchar(20))
as
begin
select FD_Id,Departure_Time,Arrival_Time,Duration,Fare	from tbFlight_Details fd join tbCity c on c.City_Id = fd.S_Id join tbDate d 
on d.D_Id = fd.FDate_Id join tbFlight_Type ft on ft.Fl_Id = fd.FT_Id where S_Id =(select City_Id from tbCity where City_Name =@source) and 
Des_Id = (select City_Id from tbCity where City_Name = @destination) and FDate_Id = (select D_Id from tbDate where D_Date= @date)
end


exec proc_SearchFlight '2019-12-25','Goa','Chennai'
-------------------
--alter proc proc_refDetails
--as
--declare @Passenger int
--declare @fare int
--begin

--select @Passenger = (select count(*) from Passengers where BP_Id = 1 )
--select @fare = (select sum(@Passenger * fare) from tbFlight_Details where FD_Id = 233)
--select S_Id,Des_Id,Departure_Time,Arrival_Time,@Passenger as Passenger,D_Date,@fare as Totalfare from tbFlight_Details fd
--join Booking_Details bd on fd.FD_Id = bd.BFD_Id join tbDate da on da.D_Id = fd.FDate_Id
-- where Book_Id = 1
--end

ALTER proc proc_refDetails
as
declare @Book_Id int
declare @Passenger int
declare @fare int
declare @BFD_Id int
begin
	select @Book_Id = (select max(Book_Id) from Booking_Details)
	select @Passenger = (select count(*) from Passengers where BP_Id = @Book_Id )
	select @BFD_Id = (select BFD_Id from Booking_Details where Book_Id = @Book_Id)
	select @fare = (select sum(@Passenger * fare) from tbFlight_Details where FD_Id = @BFD_Id)
	select S_Id,Des_Id,Departure_Time,Arrival_Time,@Passenger as Passenger,D_Date,@fare as Totalfare from tbFlight_Details fd
	join Booking_Details bd on fd.FD_Id = bd.BFD_Id join tbDate da on da.D_Id = fd.FDate_Id
	  where Book_Id = @Book_Id
end
exec proc_refDetails
----------------------



insert into tbCity values('CHE','Chennai')
insert into tbCity values('MUB','Mumbai')
insert into tbCity values('GOA','Goa')
insert into tbCity values('HYD','Hyderabad')
insert into tbCity values('KKT','Kolkata')
insert into tbCity values('TVP','Thiruvanadhapuram')

insert into tbFlight_Type values('FT101','KingFisher','Ballistic')
insert into tbFlight_Type values('FT102','SpiceJet','Aviation')
insert into tbFlight_Type values('FT103','AirJet','Forces')
insert into tbFlight_Type values('FT104','Indigo','Buoyant')
insert into tbFlight_Type values('FT105','Emirates','Range')
update tbDate set D_Date = '12/01/2019' where D_Id = 'D001'
insert into tbDate values('D001','2019-12-01')
insert into tbDate values('D002','2019-12-02')
insert into tbDate values('D003','2019-12-03')
insert into tbDate values('D004','2019-12-04')
insert into tbDate values('D005','2019-12-05')
insert into tbDate values('D006','2019-12-06')
insert into tbDate values('D007','2019-12-07')
insert into tbDate values('D008','2019-12-08')
insert into tbDate values('D009','2019-12-09')
insert into tbDate values('D010','2019-12-10')
insert into tbDate values('D011','2019-12-11')
insert into tbDate values('D012','2019-12-12')
insert into tbDate values('D013','2019-12-13')
insert into tbDate values('D014','2019-12-14')
insert into tbDate values('D015','2019-12-15')
insert into tbDate values('D016','2019-12-16')
insert into tbDate values('D017','2019-12-17')
insert into tbDate values('D018','2019-12-18')
insert into tbDate values('D019','2019-12-19')
insert into tbDate values('D020','2019-12-20')
insert into tbDate values('D021','2019-12-21')
insert into tbDate values('D022','2019-12-22')
insert into tbDate values('D023','2019-12-23')
insert into tbDate values('D024','2019-12-24')
insert into tbDate values('D025','2019-12-25')
insert into tbDate values('D026','2019-12-26')
insert into tbDate values('D027','2019-12-27')
insert into tbDate values('D028','2019-12-28')
insert into tbDate values('D029','2019-12-29')
insert into tbDate values('D030','2019-12-30')
insert into tbDate values('D031','2019-12-31')





insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D001','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D001','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D001','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D001','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D001','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D001','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D001','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D001','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D001','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D001','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D001','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D001','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D001','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D001','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D001','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D001','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D001','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D001','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D001','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D001','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D001','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D001','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D001','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D001','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D001','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D001','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D001','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D001','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D001','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D001','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D002','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D002','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D002','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D002','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D002','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D002','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D002','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D002','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D002','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D002','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D002','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D002','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D002','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D002','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D002','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D002','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D002','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D002','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D002','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D002','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D002','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D002','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D002','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D002','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D002','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D002','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D002','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D002','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D002','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D002','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D003','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D003','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D003','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D003','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D003','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D003','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D003','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D003','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D003','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D003','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D003','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D003','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D003','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D003','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D003','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D003','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D003','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D003','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D003','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D003','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D003','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D003','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D003','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D003','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D003','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D003','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D003','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D003','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D003','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D003','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D004','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D004','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D004','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D004','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D004','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D004','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D004','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D004','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D004','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D004','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D004','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D004','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D004','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D004','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D004','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D004','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D004','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D004','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D004','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D004','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D004','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D004','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D004','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D004','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D004','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D004','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D004','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D004','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D004','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D004','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D005','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D005','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D005','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D005','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D005','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D005','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D005','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D005','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D005','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D005','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D005','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D005','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D005','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D005','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D005','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D005','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D005','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D005','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D005','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D005','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D005','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D005','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D005','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D005','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D005','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D005','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D005','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D005','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D005','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D005','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D006','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D006','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D006','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D006','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D006','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D006','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D006','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D006','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D006','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D006','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D006','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D006','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D006','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D006','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D006','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D006','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D006','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D006','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D006','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D006','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D006','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D006','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D006','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D006','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D006','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D006','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D006','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D006','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D006','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D006','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D007','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D007','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D007','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D007','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D007','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D007','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D007','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D007','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D007','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D007','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D007','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D007','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D007','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D007','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D007','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D007','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D007','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D007','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D007','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D007','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D007','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D007','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D007','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D007','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D007','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D007','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D007','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D007','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D007','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D007','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D008','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D008','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D008','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D008','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D008','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D008','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D008','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D008','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D008','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D008','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D008','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D008','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D008','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D008','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D008','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D008','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D008','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D008','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D008','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D008','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D008','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D008','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D008','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D008','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D008','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D008','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D008','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D008','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D008','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D008','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D009','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D009','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D009','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D009','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D009','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D009','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D009','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D009','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D009','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D009','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D009','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D009','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D009','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D009','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D009','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D009','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D009','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D009','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D009','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D009','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D009','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D009','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D009','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D009','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D009','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D009','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D009','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D009','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D009','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D009','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D010','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D010','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D010','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D010','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D010','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D010','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D010','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D010','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D010','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D010','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D010','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D010','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D010','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D010','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D010','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D010','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D010','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D010','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D010','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D010','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D010','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D010','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D010','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D010','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D010','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D010','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D010','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D010','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D010','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D010','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D011','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D011','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D011','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D011','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D011','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D011','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D011','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D011','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D011','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D011','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D011','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D011','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D011','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D011','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D011','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D011','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D011','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D011','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D011','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D011','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D011','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D011','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D011','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D011','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D011','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D011','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D011','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D011','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D011','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D011','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D012','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D012','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D012','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D012','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D012','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D012','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D012','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D012','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D012','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D012','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D012','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D012','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D012','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D012','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D012','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D012','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D012','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D012','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D012','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D012','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D012','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D012','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D012','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D012','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D012','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D012','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D012','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D012','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D012','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D012','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D013','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D013','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D013','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D013','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D013','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D013','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D013','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D013','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D013','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D013','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D013','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D013','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D013','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D013','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D013','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D013','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D013','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D013','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D013','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D013','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D013','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D013','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D013','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D013','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D013','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D013','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D013','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D013','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D013','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D013','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D014','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D014','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D014','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D014','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D014','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D014','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D014','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D014','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D014','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D014','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D014','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D014','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D014','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D014','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D014','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D014','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D014','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D014','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D014','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D014','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D014','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D014','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D014','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D014','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D014','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D014','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D014','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D014','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D014','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D014','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D015','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D015','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D015','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D015','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D015','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D015','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D015','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D015','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D015','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D015','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D015','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D015','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D015','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D015','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D015','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D015','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D015','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D015','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D015','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D015','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D015','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D015','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D015','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D015','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D015','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D015','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D015','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D015','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D015','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D015','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D016','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D016','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D016','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D016','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D016','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D016','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D016','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D016','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D016','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D016','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D016','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D016','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D016','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D016','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D016','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D016','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D016','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D016','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D016','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D016','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D016','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D016','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D016','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D016','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D016','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D016','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D016','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D016','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D016','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D016','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D017','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D017','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D017','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D017','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D017','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D017','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D017','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D017','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D017','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D017','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D017','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D017','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D017','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D017','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D017','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D017','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D017','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D017','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D017','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D017','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D017','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D017','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D017','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D017','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D017','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D017','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D017','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D017','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D017','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D017','6h','3900')


insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D018','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D018','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D018','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D018','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D018','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D018','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D018','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D018','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D018','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D018','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D018','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D018','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D018','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D018','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D018','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D018','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D018','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D018','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D018','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D018','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D018','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D018','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D018','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D018','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D018','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D018','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D018','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D018','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D018','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D018','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D019','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D019','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D019','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D019','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D019','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D019','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D019','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D019','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D019','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D019','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D019','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D019','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D019','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D019','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D019','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D019','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D019','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D019','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D019','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D019','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D019','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D019','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D019','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D019','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D019','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D019','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D019','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D019','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D019','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D019','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D020','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D020','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D020','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D020','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D020','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D020','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D020','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D020','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D020','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D020','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D020','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D020','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D020','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D020','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D020','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D020','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D020','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D020','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D020','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D020','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D020','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D020','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D020','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D020','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D020','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D020','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D020','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D020','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D020','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D020','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D021','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D021','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D021','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D021','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D021','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D021','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D021','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D021','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D021','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D021','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D021','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D021','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D021','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D021','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D021','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D021','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D021','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D021','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D021','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D021','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D021','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D021','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D021','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D021','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D021','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D021','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D021','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D021','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D021','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D021','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D022','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D022','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D022','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D022','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D022','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D022','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D022','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D022','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D022','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D022','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D022','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D022','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D022','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D022','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D022','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D022','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D022','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D022','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D022','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D022','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D022','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D022','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D022','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D022','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D022','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D022','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D022','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D022','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D022','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D022','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D023','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D023','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D023','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D023','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D023','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D023','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D023','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D023','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D023','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D023','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D023','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D023','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D023','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D023','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D023','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D023','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D023','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D023','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D023','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D023','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D023','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D023','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D023','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D023','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D023','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D023','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D023','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D023','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D023','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D023','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D024','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D024','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D024','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D024','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D024','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D024','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D024','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D024','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D024','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D024','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D024','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D024','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D024','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D024','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D024','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D024','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D024','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D024','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D024','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D024','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D024','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D024','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D024','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D024','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D024','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D024','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D024','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D024','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D024','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D024','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D025','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D025','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D025','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D025','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D025','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D025','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D025','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D025','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D025','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D025','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D025','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D025','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D025','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D025','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D025','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D025','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D025','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D025','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D025','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D025','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D025','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D025','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D025','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D025','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D025','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D025','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D025','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D025','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D025','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D025','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D026','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D026','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D026','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D026','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D026','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D026','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D026','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D026','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D026','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D026','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D026','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D026','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D026','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D026','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D026','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D026','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D026','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D026','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D026','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D026','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D026','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D026','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D026','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D026','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D026','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D026','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D026','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D026','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D026','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D026','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D027','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D027','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D027','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D027','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D027','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D027','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D027','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D027','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D027','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D027','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D027','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D027','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D027','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D027','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D027','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D027','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D027','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D027','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D027','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D027','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D027','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D027','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D027','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D027','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D027','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D027','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D027','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D027','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D027','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D027','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D028','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D028','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D028','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D028','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D028','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D028','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D028','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D028','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D028','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D028','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D028','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D028','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D028','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D028','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D028','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D028','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D028','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D028','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D028','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D028','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D028','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D028','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D028','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D028','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D028','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D028','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D028','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D028','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D028','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D028','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D029','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D029','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D029','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D029','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D029','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D029','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D029','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D029','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D029','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D029','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D029','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D029','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D029','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D029','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D029','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D029','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D029','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D029','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D029','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D029','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D029','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D029','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D029','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D029','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D029','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D029','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D029','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D029','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D029','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D029','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D030','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D030','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D030','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D030','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D030','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D030','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D030','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D030','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D030','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D030','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D030','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D030','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D030','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D030','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D030','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D030','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D030','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D030','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D030','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D030','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D030','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D030','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D030','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D030','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D030','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D030','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D030','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D030','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D030','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D030','6h','3900')

insert into tbFlight_Details values('FT101','CHE','MUB','10.00AM','02.00PM','D031','4h','2500')
insert into tbFlight_Details values('FT102','CHE','GOA','11.00AM','05.00PM','D031','6h','3800')
insert into tbFlight_Details values('FT103','CHE','HYD','07.00AM','04.30PM','D031','10h 30m','6900')
insert into tbFlight_Details values('FT104','CHE','KKT','08.00AM','05.00PM','D031','9h','5700')
insert into tbFlight_Details values('FT105','CHE','TVP','09.00AM','02.00PM','D031','5h','3300')
insert into tbFlight_Details values('FT101','MUB','CHE','10.00AM','02.00PM','D031','4h','2500')
insert into tbFlight_Details values('FT102','MUB','GOA','11.00AM','03.00PM','D031','4h','3200')
insert into tbFlight_Details values('FT103','MUB','HYD','10.30AM','04.00PM','D031','5h 30m','3900')
insert into tbFlight_Details values('FT104','MUB','KKT','09.30AM','05.00PM','D031','7h 30m','5400')
insert into tbFlight_Details values('FT105','MUB','TVP','10.00AM','04.00PM','D031','6h','3900')
insert into tbFlight_Details values('FT101','GOA','CHE','09.00AM','04.00PM','D031','7h','4400')
insert into tbFlight_Details values('FT102','GOA','MUB','09.00AM','02.00PM','D031','5h','3300')
insert into tbFlight_Details values('FT103','GOA','HYD','08.00AM','05.00PM','D031','9h','5700')
insert into tbFlight_Details values('FT104','GOA','KKT','11.00AM','05.00PM','D031','6h','4900')
insert into tbFlight_Details values('FT105','GOA','TVP','09.00AM','03.00PM','D031','6h','4900')
insert into tbFlight_Details values('FT101','HYD','CHE','09.00AM','04.00PM','D031','7h','4400')
insert into tbFlight_Details values('FT102','HYD','MUB','11.00AM','05.00PM','D031','6h','3800')
insert into tbFlight_Details values('FT103','HYD','GOA','07.00AM','04.30PM','D031','10h 30m','6900')
insert into tbFlight_Details values('FT104','HYD','KKT','08.00AM','05.00PM','D031','9h','5700')
insert into tbFlight_Details values('FT105','HYD','TVP','11.00AM','05.00PM','D031','6h','3800')
insert into tbFlight_Details values('FT101','KKT','CHE','10.00AM','02.00PM','D031','4h','2500')
insert into tbFlight_Details values('FT102','KKT','MUB','11.00AM','05.00PM','D031','6h','3800')
insert into tbFlight_Details values('FT103','KKT','GOA','07.00AM','04.30PM','D031','10h 30m','6900')
insert into tbFlight_Details values('FT104','KKT','HYD','08.00AM','05.00PM','D031','9h','5700')
insert into tbFlight_Details values('FT105','KKT','TVP','09.00AM','02.00PM','D031','5h','3300')
insert into tbFlight_Details values('FT101','TVP','CHE','10.00AM','02.00PM','D031','4h','2500')
insert into tbFlight_Details values('FT102','TVP','MUB','11.00AM','03.00PM','D031','4h','3200')
insert into tbFlight_Details values('FT103','TVP','GOA','10.30AM','04.00PM','D031','5h 30m','3900')
insert into tbFlight_Details values('FT104','TVP','HYD','09.30AM','05.00PM','D031','7h 30m','5400')
insert into tbFlight_Details values('FT105','TVP','KKT','10.00AM','04.00PM','D031','6h','3900')




insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D001','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D001','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D001','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D001','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D001','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D001','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D001','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D001','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D001','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D001','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D001','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D001','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D001','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D001','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D001','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D001','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D001','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D001','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D001','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D001','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D001','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D001','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D001','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D001','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D001','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D001','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D001','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D001','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D001','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D001','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D002','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D002','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D002','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D002','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D002','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D002','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D002','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D002','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D002','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D002','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D002','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D002','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D002','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D002','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D002','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D002','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D002','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D002','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D002','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D002','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D002','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D002','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D002','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D002','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D002','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D002','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D002','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D002','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D002','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D002','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D003','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D003','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D003','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D003','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D003','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D003','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D003','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D003','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D003','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D003','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D003','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D003','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D003','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D003','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D003','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D003','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D003','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D003','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D003','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D003','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D003','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D003','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D003','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D003','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D003','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D003','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D003','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D003','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D003','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D003','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D004','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D004','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D004','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D004','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D004','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D004','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D004','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D004','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D004','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D004','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D004','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D004','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D004','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D004','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D004','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D004','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D004','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D004','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D004','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D004','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D004','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D004','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D004','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D004','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D004','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D004','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D004','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D004','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D004','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D004','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D005','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D005','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D005','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D005','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D005','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D005','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D005','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D005','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D005','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D005','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D005','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D005','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D005','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D005','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D005','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D005','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D005','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D005','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D005','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D005','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D005','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D005','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D005','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D005','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D005','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D005','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D005','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D005','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D005','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D005','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D006','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D006','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D006','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D006','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D006','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D006','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D006','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D006','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D006','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D006','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D006','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D006','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D006','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D006','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D006','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D006','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D006','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D006','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D006','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D006','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D006','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D006','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D006','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D006','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D006','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D006','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D006','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D006','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D006','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D006','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D007','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D007','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D007','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D007','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D007','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D007','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D007','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D007','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D007','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D007','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D007','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D007','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D007','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D007','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D007','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D007','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D007','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D007','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D007','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D007','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D007','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D007','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D007','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D007','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D007','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D007','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D007','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D007','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D007','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D007','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D008','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D008','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D008','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D008','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D008','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D008','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D008','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D008','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D008','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D008','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D008','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D008','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D008','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D008','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D008','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D008','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D008','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D008','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D008','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D008','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D008','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D008','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D008','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D008','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D008','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D008','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D008','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D008','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D008','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D008','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D009','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D009','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D009','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D009','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D009','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D009','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D009','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D009','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D009','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D009','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D009','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D009','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D009','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D009','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D009','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D009','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D009','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D009','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D009','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D009','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D009','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D009','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D009','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D009','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D009','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D009','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D009','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D009','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D009','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D009','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D010','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D010','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D010','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D010','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D010','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D010','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D010','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D010','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D010','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D010','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D010','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D010','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D010','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D010','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D010','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D010','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D010','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D010','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D010','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D010','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D010','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D010','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D010','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D010','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D010','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D010','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D010','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D010','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D010','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D010','5h 50m','3650')



insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D011','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D011','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D011','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D011','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D011','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D011','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D011','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D011','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D011','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D011','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D011','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D011','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D011','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D011','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D011','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D011','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D011','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D011','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D011','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D011','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D011','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D011','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D011','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D011','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D011','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D011','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D011','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D011','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D011','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D011','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D012','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D012','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D012','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D012','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D012','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D012','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D012','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D012','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D012','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D012','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D012','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D012','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D012','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D012','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D012','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D012','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D012','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D012','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D012','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D012','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D012','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D012','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D012','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D012','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D012','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D012','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D012','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D012','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D012','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D012','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D013','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D013','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D013','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D013','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D013','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D013','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D013','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D013','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D013','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D013','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D013','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D013','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D013','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D013','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D013','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D013','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D013','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D013','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D013','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D013','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D013','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D013','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D013','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D013','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D013','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D013','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D013','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D013','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D013','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D013','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D014','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D014','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D014','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D014','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D014','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D014','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D014','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D014','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D014','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D014','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D014','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D014','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D014','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D014','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D014','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D014','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D014','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D014','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D014','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D014','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D014','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D014','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D014','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D014','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D014','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D014','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D014','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D014','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D014','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D014','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D015','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D015','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D015','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D015','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D015','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D015','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D015','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D015','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D015','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D015','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D015','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D015','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D015','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D015','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D015','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D015','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D015','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D015','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D015','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D015','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D015','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D015','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D015','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D015','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D015','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D015','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D015','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D015','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D015','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D015','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D016','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D016','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D016','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D016','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D016','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D016','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D016','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D016','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D016','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D016','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D016','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D016','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D016','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D016','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D016','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D016','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D016','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D016','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D016','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D016','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D016','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D016','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D016','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D016','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D016','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D016','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D016','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D016','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D016','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D016','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D017','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D017','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D017','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D017','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D017','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D017','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D017','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D017','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D017','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D017','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D017','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D017','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D017','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D017','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D017','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D017','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D017','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D017','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D017','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D017','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D017','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D017','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D017','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D017','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D017','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D017','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D017','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D017','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D017','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D017','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D018','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D018','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D018','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D018','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D018','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D018','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D018','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D018','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D018','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D018','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D018','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D018','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D018','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D018','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D018','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D018','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D018','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D018','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D018','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D018','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D018','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D018','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D018','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D018','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D018','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D018','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D018','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D018','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D018','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D018','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D019','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D019','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D019','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D019','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D019','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D019','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D019','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D019','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D019','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D019','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D019','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D019','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D019','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D019','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D019','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D019','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D019','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D009','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D019','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D019','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D019','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D019','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D019','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D019','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D019','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D019','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D019','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D019','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D019','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D019','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D020','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D020','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D020','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D020','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D020','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D020','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D020','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D020','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D020','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D020','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D020','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D020','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D020','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D020','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D020','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D020','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D020','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D020','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D020','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D020','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D020','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D020','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D020','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D020','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D020','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D020','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D020','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D020','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D020','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D020','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D021','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D021','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D021','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D021','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D021','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D021','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D021','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D021','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D021','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D021','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D021','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D021','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D021','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D021','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D021','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D021','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D021','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D021','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D021','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D021','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D021','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D021','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D021','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D021','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D021','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D021','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D021','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D021','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D021','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D021','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D022','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D022','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D022','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D022','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D022','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D022','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D022','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D022','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D022','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D022','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D022','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D022','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D022','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D022','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D022','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D022','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D022','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D022','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D022','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D022','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D022','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D022','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D022','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D022','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D022','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D022','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D022','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D022','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D022','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D022','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D023','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D023','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D023','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D023','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D023','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D023','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D023','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D023','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D023','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D023','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D023','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D023','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D023','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D023','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D023','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D023','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D023','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D023','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D023','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D023','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D023','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D023','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D023','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D023','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D023','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D023','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D023','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D023','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D023','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D023','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D024','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D024','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D024','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D024','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D024','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D024','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D024','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D024','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D024','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D024','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D024','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D024','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D024','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D024','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D024','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D024','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D024','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D024','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D024','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D024','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D024','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D024','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D024','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D024','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D024','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D024','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D024','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D024','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D024','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D024','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D025','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D025','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D025','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D025','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D025','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D025','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D025','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D025','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D025','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D025','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D025','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D025','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D025','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D025','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D025','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D025','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D025','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D025','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D025','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D025','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D025','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D025','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D025','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D025','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D025','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D025','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D025','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D025','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D025','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D025','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D026','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D026','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D026','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D026','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D026','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D026','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D026','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D026','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D026','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D026','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D026','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D026','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D026','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D026','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D026','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D026','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D026','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D026','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D026','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D026','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D026','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D026','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D026','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D026','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D026','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D026','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D026','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D026','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D026','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D026','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D027','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D027','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D027','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D027','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D027','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D027','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D027','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D027','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D027','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D027','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D027','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D027','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D027','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D027','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D027','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D027','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D027','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D027','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D027','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D027','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D027','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D027','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D027','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D027','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D027','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D027','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D027','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D027','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D027','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D027','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D028','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D028','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D028','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D028','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D028','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D028','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D028','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D028','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D028','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D028','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D028','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D028','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D028','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D028','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D028','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D028','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D028','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D028','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D028','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D028','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D028','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D028','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D028','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D028','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D028','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D028','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D028','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D028','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D028','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D028','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D029','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D029','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D029','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D029','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D029','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D029','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D029','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D029','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D029','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D029','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D029','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D029','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D029','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D029','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D029','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D029','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D029','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D029','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D029','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D029','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D029','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D029','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D029','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D029','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D029','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D029','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D029','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D029','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D029','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D029','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D030','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D030','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D030','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D030','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D030','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D030','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D030','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D030','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D030','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D030','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D030','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D030','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D030','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D030','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D30','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D030','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D030','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D030','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D030','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D030','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D030','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D030','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D030','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D030','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D030','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D030','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D030','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D030','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D030','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D030','5h 50m','3650')

insert into tbFlight_Details values('FT102','CHE','MUB','09.00AM','02.00PM','D031','5h','2700')
insert into tbFlight_Details values('FT103','CHE','GOA','10.00AM','05.00PM','D031','7h','4000')
insert into tbFlight_Details values('FT104','CHE','HYD','08.00AM','04.30PM','D031','8h 30m','6900')
insert into tbFlight_Details values('FT105','CHE','KKT','08.00AM','05.00PM','D031','9h','5700')
insert into tbFlight_Details values('FT101','CHE','TVP','10.00AM','03.00PM','D031','5h','3300')
insert into tbFlight_Details values('FT102','MUB','CHE','11.00AM','03.00PM','D031','4h','2500')
insert into tbFlight_Details values('FT103','MUB','GOA','11.00AM','04.00PM','D031','5h','3200')
insert into tbFlight_Details values('FT104','MUB','HYD','10.30AM','04.00PM','D031','5h 30m','3900')
insert into tbFlight_Details values('FT105','MUB','KKT','10.30AM','07.00PM','D031','8h 30m','5400')
insert into tbFlight_Details values('FT101','MUB','TVP','10.00AM','06.00PM','D031','8h','3900')
insert into tbFlight_Details values('FT102','GOA','CHE','06.00AM','04.00PM','D031','10h','4400')
insert into tbFlight_Details values('FT103','GOA','MUB','09.00AM','10.00PM','D031','13h','8070')
insert into tbFlight_Details values('FT104','GOA','HYD','08.30AM','05.00PM','D031','8h 30m','5700')
insert into tbFlight_Details values('FT105','GOA','KKT','11.00AM','08.00PM','D031','9h','5400')
insert into tbFlight_Details values('FT101','GOA','TVP','09.00AM','03.00PM','D031','6h','4800')
insert into tbFlight_Details values('FT102','HYD','CHE','03.00AM','11.00AM','D031','8h','4700')
insert into tbFlight_Details values('FT103','HYD','MUB','11.00AM','06.00PM','D031','7h','3500')
insert into tbFlight_Details values('FT104','HYD','GOA','06.00AM','04.30PM','D031','11h 30m','7000')
insert into tbFlight_Details values('FT105','HYD','KKT','08.00AM','04.00PM','D031','8h','5900')
insert into tbFlight_Details values('FT101','HYD','TVP','11.00AM','07.00PM','D031','8h','3700')
insert into tbFlight_Details values('FT102','KKT','CHE','10.00AM','03.00PM','D031','5h','2900')
insert into tbFlight_Details values('FT103','KKT','MUB','11.00AM','06.00PM','D031','7h','4000')
insert into tbFlight_Details values('FT104','KKT','GOA','04.00AM','04.30PM','D031','12h 30m','7200')
insert into tbFlight_Details values('FT105','KKT','HYD','09.00AM','05.00PM','D031','8h','5750')
insert into tbFlight_Details values('FT101','KKT','TVP','09.00AM','04.00PM','D031','7h','3350')
insert into tbFlight_Details values('FT102','TVP','CHE','10.00AM','05.00PM','D031','7h','2700')
insert into tbFlight_Details values('FT103','TVP','MUB','11.00AM','04.00PM','D031','5h','3270')
insert into tbFlight_Details values('FT104','TVP','GOA','10.30AM','02.00PM','D031','3h 30m','3650')
insert into tbFlight_Details values('FT105','TVP','HYD','08.30AM','05.00PM','D031','8h 30m','5890')
insert into tbFlight_Details values('FT101','TVP','KKT','10.45AM','04.35PM','D031','5h 50m','3650')

select count(*) from tbFlight_Details

create table tbFlight_Details(FD_Id int identity(0001,1) constraint pk_fdid primary key,FT_Id varchar(6) constraint fk_ftid foreign key
references tbFlight_Type(Fl_Id),S_Id varchar(6) constraint fk_sid foreign key references tbCity(City_Id),
Des_Id varchar(6) constraint fk_did foreign key references tbCity(City_Id),Departure_Time varchar(10),Arrival_Time varchar(10),
FDate_Id varchar(6) foreign key references tbDate(D_Id),Duration varchar(10),Fare varchar(15))

create proc proc_InsertFlight(@FT_Id varchar(6),@startpt varchar(20),@destination varchar(20),@dprttym varchar(20),@arrvltym varchar(20),@date varchar(20),@duration varchar(20),@fare varchar(20))
as 
begin 
 insert into tbFlight_Details values(@FT_Id,@startpt,@destination,@dprttym,@arrvltym,@date,@duration,@fare)
 end
 exec proc_InsertFlight 'FT102','KKT','GOA','10AM','5PM','D001','7h','5000'

select * from tbFlight_Details where FD_Id = (select max(FD_Id) from tbFlight_Details)


alter proc Insert_User_data(@ufname varchar(20),@ulname varchar(20),
@pnumber varchar(20),@gmail varchar(20),@password varchar(20))
as
begin
insert into Airline_Registration(User_fname,User_lname,phone_number,gmail,password) values(@ufname,@ulname,@pnumber,@gmail,@password)
end



exec Insert_User_data 'BreezeAirlines','Airways','9876543210','admin.airbreeze@gmail.com','adminteam20'

create table Airline_Registration(User_fname varchar(20),User_lname varchar(20),D_of_b date
                ,phone_number varchar(20) ,
gmail varchar(20) ,
                password varchar(20),primary key(gmail,phone_number))

select * from Airline_Registration
drop table Airline_Registration



create proc Insert_Passenger(@Ps_Name varchar(20),@Ps_Age varchar(2),@Ps_gender varchar(20))
as
declare @book_ID int
begin
select @book_ID = (select max(Book_Id) from Booking_Details)
insert into Passengers values(@book_ID,@Ps_Name,@Ps_Age,@Ps_gender);
end

select * from Passengers
exec Insert_Passenger 'bhu','21','female'


create proc proc_InsertFlight(@FT_Id varchar(6),@startpt varchar(20),@destination varchar(20),@dprttym varchar(20),@arrvltym varchar(20),@date varchar(20),@duration varchar(20),@fare varchar(20))
as 
begin 
 insert into tbFlight_Details values(@FT_Id,@startpt,@destination,@dprttym,@arrvltym,@date,@duration,@fare)
 end
 exec proc_InsertFlight 'FT102','KKT','GOA','10AM','5PM','D001','7h','5000'

delete store procedure

alter proc proc_Delete(@fd_id int)
as
 begin
     delete from tbFlight_Details where FD_Id=@fd_id
end
select * from tbFlight_Details

exec proc_Delete '1861'

create proc proc_updateflightdetails(@fd_id int,@dep_time varchar(10),@arr_time varchar(10),@date_id varchar(6),@duration varchar(10),@fare varchar(10))
as
begin
update tbFlight_Details set Departure_Time= @dep_time, Arrival_Time= @arr_time,FDate_Id = @date_id,Duration = @duration,Fare = @fare
where FD_Id = @fd_id
end
exec proc_updateflightdetails '1','11.00AM','03.00PM','D001','4h','2900'

select * from tbFlight_Details

create proc proc_flightDetails(@fd_id int)
as
begin
select * from tbFlight_Details where FD_Id = @fd_id
end

select * from User

alter proc proc_refDetails
as
declare @Book_Id int
declare @Passenger int
declare @fare int
declare @BFD_Id int
begin
	select @Book_Id = (select max(Book_Id) from Booking_Details)
	select @Passenger = (select count(*) from Passengers where BP_Id = @Book_Id )
	select @BFD_Id = (select BFD_Id from Booking_Details where Book_Id = @Book_Id)
	select @fare = (select sum(@Passenger * fare) from tbFlight_Details where FD_Id = @BFD_Id)
	select S_Id,Des_Id,Departure_Time,Arrival_Time,@Passenger as Passenger,D_Date,@fare as Totalfare from tbFlight_Details fd
	join Booking_Details bd on fd.FD_Id = bd.BFD_Id join tbDate da on da.D_Id = fd.FDate_Id
	  where Book_Id = @Book_Id
end
exec proc_refDetails


select * from Passengers

use TeamProject
create proc proc_Delete_Passenger(@p_id int)
as
begin
delete from Passengers where Ps_Id = @p_id
end


alter proc proc_fetchPassenger(@username varchar(20))
as
declare @book_id varchar(20),@user_id int
begin
	select @user_id = (select User_Id from tbUser where gmail=@username)
	select @book_id = (select max(Book_Id) from Booking_Details where User_Id = @user_id)
	select Ps_Id,Ps_Name,Ps_Age,Ps_Gender from Passengers where BP_Id = @book_id
end

exec proc_fetchPassenger 'test@gmail.com'

select * from Booking_Details
select * from Passengers
select * from tbUser

create table Payment(Pay_Id int identity(0001,1) primary key,
Book_Id int foreign key references Booking_Details(Book_Id),Pay_Type varchar(15),
Name_On_Card varchar(20),Card_Number varchar(20) not null unique,
CExpiry_Date varchar(20),CVV int)

drop table Payment
select * from Payment


create proc proc_Insert_PaymentDetails(@pay_type varchar(15),@name_on_card varchar(20),@card_number varchar(20),@cexpiry_date varchar(20),@cvv int)
as
declare @book_id int
begin
select @book_id = (select max(Book_Id) from Booking_Details)
insert into Payment values(@book_id,@pay_type,@name_on_card,@card_number,@cexpiry_date,@cvv)
end


create table Booking_Details(Book_Id int identity(0001,1) constraint pk_bid primary key,BFD_Id int foreign key references tbFlight_Details(FD_Id),
User_Id int foreign key references tbUser(User_Id),Pnr varchar(10) not null unique, Booked_Date varchar(6) 
foreign key references tbDate(D_Id))

alter proc proc_bookingflight(@flightid int,@username varchar(20))
as
declare @date varchar(6),@userid int,@pnr varchar(10)
begin
select @pnr = (SELECT ABS(CHECKSUM(NEWID())) % 100000)
select @userid = (select User_Id from tbUser where gmail = @username)
select @date = (select FDate_Id from tbFlight_Details where FD_Id = @flightid)
insert into Booking_Details values(@flightid,@userid,@pnr,@date)
end

exec proc_bookingflight '420','d@gmail.com'
select * from Booking_Details
select * from tbUser


alter proc proc_bookingdetails(@username varchar(20))
as
begin
	select Pnr,d.D_Date,S_Id,Des_Id,FD_Id,'Booked' as Status from  Booking_Details bd 
	join tbFlight_Details fd on fd.FD_Id = bd.BFD_Id join tbDate d on d.D_Id = fd.FDate_Id join tbUser u on u.User_Id = bd.User_Id
	where Book_Id in (select Book_Id from Booking_Details where User_Id = (select User_Id from tbUser where gmail=@username))
end

exec proc_bookingdetails 'd@gmail.com'
use TeamProject

select * from tbFlight_Details

---------------------------------------------------------------------------------------------------------------------------------

create table Booking_Details(Book_Id int identity(0001,1) constraint pk_bid primary key,BFD_Id int not null foreign key references tbFlight_Details(FD_Id),
User_Id int not null foreign key references tbUser(User_Id),Pnr varchar(10) not null unique, Booked_Date varchar(6) 
foreign key references tbDate(D_Id),Status varchar(20))

create table Passengers(Ps_Id int IDENTITY(0001,1) primary key,BP_Id int not null foreign key references Booking_Details(Book_Id),
Ps_Name varchar(20),Ps_Age varchar(2),Ps_Gender varchar(20),Status varchar(20))

create table Payment(Pay_Id int identity(0001,1) primary key,
Book_Id int not null foreign key references Booking_Details(Book_Id),Pay_Type varchar(15),
Name_On_Card varchar(20),Card_Number varchar(20) not null,
CExpiry_Date varchar(20),CVV int)



alter proc proc_bookingflight(@flightid int,@username varchar(20))
as
declare @date varchar(6),@userid int,@pnr varchar(10)
begin
select @pnr = (SELECT ABS(CHECKSUM(NEWID())) % 100000)
select @userid = (select User_Id from tbUser where gmail = @username)
select @date = (select FDate_Id from tbFlight_Details where FD_Id = @flightid)
insert into Booking_Details values(@flightid,@userid,@pnr,@date,'Payment Pending')
end

alter proc proc_bookingdetails(@username varchar(20))
as
begin
select Pnr,d.D_Date,S_Id,Des_Id,FD_Id,'Booked' as Status from  Booking_Details bd 
join tbFlight_Details fd on fd.FD_Id = bd.BFD_Id join tbDate d on d.D_Id = fd.FDate_Id join tbUser u on u.User_Id = bd.User_Id
where Book_Id in (select Book_Id from Booking_Details where User_Id = (select User_Id from tbUser where gmail=@username)) and Status = 'Payment Success'
end


alter proc proc_fetchPassenger(@username varchar(20))
as
declare
@user_id int
begin
select @user_id = (select User_Id from tbUser where gmail=@username)
select Ps_Id,Ps_Name,Ps_Age,Ps_Gender from Passengers where BP_Id in (select max(BP_Id) from Passengers where BP_Id in
(select Book_Id from Booking_Details where User_Id = @user_id) and Status = 'Payment Success')
end


alter proc proc_Insert_PaymentDetails(@pay_type varchar(15),@name_on_card varchar(20),@card_number varchar(20),@cexpiry_date varchar(20),@cvv int)
as
declare @book_id int
begin
select @book_id = (select max(Book_Id) from Booking_Details)
insert into Payment values(@book_id,@pay_type,@name_on_card,@card_number,@cexpiry_date,@cvv)
update Passengers set Status = 'Payment Success' where BP_Id = @book_id
update Booking_Details set Status = 'Payment Success' where Book_Id = @book_id
end

insert into Passengers values(1,'mari','32','male','Payment Pending')

alter proc Insert_Passenger(@Ps_Name varchar(20),@Ps_Age varchar(2),@Ps_gender varchar(20))
as
declare @book_ID int
begin
select @book_ID = (select max(Book_Id) from Booking_Details)
insert into Passengers values(@book_ID,@Ps_Name,@Ps_Age,@Ps_gender,'Payment Pending')
end





---------------------------------------------updated On 2-01-2020------------------------------------------

select * from tbUser
select * from Booking_Details
select * from Passengers
drop table Booking_Details
drop table Passengers
drop table Payment



create table Booking_Details(Book_Id int identity(0001,1) constraint pk_bid primary key,BFD_Id int not null foreign key references tbFlight_Details(FD_Id),
User_Id int not null foreign key references tbUser(User_Id),Pnr varchar(10) not null unique, Booked_Date varchar(6) 
foreign key references tbDate(D_Id),Payment_Status varchar(20),Ticket_Status varchar(20),TicketBookedOn varchar(20))

create table Passengers(Ps_Id int IDENTITY(0001,1) primary key,BP_Id int not null foreign key references Booking_Details(Book_Id),
Ps_Name varchar(20),Ps_Age varchar(2),Ps_Gender varchar(20),Payment_Status varchar(20))

create table Payment(Pay_Id int identity(0001,1) primary key,
Book_Id int not null foreign key references Booking_Details(Book_Id),Pay_Type varchar(15),
Name_On_Card varchar(20),Card_Number varchar(20) not null,
CExpiry_Date varchar(20),CVV int)

exec proc_bookingflight

exec proc_bookingdetails

exec proc_fetchPassenger

insert into Passengers values(1,'mari','32','male','Payment Pending')

exec proc_Insert_PaymentDetails

SELECT CONVERT(VARCHAR(10), getdate(), 23);
select * from Booking_Details
select * from tbDate
--------------------------------------------------------------

alter proc proc_Delete_Passenger(@p_id int)
as
declare @book_id int,@count int
begin
select @book_id = (select BP_Id from Passengers where Ps_Id = @p_id)
delete from Passengers where Ps_Id = @p_id
select @count = (select count(Ps_Id) from Passengers where BP_Id = @book_id)
if @count=0
begin
update Booking_Details set Ticket_Status='Cancelled' where Book_Id = @book_id
end
end

exec proc_Delete '11'
select * from Passengers
select * from Booking_Details
insert into Passengers values(1,'Sha','24','female','Payment Pending')
------------------------------------------------------------------------------------------

alter proc proc_bookingflight(@flightid int,@username varchar(20))
as
declare @date varchar(6),@userid int,@pnr varchar(10),@ticketbookedDate varchar(20)
begin
select @pnr = (SELECT ABS(CHECKSUM(NEWID())) % 100000)
select @userid = (select User_Id from tbUser where gmail = @username)
select @date = (select FDate_Id from tbFlight_Details where FD_Id = @flightid)
select @ticketbookedDate = (SELECT CONVERT(VARCHAR(10), getdate(), 23))
insert into Booking_Details values(@flightid,@userid,@pnr,@date,'Payment Pending','Not Booked',@ticketbookedDate)
end

alter proc proc_bookingdetails(@username varchar(20))
as
begin
select Pnr,TicketBookedOn,d.D_Date,S_Id,Des_Id,FD_Id,Ticket_Status as Status from  Booking_Details bd 
join tbFlight_Details fd on fd.FD_Id = bd.BFD_Id 
join tbDate d on d.D_Id = fd.FDate_Id 
join tbUser u on u.User_Id = bd.User_Id
where u.gmail = @username and 
bd.Payment_Status = 'Payment Success' and (bd.Ticket_Status = 'Booked' or bd.Ticket_Status = 'Cancelled')
end

-------here-------
alter proc proc_fetchPassenger(@username int)
as
begin
select Ps_Id,Ps_Name,Ps_Age,Ps_Gender from Passengers where BP_Id = 2 and Payment_Status = 'Payment Success'
end
select * from Booking_Details
select * from Passengers
select * from Payment
drop table Booking_Details
drop table Passengers
drop table Payment


alter proc proc_Insert_PaymentDetails(@pay_type varchar(15),@name_on_card varchar(20),@card_number varchar(20),@cexpiry_date varchar(20),@cvv int)
as
declare @book_id int
begin
select @book_id = (select max(Book_Id) from Booking_Details)
insert into Payment values(@book_id,@pay_type,@name_on_card,@card_number,@cexpiry_date,@cvv)
update Passengers set Payment_Status = 'Payment Success' where BP_Id = @book_id
update Booking_Details set Payment_Status = 'Payment Success',Ticket_Status = 'Booked' where Book_Id = @book_id
end
--------------------------------------changes in module queries---------------------------------------
alter proc proc_fetchBookedPassengers(@pnr varchar(10))
as
begin
select Book_Id,BFD_Id,Ps_Id,Ps_Name,Ps_Age,Ps_Gender from Booking_Details bd join Passengers p on bd.Book_Id = p.BP_Id where Pnr = @pnr
end---not run---

exec proc_fetchBookedPassengers '90238'

select * from Booking_Details
select * from Passengers
select * from Payment
select * from tbUser







------------------

select Book_Id,Pnr,TicketBookedOn,d.D_Date,S_Id,Des_Id,FD_Id,Ticket_Status as Status from  Booking_Details bd 
join tbFlight_Details fd on fd.FD_Id = bd.BFD_Id 
join tbDate d on d.D_Id = fd.FDate_Id 
join tbUser u on u.User_Id = bd.User_Id
where u.gmail = 'magic@gmail.com' and 
bd.Payment_Status = 'Payment Success' and (bd.Ticket_Status = 'Booked' or bd.Ticket_Status = 'Cancelled')

-------------------
create proc proc_cancelticketdetails(@username varchar(20))
as
begin 
select Pnr,Book_Id,TicketBookedOn,d.D_Date,S_Id,Des_Id,FD_Id,Ticket_Status as Status from  Booking_Details bd 
join tbFlight_Details fd on fd.FD_Id = bd.BFD_Id 
join tbDate d on d.D_Id = fd.FDate_Id 
join tbUser u on u.User_Id = bd.User_Id
where u.gmail = @username and 
bd.Payment_Status = 'Payment Success' and bd.Ticket_Status = 'Booked' 
end

exec proc_cancelticketdetails 'magic@gmail.com'


select bd.Book_Id,bd.Pnr,bd.TicketBookedOn,d.D_Date,fd.S_Id,fd.Des_Id,fd.FD_Id,bd.Ticket_Status as Status,Count(p.Ps_Id) from  Booking_Details bd
join tbFlight_Details fd on fd.FD_Id = bd.BFD_Id join tbDate d on d.D_Id = fd.FDate_Id join tbUser u on u.User_Id = bd.User_Id 
join Passengers p  on p.BP_Id = bd.Book_Id
where u.gmail = 'magic@gmail.com' and 
bd.Payment_Status = 'Payment Success' and bd.Ticket_Status = 'Booked' group by bd.Book_Id
select count(Ps_Id) from Passengers

select * from Booking_Details
select * from Passengers





--------------------------------------
alter proc proc_cancelticketdetails(@username varchar(20))
as
begin 
select Pnr,Book_Id,TicketBookedOn,d.D_Date,S_Id,Des_Id,FD_Id,Ticket_Status as Status from  Booking_Details bd 
join tbFlight_Details fd on fd.FD_Id = bd.BFD_Id 
join tbDate d on d.D_Id = fd.FDate_Id 
join tbUser u on u.User_Id = bd.User_Id
where u.gmail = @username and 
bd.Payment_Status = 'Payment Success' and bd.Ticket_Status = 'Booked' 
end



update tbDate set D_Date = '2020-01-01' where D_Id = 'D001'
update tbDate set D_Date = '2020-01-02' where D_Id = 'D002'
update tbDate set D_Date = '2020-01-03' where D_Id = 'D003'
update tbDate set D_Date = '2020-01-04' where D_Id = 'D004'
update tbDate set D_Date = '2020-01-05' where D_Id = 'D005'
update tbDate set D_Date = '2020-01-06' where D_Id = 'D006'
update tbDate set D_Date = '2020-01-07' where D_Id = 'D007'
update tbDate set D_Date = '2020-01-08' where D_Id = 'D008'
update tbDate set D_Date = '2020-01-09' where D_Id = 'D009'
update tbDate set D_Date = '2020-01-10' where D_Id = 'D010'
update tbDate set D_Date = '2020-01-11' where D_Id = 'D011'
update tbDate set D_Date = '2020-01-12' where D_Id = 'D012'
update tbDate set D_Date = '2020-01-13' where D_Id = 'D013'
update tbDate set D_Date = '2020-01-14' where D_Id = 'D014'
update tbDate set D_Date = '2020-01-15' where D_Id = 'D015'
update tbDate set D_Date = '2020-01-16' where D_Id = 'D016'
update tbDate set D_Date = '2020-01-17' where D_Id = 'D017'
update tbDate set D_Date = '2020-01-18' where D_Id = 'D018'
update tbDate set D_Date = '2020-01-19' where D_Id = 'D019'
update tbDate set D_Date = '2020-01-20' where D_Id = 'D020'
update tbDate set D_Date = '2020-01-21' where D_Id = 'D021'
update tbDate set D_Date = '2020-01-22' where D_Id = 'D022'
update tbDate set D_Date = '2020-01-23' where D_Id = 'D023'
update tbDate set D_Date = '2020-01-24' where D_Id = 'D024'
update tbDate set D_Date = '2020-01-25' where D_Id = 'D025'
update tbDate set D_Date = '2020-01-26' where D_Id = 'D026'
update tbDate set D_Date = '2020-01-27' where D_Id = 'D027'
update tbDate set D_Date = '2020-01-28' where D_Id = 'D028'
update tbDate set D_Date = '2020-01-29' where D_Id = 'D029'
update tbDate set D_Date = '2020-01-30' where D_Id = 'D030'
update tbDate set D_Date = '2020-01-31' where D_Id = 'D031'


create proc proc_FetchFlightIDs(@date varchar(20),@source varchar(20),@destination varchar(20))
as
begin
select FD_Id from tbFlight_Details fd join tbCity c on c.City_Id = fd.S_Id join tbDate d 
on d.D_Id = fd.FDate_Id join tbFlight_Type ft on ft.Fl_Id = fd.FT_Id where S_Id =(select City_Id from tbCity where City_Name =@source) and 
Des_Id = (select City_Id from tbCity where City_Name = @destination) and FDate_Id = (select D_Id from tbDate where D_Date= @date)
end