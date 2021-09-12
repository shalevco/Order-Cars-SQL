create database orderCars;
use orderCars;
create table ClientTbl(ClientName char(15),
                       ClientLastName char(15),
                       PhoneNumber int,
                       ClientAddress char(30),
                       ClientId int);
alter table ClientTbl add index IndexClientId(ClientId);

create table OrdersTbl(ClientId int,
                       OrderId int,
                       OrderDate date,
                       OrderStatus char(30));
alter table OrdersTbl add index IndexOrderId(OrderId);

create table ItemsInOrdersTbl(CarId int,
                              AmountItems int,
                              Remarks char(40),
                              OrderId int);
                              
create table CarCatalogTbl(CarId int,
						   CarPrice int,
                           CarInventory int);
                           
create table TypeOfCarSelectedTbl(Model char(15),
                                  SubModel char(15),
                                  EngineCapacity int,
                                  SelfWeightInKilograms double,
                                  Width double,
                                  Length double,
                                  Height double,
                                  TrunkVolumeInLiters int,
                                  FuelTankVolumeInLiters int,
                                  Price int,
                                  HorsePower int,
                                  Rpm double,
                                  AccelerationFrom0To100 double,
                                  AverageMileagePerLiter double,
                                  DegreeOfPollution double,
                                  CarId int);  
alter table TypeOfCarSelectedTbl add index IndexCarId(CarId);
 
 /*First row*/
insert into orderCars.ClientTbl values('shalev','cohanim',054234567,'netanya',1);
insert into orderCars.OrdersTbl values(1,1,'2023-07-14','ok');
insert into orderCars.ItemsInOrdersTbl values(1,1,'Prefers red color',1); 
insert into orderCars.CarCatalogTbl values(1,180000,30);
insert into orderCars.TypeOfCarSelectedTbl values('Volkswagen','Polo Gti',1984,
1328,175.1,406.7,143.8,305,40,180000,200,4400,6.7,16.9,13,1);

/*Second row*/
insert into orderCars.ClientTbl values('osher','cohanim',054765432,'netanya',2);
insert into orderCars.OrdersTbl values(2,2,'2023-08-27','ok');
insert into orderCars.ItemsInOrdersTbl values(2,2,'Prefers black color',2);
insert into orderCars.CarCatalogTbl values(2,166000,25);
insert into orderCars.TypeOfCarSelectedTbl values('Seat','Leon fr',1984,
1457,179.9,436.8,145.6,380,50,166000,190,4200,7.4,14.7,9,2);

select * from ClientTbl;

select * from OrdersTbl;

select * from ItemsInOrdersTbl;

select * from CarCatalogTbl;

select * from TypeOfCarSelectedTbl;

/*Average trunk volume*/
select avg (TypeOfCarSelectedTbl.TrunkVolumeInLiters)
as AvgBagaz
from CarCatalogTbl
inner join TypeOfCarSelectedTbl
on CarCatalogTbl.CarId = TypeOfCarSelectedTbl.CarId; 

/*Cheapest Car*/
select Model,SubModel,price 
from TypeOfCarSelectedTbl 
where Price=(select min(Price) from TypeOfCarSelectedTbl);

/*Fastest 0-100 car*/
select Model,SubModel,AccelerationFrom0To100 
from TypeOfCarSelectedTbl 
where AccelerationFrom0To100=(select min(AccelerationFrom0To100) 
from TypeOfCarSelectedTbl);

/*Car with max engine capacity*/
select Model,SubModel,EngineCapacity 
from TypeOfCarSelectedTbl 
where EngineCapacity=(select max(EngineCapacity) 
from TypeOfCarSelectedTbl);

/*The lightest car*/
select Model,SubModel,SelfWeightInKilograms 
from TypeOfCarSelectedTbl 
where SelfWeightInKilograms=(select min(SelfWeightInKilograms) 
from TypeOfCarSelectedTbl);

/*Car with max horse power*/
select Model,SubModel,HorsePower 
from TypeOfCarSelectedTbl 
where HorsePower=(select max(HorsePower) 
from TypeOfCarSelectedTbl);

/*A car that can travel the most miles in one fuel tank*/
select Model,SubModel,max(TypeOfCarSelectedTbl.AverageMileagePerLiter*TypeOfCarSelectedTbl.FuelTankVolumeInLiters)
as MaxDistance
from CarCatalogTbl
inner join TypeOfCarSelectedTbl
on CarCatalogTbl.CarId = TypeOfCarSelectedTbl.CarId;
                     