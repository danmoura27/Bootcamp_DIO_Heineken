-- criação do banco de dados para o cenário Oficina
create database if not exists workshop;
use workshop;

-- criar tabela cliente
create table client(
	idClient int auto_increment primary key,
    Fname varchar(15) not null,
    Minit varchar(3),
    Lname varchar(20) not null,
    CPF char(11) not null,
    address varchar(255),
    constraint unique_cpf_cliente unique (CPF)
);
desc client;

-- criar tabela mecanico
create table mechanic(
	idMechanic int auto_increment primary key,
    registration int not null,
    Fname varchar(15) not null,
    Minit varchar(3),
    Lname varchar(255) not null,
    CPF char(11) not null,
    address varchar(255) not null,
    specialty varchar(45),
    constraint unique_matricula_mecanico unique (registration),
    constraint unique_cpf_mecanico unique (CPF)
);
desc mechanic;

-- criar tabela mão de obra
create table workforce(
	idWorkforce int auto_increment primary key,
    serviceType varchar(45) not null,
    serviceDescription varchar(255),
    serviceValue float,
    estimated_time time,
    review_repair enum('Revisão','Conserto') not null,
    constraint unique_type_workforce unique (serviceType)
);
desc workforce;

-- criar tabela peças
create table parts(
	idParts int auto_increment primary key,
    partType varchar(45) not null,
    partDescription varchar(100),
    partValue float
);
desc parts;

-- criar tabela Veículo
create table vehicle(
	idVehicle int auto_increment primary key,
    idVehicleClient int,
    makeVehicle varchar(30) not null,
    modelVehicle varchar(30) not null,
    plateVehicle char(7) not null,
    chassisNumber varchar(15),
    yearVehicle year,
    kmVehicle int,
    constraint fk_vehicle_client foreign key(idVehicleClient) references client(idClient)
);
desc vehicle;

-- criar tabela Ordem de Serviço
create table orders(
	idOrders int auto_increment primary key,
    idOrdersVehicle int,
    dateIssue date not null,
    ordersValue float,
    ordersStatus enum('Finalizada', 'Cancelada', 'Em processamento') default 'Em processamento',
    ordersConclusion date
);
desc orders;

-- criar tabela Serviço
-- drop table service;
create table service(
	idService int auto_increment primary key,
    idServiceMechanic int,
    idServiceWorkforce int,
    idServiceParts int,
    idServiceOrders int,
    authorization enum('Em processamento', 'Autorizado', 'Não autorizado') default 'Em processamento',
    constraint fk_service_mechanic foreign key(idServiceMechanic) references mechanic(idMechanic),
    constraint fk_service_workforce foreign key(idServiceWorkforce) references workforce(idWorkforce),
    constraint fk_service_parts foreign key(idServiceParts) references parts(idParts),
    constraint fk_service_orders foreign key(idServiceOrders) references orders(idOrders)
);
desc service;





