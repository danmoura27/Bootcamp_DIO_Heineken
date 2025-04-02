-- inserção de dados e queries
use ecommerce;

show tables;

-- Tabela Client
desc clients;
-- idCliente, Fname, Minit, Lname, CPF, Address
insert into clients (Fname, Minit, Lname, CPF, Address)
		values('Maria','M','Silva','12345678901','Rua das Silva, 12, Fazendinha - Curitiba/PR'),
              ('Jose','N','Gomes','23456789012','Rua do Gomes, 23, CIC - Curitiba/PR'),
              ('João','O','Chavier','34567890123','Rua do Chavier, 34, Pinheirinho - Curitiba/PR'),
              ('Francisco','P','Pereira','45678901234','Rua do Pereira, 45, Capão Raso - Curitiba/PR'),
              ('Daniel','M','Gonçalces','56789012345','Rua do Gonçalves, 56, Centro - Curitiba/PR'),
              ('Marcos','S','Sena','67890123456','Rua do Sena, 67, Portão - Curitiba/PR');
              
select * from clients;

-- Tabela Produtos
desc product;
-- idProduct, Pname, classification_kids, category(Eletrônico,Vestimenta,Brinquedo,Alimentos), avaliação, size
insert into product(Pname, classification_kids, category, avaliação, size) values
				('Fone de ouvido',false,'Eletrônico','4',null),
                ('Barbie Elsa',true,'Brinquedo','3',null),
                ('Camiseta',true,'Vestimenta','5',null),
                ('Carne',false,'Alimentos','2',null);
select * from product;
                
-- Tabela Pagamentos
desc payments;
-- idClient, idPayment, typePayment, limitAvailable
insert into payments (idClient, typePayment, limitAvailable)
			values('1','Boleto',1000),
				('2','Dois cartões',2000),
				('3','Cartão',3000),
				('4','Cartão',4000),
				('5','Dois cartões',4000),
				('6','Boleto',4000);
select * from payments;

-- Tabela Orders
desc orders;
-- idOrder, idOrderClient, idOrderPayment, orderStatus(Cancelado, Confirmado, Em processamento), orderDescription, sendValue, paymentCash
insert into orders(idOrderClient, idOrderPayment, orderStatus, orderDescription, sendValue, paymentCash) values
				(1, 1, 'Cancelado','Cancelou pedido',100,0),
                (1, 1, 'Confirmado','Compra via website',150,0),
                (2, 2, 'Em processamento','Retirada no local',100,10),
                (3, 3, 'Confirmado','Compra parcelada',200,50);


-- Tabela productOrder
desc productOrder;
-- idPOproduct,idPOorder, poQuantity, poStatus (Disponível, Sem estoque)
insert into productOrder(idPOproduct,idPOorder, poQuantity, poStatus) values
			(1,5,2,'Disponível'),
            (2,5,1,'Disponível'),
            (3,6,1,'Sem estoque');
select * from productOrder;

-- Tabela productStorage
desc productStorage;
-- idProductStorage, storageLocation,quantity
insert into productStorage (storageLocation,quantity) values
			('Curitiba',1000),
            ('São Paulo',500),
            ('Manaus',10),
            ('Belo Horizonte',100);
select * from productStorage;

-- Tabela storageLocation
desc storageLocation;
-- iLproduct,idLstorage,location
insert into storageLocation (idLproduct,idLstorage,location) values
			(1,2,'SP'),
            (2,1,'PR');
select * from storageLocation;


-- Tabela Seller
desc Seller;
-- idSeller, SocialName, AbstName,CNPJ,CPF, location,contact
insert into Seller (SocialName, AbstName,CNPJ,CPF,location,contact) values
				('Tech Eletrônicos',null,098765432109876,null,'Curitiba',43215678),
                ('Botique Durgas',null,null,09867898712,'São Paulo',21567843),
                ('Kids World',null,765432109876098,null,'Belo Horizonte',43678215);
select * from Seller;


-- Tabela productSeller
desc productSeller;
-- idPseller,idPproduct,prodQuantity
insert into productSeller (idPseller,idPproduct,prodQuantity) values
			(1,4,80),
            (2,2,10);
select * from productSeller;


-- Tabela Supplier
desc Supplier;
-- idSupplier,SocialName,CNPJ,contact
insert into Supplier(SocialName,CNPJ,contact) values
			('Almeida e filhos',123456789012345,'12345678'),
            ('Eletrônicos Silva',234567890123456,'23456789'),
            ('Eletrônicos Valma',345678901234567,'34567890');
select * from Supplier;


-- Tabela productSupplier
desc productSupplier;
-- idPsSupplier,idPsProduct,quantity
insert into productSupplier(idPsSupplier,idPsProduct,quantity) values
			(1,1,500),
            (1,2,400),
            (2,4,633),
            (3,3,5),
            (2,2,10);
select * from productSupplier;

-- QUERIES

select * from clients c, orders o where c.idClient = idOrderClient;

select concat(Fname,' ',Lname) as Client, idOrder as Request, orderStatus as Status from clients c, orders o where c.idClient = idOrderClient;

select * from clients c inner join orders o ON c.idClient = o.idOrderClient
					inner join productOrder p on p.idPOorder = o.idOrder
                    order by sendValue desc;


