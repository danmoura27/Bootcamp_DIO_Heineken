-- inserção de dados e queries para o cenário Oficina
use workshop;

-- tabela cliente
insert into client(Fname, Minit, Lname, CPF, address) values
				('Daniel','M','Goncalves','12345678901','Rua Gonçalves, 123, Curitiba/PR'),
                ('Rafael','S','Pereira','23456789012','Rua Pereira, 234, São Paulo/SP'),
                ('Israel','A','Santos','34567890123','Rua Santos, 345, Belo Horizonte/MG'),
                ('Raquel','B','Silva','45678901234','Rua Silva, 456, Salvador/BA'),
                ('Isabel','C','Santana','56789012345','Rua Santana, 567, Curitiba/PR'),
                ('Gabriel','D','Xavier','67890123456','Rua Xavier, 678, Araucaria/PR'),
                ('Emanoel','E','Moura','78901234567','Rua Moura, 890, São Paulo/SP');
select * from client;

-- tabela mecanico
insert into mechanic(registration, Fname, Minit, Lname, CPF, address, specialty) values
					('12345','João','C','Silva','09876543210','Rua Silva, 987, Curitiba/PR','Suspensão'),
                    ('12346','Maria','D','Faria','09876543211','Rua Faria, 765, Curitiba/PR','Motor'),
                    ('12347','José','E','Lima','09876543212','Rua Lima, 4567, Araucaria/PR','Injeção');
select * from mechanic;

-- tabela mão de obra
insert into workforce(serviceType,serviceDescription,serviceValue,estimated_time,review_repair) values
					('Troca Pneus','Trocar os 4 pneus',2000,'02:30','Conserto'),
                    ('Troca Óleo','Trocar filtro de óleo do motor',200,'01:00','Revisão'),
                    ('Limpeza de bicos','Limpar bicos injetores',230,'04:00','Conserto'),
                    ('Troca amortecedor','Substituir amortecedores dianteiros',900,'15:00','Conserto'),
                    ('Revisão freios','Trocar pastilhas de freio',500,'02:00','Revisão');
select * from workforce;

-- tabela peças
insert into parts(partType,partDescription,partValue) values
				('Pneu','Pneu aro 15',500),
                ('Óleo','Óleo 15W40',50),
                ('Amortecedor','Amortecedor dianteiro veículo Jeep',450),
                ('Pastilha Freio','Pastilha de freio Jeep dianteiro',250);
select * from parts;

-- tabela Veículo
insert into vehicle(idVehicleClient, makeVehicle, modelVehicle, plateVehicle, chassisNumber, yearVehicle, kmVehicle) values
				(1,'Chevrolet','Cruze','ABC1234','123456789',2015,120000),
                (2,'Hyundai','HB20','BCD2345',null,2020,null),
                (3,'Chevrolet','Onix','CDE3456','234567891',2023,25000),
                (4,'Nissan','March','DEF4567',null,2020,40000),
                (5,'Nissan','Kicks','EFG5678','3456789012',2018,110000),
                (6,'Volkswagen','T-Cross','FGH6789',null,2024,15000),
                (7,'Fiat','Argo','GHI7890',null,2015,140000),
                (1,'Nissan','March','ABC7654','456789456',2020,90000),
                (6,'Volkswagen','Nivus','FGH0987','00987356789',2025,1000);
select * from vehicle;

-- tabela Ordem de Serviço
insert into orders(idOrdersVehicle, dateIssue, ordersValue, ordersStatus, ordersConclusion) values
				(1,'2024-08-15',1000,'Finalizada','2024-08-16'),
                (2,'2024-11-10',500,'Finalizada','2024-11-11'),
                (3,'2024-12-20',1500,'Em processamento',null),
                (4,'2025-01-23',200,'Cancelada','2025-01-25'),
                (5,'2025-01-28',300,'Finalizada','2025-02-01'),
                (6,'2025-02-07',2000,'Em processamento',null),
                (7,'2025-02-19',100,'Cancelada','2025-02-23'),
                (8,'2025-03-05',50,'Em processamento',null),
                (9,'2025-04-03',1200,'Em processamento',null);
select * from orders;

-- tabela Serviço
insert into service(idServiceMechanic, idServiceWorkforce, idServiceParts,idServiceOrders,authorization) values
				(1,1,1,9,'Em processamento'),
                (1,4,3,8,'Autorizado'),
                (2,2,2,7,'Em processamento'),
                (3,3,null,6,'Autorizado'),
                (3,3,null,5,'Não autorizado'),
                (2,2,2,4,'Autorizado'),
                (1,5,4,3,'Autorizado'),
                (3,3,null,2,'Autorizado'),
                (2,2,2,1,'Autorizado');
select * from service;

-- QUERIES

-- contar quantidade de clientes e quantos carros possuem
select concat(Fname,' ',Lname) as Client, count(idVehicle) as Vehicles 
	from client c
    join vehicle v ON c.idClient = v.idVehicleClient
    group by c.idClient, Fname, Lname
    order by Fname;
    
-- contar total de serviços analisados por mecânico
SELECT concat(m.Fname,' ',m.Lname) as Mechanics, count(o.idOrders) as Total_Services, o.ordersStatus
	FROM mechanic m
    JOIN service s ON m.idMechanic = s.idServiceMechanic
    JOIN orders o ON s.idServiceOrders = o.idOrders
    GROUP BY m.idMechanic, m.Fname, o.ordersStatus;
    
-- somar valor total de serviços autorizados
SELECT concat(m.Fname,' ',Lname) as Mechanics, sum(w.serviceValue) as Valor_Serviço, sum(p.partValue) as Valor_peça
	FROM mechanic m
    JOIN service s ON m.idMechanic = s.idServiceMechanic
    JOIN workforce w ON w.idWorkforce = s.idServiceWorkforce
    JOIN parts p ON p.idParts = s.idServiceParts
    GROUP BY m.idMechanic, m.Fname, m.Lname;
    




