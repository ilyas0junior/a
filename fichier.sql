--tp 2 

--1. Création de la base de données gesCom2024
create database gesCom2024;

--2. Ouverture de la base de données
use gesCom2024;

--3. Création de la table client
create table client
(
idclient int identity(1,1),
nom varchar(50) not null,
prenom varchar(40),
tel varchar(20),
email varchar(30)
);

--4. Modification de la table client pour ajouter le champ adresse

alter table client add adresse varchar(100) not null;
--5. Modification de la table client pour modifier le champ adresse
alter table client alter column adresse varchar(150) not null;

--6. Modification de la table client pour supprimer le champ adresse
alter table client drop column adresse;

--7. Suppression de la table client
drop table client;

--8. Création de la table client avec une clé primaire : méthode 1 clé sur le champ
create table client
(
idclient int identity(1,1) primary key,
nom varchar(50) not null,
prenom varchar(40),
tel varchar(20),
email varchar(30)
);

--9. Suppression de la table client
drop table client;

--10. Création de la table client avec une clé primaire : méthode 2 clé sur une contrainte interne
create table client
(
idclient int identity(1,1),
nom varchar(50) not null,
prenom varchar(40),
tel varchar(20),
email varchar(30),
constraint pkClient primary key (idclient)
);

--11. Suppression de la table client
drop table client;

--12. Création de la table client avec une clé primaire : méthode 3 clé sur une contrainte externe
create table client
(
idclient int identity(1,1),
nom varchar(50) not null,
prenom varchar(40),
tel varchar(20),
email varchar(30));
alter table client
add constraint pkClient primary key (idclient);

--13. Suppression de la contrainte ajoutée
alter table client drop constraint pkclient;

--14. Créez la table produit avec une clé primaire sur le champ ref
--ref varchar(50) 
--designation varchar(150) not null
--prix money --
--Clé primaire sur un champ
--Clé primaire sur une contrainte interne
--Clé primaire sur une contrainte externe

create table commande
(
idCommande int identity(1,1),
idClient int foreign key references client(idclient),
dateCommande date,
constraint pkCommande primary key (idcommande)
)
--Clé étrangère sur un champ

--21. Suppression de la table commande
drop table commande
--22. Création de la table commande avec une clé étrangère : méthode 2 contrainte interne
create table commande
(
idCommande int identity(1,1),
idClient int ,
dateCommande date,
constraint pkCommande primary key (idcommande),
constraint fkCommandeClient foreign key (idClient) references client(idclient)
)
--23. Suppression de la table commande
drop table commande
--24. Création de la table commande avec une clé étrangère : méthode 3 contrainte externe
create table commande
(
idCommande int identity(1,1),
idClient int ,
dateCommande date,
constraint pkCommande primary key (idcommande)
) ;
alter table commande
add constraint fkCommandeClient foreign key (idClient) references client(idclient)



--////////////////////////////////////////////////////////////////////////////////////////////////

--           *****************    TP3    *************************
--         ************** BASE DE DONNEES RELATIONNELLES ***************

--Exercice 2 : 

/*
•	ATELIER_CUISINE (NumCuisine, TelCuisine, #NumCuisinier, #Responsable)
•	CATEGORIE (NumCat, LibCat)
•	CLIENTS (CodeCli, NomCli, PrénomCli, RueCli, CPCli, VilleCli)
•	COMMANDE (NumCom, DateCom, DateLivraison, CodeCli#)
•	COMPOSE (#NumMenu, #NumPlat)
•	CUISINIER (NumCuisinier, NomCuis, DateNaiss, DateEmb, #NumCuisine)
•	LIGNECOMMANDE (#NumCom#, #NumMenu, QtéCom)
•	MENU (NumMenu, PrixMenu)
•	PLAT (NumPlat, NomPlat, #NumCat)
•	PREPARER (#NumCuisine, #NumPlat, DatePréparation, NombrePlats)

*/

create  database  GestionCuisine2024
go

use GestionCuisine2024
go


--Table : CLIENTS (CodeCli, NomCli, PrenomCli, RueCli, CPCli, VilleCli)
create table CLIENTS (
CodeCli int  primary key, 
NomCli varchar(30) , 
PrenomCli varchar(30) , 
RueCli varchar(100) , 
CPCli varchar(5) , 
VilleCli varchar(50) 
)
go

-- Table : COMMANDE (NumCom, DateCom, DateLivraison, CodeCli#)
create table COMMANDE (
NumCom int  primary key, 
DateCom date, 
DateLivraison date, 
CodeCli int foreign key references CLIENTS(CodeCli)
)
  go

--Table : MENU (NumMenu, PrixMenu)
create table MENU (
NumMenu int  primary key,
PrixMenu money
)

go

-- Table : LIGNECOMMANDE (NumCom#, NumMenu#, QteCom)
create table LIGNECOMMANDE (
NumCom int foreign key references COMMANDE(NumCom), 
NumMenu int foreign key references MENU(NumMenu), 
QteCom int,
primary key (NumCom,NumMenu)
)
go

-- Table : CATEGORIE (NumCat, LibCat)
create table CATEGORIE (
NumCat int  primary key, 
LibCat varchar(100)
)
go

--  Table : PLAT (NumPlat, NomPlat, NumCat#)
create table PLAT (
NumPlat int  primary key, 
NomPlat varchar(50), 
NumCat int foreign key references CATEGORIE(NumCat)
)
go


-- table : COMPOSE (NumMenu#, NumPlat#)
create table COMPOSE (
NumMenu int foreign key references MENU(NumMenu),
NumPlat int foreign key references PLAT(NumPlat)
primary key (NumMenu,NumPlat)
)
go


-- table : CUISINIER (NumCuisinier, NomCuis, DateEmb, NumCuisine#)
create table CUISINIER (
NumCuisinier int  primary key, 
NomCuis varchar(30), 
DateNaiss date ,
DateEmb date ,
--NumCuisine int foreign key references ATELIER_CUISINE(NumCuisine),
)
-- Pour ajouter la clé etrangere
go


 -- table : ATELIER_CUISINE (NumCuisine, TelCuisine, NumCuisinier#, Responsable#)
create table ATELIER_CUISINE (
NumCuisine int  primary key, 
TelCuisine varchar(14), 
NumCuisinier int foreign key references CUISINIER(NumCuisinier),
Responsable int foreign key references CUISINIER(NumCuisinier),
)

go


 alter table CUISINIER
 add NumCuisine int foreign key references ATELIER_CUISINE(NumCuisine)

 go

-- table : PREPARER (NumCuisine#, NumPlat#, DatePr�paration, NombrePlats)
create table PREPARER (
NumCuisine int foreign key references ATELIER_CUISINE(NumCuisine),
NumPlat  int foreign key references PLAT(NumPlat),
DatePreparation date ,
NombrePlats int ,
primary key (NumCuisine,NumPlat,DatePreparation)
)




-- Insertion CLIENTS--------------------------------------------------------------------
insert into CLIENTS values 
(1 ,'ALAMI', 'Aymane', '4 Rue des Papillons', '20090', 'Casablanca'),
(2 ,'DOUKALI' ,'Jamal', '15 Place de la Liberté' ,'20090' ,'Casablanca'),
(3 ,'HMOURI', 'Rachid' ,'23 Abdelmoumen' ,'20090' ,'Casablanca'),
(4 ,'TABET' ,'Mohamed', '38 Rue des Tulipes', '20090' ,'Casablanca'),
(5 ,'NOURI' ,'Mohamed', '41 Sidi Maarouf' ,'20090', 'Casablanca'),
(6 ,'MORCHID' ,'Yassine' ,'9 Agdal' ,'30000' ,'Rabat'),
(7 ,'RIHANI' ,'Fayçal' ,'18 Abdelmoumen' ,'20090' ,'Casablanca')

--select * from CLIENTS

-- Insertion COMMANDE-----------------------------------------------------------------


insert into COMMANDE values 
(1 ,'2009-10-10' ,'2009-10-15', 1),
(2 ,'2009-10-18' ,'2009-10-20', 5),
(3 ,'2009-10-15' ,'2009-10-16', 4),
(4 ,'2009-10-09' ,'2009-10-15', 2),
(5 ,'2009-10-06' ,'2009-10-16', 6),
(6 ,'2009-10-12' ,'2009-10-15', 7)

--select * from COMMANDE

-- Insertion MENU -----------------------------------------------------

insert into MENU values 
(1, 15),(2 ,18),(3 ,25),(4 ,19),
(5 ,24),(6, 28),(7, 36),(8, 29),
(9 ,27),(10 ,12),(11 ,15),(12, 9),
(13 ,40),(14 ,25),(15 ,18)

--select * from MENU

-- Insertion LIGNECOMMANDE -----------------------------------------------------

insert into LIGNECOMMANDE values
(1 ,1, 2),(1, 2, 1),(2 ,2 ,7),(2 ,6 ,4),
(3, 6 ,18),(3 ,7 ,12),(3 ,9 ,10),(4 ,1 ,5),
(4 ,6 ,3),(4 ,8 ,4),(5 ,3 ,10),(5 ,4 ,12),
(6 ,1, 8),(6 ,10, 5),(6 ,2 ,3)

--select * from LIGNECOMMANDE

-- Insertion CATEGORIE -----------------------------------------------------
insert into CATEGORIE values
(1, 'soupes'),(2, 'salades'),
(3, 'entrées'),(4, 'légumineuses'),
(5 ,'légumes'),(6 ,'céréales'),
(7 ,'pâtés; soufflés; gratins; beignets'),
(8, 'plats de résistance'),(9 ,'pâtisserie'),
(10 ,'desserts et entremets'),(11 ,'fruits')

--select * from CATEGORIE


-- Insertion PLAT -----------------------------------------------------

insert into PLAT values
(1 ,'artichauts ailloli' ,3), (2 ,'avocat vinaigrette' ,3),
(3 ,'beignets d''aubergines', 7),(4 ,'biscuits au chocolat' ,9),
(5 ,'compote d''abricots' ,11),(6 ,'coulis de figues à la mangue' ,10),
(7 ,'courgettes panées' ,8),(8 ,'crème à l''orange' ,9),
(9 ,'fraises en salade' ,11),(10 ,'galettes d''avoine' ,8),
(11 ,'salade de chou et de raisin' ,2)

--select * from PLAT

-- Insertion COMPOSE -----------------------------------------------------

insert into COMPOSE values
(1,11),(1,5),(2 ,10),(3 ,11),
(3 ,1),(4 ,5),(5 ,4),(5 ,6),
(6, 1),(7 ,7),(7 ,10),(8, 1),
(9 ,2),(9 ,9),(10 ,6)

--select * from COMPOSE


--**************************************************************************************************************
--Partie I : Ajouter les contraintes suivantes :

--**************************************************************************************************************

--1. Le prix de menu doit être supérieur à zéro.
alter table MENU 
add constraint ck_prix check (PrixMenu>0)

--2. La date de commande doit être inférieure à la date de livraison
alter table COMMANDE 
add constraint ck_date check (DateCom<=DateLivraison)

--3. La date de commande doit être différente à la date de livraison
alter table COMMANDE 
add constraint ck_date2 check (DateCom <> DateLivraison) -- ou bien "not like"


--4. Les cuisiniers doivent avoir un âge qui dépasse 18 ans.
alter table CUISINIER
add constraint ck_date18 check(datediff(year,DateNaiss,getdate())>=18)

-- exemple de la conftion datediff():
--SELECT DATEDIFF(day, '2024-02-15', '2024-02-20') AS DiffJours;
--SELECT DATEDIFF(month, '2023-01-01', '2024-01-01') AS DiffMois;
--SELECT DATEDIFF(year, '2000-01-01', '2024-01-01') AS DiffAnnees;

--5.	Le téléphone des cuisiniers doit respecter la syntaxe suivante : +2126 _ _ _ _ _ _ _ _
alter table ATELIER_CUISINE
add constraint ck_tel CHECK (TelCuisine LIKE '+2126[0-9]%'  AND LEN(TelCuisine) = 13)


--6. Le nom du plat contient au moins 10 caractères.
alter table PLAT
add constraint ck_plat check (len(NomPlat)>=10)

--7. Le numéro de menu est compris entre 1 et 15.
alter table MENU 
add constraint ck_num_menu check ( NumMenu between 1 and 15)


--**************************************************************************************************************
--Partie II : Requêtes d'insertion
--**************************************************************************************************************

-- Insertion COMMANDE-----------------------------------------------------------------
-- Quel est le problème avec ces lignes?
insert into COMMANDE values (7 ,'2009-10-16' ,'2009-10-15', 1) -- La date de commande doit être inférieure à la date de livraison
insert into COMMANDE values (7 ,'2009-10-1' ,'2009-10-15', 10) -- aucun client avec le code 10

select * from COMMANDE
select * from CLIENTS


-- Quel est le problème avec cette ligne?
insert into MENU values (16, -4) -- problème de prix

--select * from COMPOSE

-- Insertion ATELIER_CUISINE -----------------------------------------------------

insert into ATELIER_CUISINE (NumCuisine, TelCuisine) values 
(1, '+212661659814'),(2 ,'+212662659814'), (3, '+212664529698')


-- Insertion CUISINIER -----------------------------------------------------
-- Quel est le problème avec cette ligne?

insert into CUISINIER values (1, 'DAOUD' ,'2009-10-15','2024-10-15', 2) -- contrainte de l'age qui être >=18

--5.	Ajouter un nouveau cuisinier qui a été embauché aujourd’hui : CHIHABI, il travaille dans la cuisine n°1 
--(utilisez la fonction  getdate() pour renvoyer la date aujourd’hui)

insert into CUISINIER values (8,'CHIHABI','2000-1-1', getdate(),1)
select * from CUISINIER

--6.	Ajouter trois nouveaux plats : n° 12, mousse au chocolat, n° 13 île flottante, n° 14 salade de fruits,
--n° 15 salade exotique. Ces plats sont classés dans la catégorie n°10.

insert into PLAT  values (12,'mousse au chocolat',10),
						 (13,'île flottante',10), 
						 (14, 'salade de fruits',10),
						 (15,'salade exotique',10)
select * from PLAT

---- Update ATELIER_CUISINE -----------------------------------------------------
--update ATELIER_CUISINE set NumCuisinier=2, Responsable=1 where NumCuisine=1
--UPDATE  ATELIER_CUISINE set NumCuisinier=5, Responsable=3 where NumCuisine=2
--UPDATE  ATELIER_CUISINE set NumCuisinier=6, Responsable=5 where NumCuisine=3

--select * from ATELIER_CUISINE



--**************************************************************************************************************
--Partie III : Requêtes de mise à jour
--**************************************************************************************************************

--1.	Le plat n° 8 a changé de catégorie : il est maintenant en catégorie 10.
update PLAT set NumCat=10 where NumPlat=8

--2.	Changez le prix de menu n° 1 qui coûte maintenant 13.
 select * from MENU
 update menu set PrixMenu=13 where NumMenu=1

 -- 3.	le client n°6 a déménagé : il habite maintenant 56, bld de la Liberté – 20090 Casablanca.
  select * from CLIENTS
  update CLIENTS set RueCli='56, bld de la Liberté',CPCli='20090',VilleCli='Casablanca' where CodeCli=6

  -- 4.	Le plat n°1 n’existe plus. Modifiez les tables en conséquence.

   delete from COMPOSE where NumPlat=1 

   delete from PLAT where NumPlat=1


  -- 5.	Les prix ont augmenté de 3%. Effectuez cette modification.
   select * from MENU
   update MENU set PrixMenu=PrixMenu*1.03

 -- 6.	Supprimez cette augmentation
    update MENU set PrixMenu=PrixMenu/1.03


--/////////////////////////////////////////////////////////////////////////////////////////////////

Create database tp5ex1;
go
use tp5ex1
go

--************************* table Employee*************************************************
  create table Employee
(
            EmployeeId    int Primary key identity(1,1),
            FirstName      varchar(50),
            LastName       varchar(50),
            Salary             decimal(18,2),
            JoiningDate    date,
            Department   varchar(50)
)

go
--*************************Insert value in Employee Table*************************************************

 Insert Into Employee values 
 ('Vikas', 'Verma', 40000, '2016-05-21', 'IT'),
  ('Anil', 'Kumar', 800000, '2015-10-31', 'Insurance'),
 ('Vishal', 'Sonkar', 700000, '2015-12-09', 'Banking'),
  ('Abhishek', 'Singh', 44000, '2015-02-19', 'Insurance'),
  ('Durgesh', 'Tiwari', 33000, '2015-12-07', 'Insurance'),
  ('Ravi', 'Kumar', 55000, '2016-03-31', 'Services'),
  ('Lalit', 'Raghuvanshi', 88000, '2016-09-26', 'Services'),
  ('Sandeep', 'Kumar', 70000, '2015-02-01', 'Insurance');

  --*********************** Solution des Requ�tes  ******************************************************************
  -- Les fonctions scalaires
  select * from Employee
  -- 1.	Ecrire une fonction nomm�e "Countemp1" qui compte le nombre d'employ�s.
   go;
   create function Countemp1 ()
	   returns int 
	   as
	   begin
	   declare @count  int
	   set @count = (select count(*) as empnumber from Employee)
	   return @count 
	   end

   go;
	-- Appel de la fonction
	  print dbo.Countemp1();

  go;

 -- 2 Ecrire une fonction nomm�e "Countemp11" qui compte le nombre d'employ�s et qui affiche un message 
	   create function Countemp11 ()
	   returns varchar(50) 
	   as
	   begin
	   declare @count  int
	   set @count = (select count(*) as empnumber from Employee)
	   return 'Le nombre des employ�s  est: '+ cast(@count as varchar)
	   end
  go;
	   -- Appel de la fonction
	  print dbo.Countemp11();

  go;

-- 3. Ecrire une fonction nomm�e "Countemp2" qui compte le nombre d'employ�s d'un d�partement donn� 
	create function Countemp2 (@dep varchar(50))
	   returns int
	   as
	   begin
	   declare @count  int
	   set @count = (select count(*) as empnumber from Employee where Department=@dep)
	   return @count
	   end
 go;
	   -- Appel de la fonction
	  print dbo.Countemp2('services');

go;

--4.	Ecrire une fonction qui renvoie le message 'Salaire faible' si le salaire entr� par l�utilisateur 
--est inf�rieur � 50000 sinon renvoie �Bon salaire'
	 create function salarytype(@sal decimal)
		returns varchar(50)
		as
		begin
			 declare @msg varchar(50)
				IF @sal<50000 
				   begin
					 set  @msg='Salaire faible'
				   end
				ELSE
				 begin
					set  @msg='Bon salaire'
				 end
		     return   @msg
		end
go;
			 -- Appel de la fonction
			print dbo.salarytype(70000);



go;
--5.	Modifier la fonction "salarytype" pour qu'elle fasse le m�me traitement mais pour un employ� donn�
  alter function salarytype(@id int)
		returns varchar(50)
		as
		begin
			 declare @msg varchar(50)
			 declare @sal decimal
			 set @sal=(select salary from Employee where EmployeeId=@id)
				IF @sal<50000 
				   begin
					 set  @msg='Salaire faible'
				   end
				ELSE
				 begin
					set  @msg='Bon salaire'
				 end
		     return   @msg
		end
go;
 -- Appel de la fonction
		print dbo.salarytype(4);
	

	--***********   -- Les fonctions tables ***********  
	go;
	 --Cr�ez une fonction nomm�e "getemployee" qui renvoie les informations d�un employ� donn�

	CREATE FUNCTION getemployee(@id int) 
		RETURNS table
		as
		return 
			select *
			from Employee 
			WHERE EmployeeId = @id 
				
	go;
	 -- Appel de la fonction
	select * from dbo.getemployee(1) 


	go;
	
--7.	Ecrire une fonction nomm�e "getemployee2" qui renvoie les noms des employ�s d�un service donn� 
	CREATE FUNCTION getemployee2(@dep varchar(50)) 
		RETURNS table
		as
		return 
			select FirstName,LastName
			from Employee 
			WHERE Department = @dep
				
	go;
	 -- Appel de la fonction
	select * from dbo.getemployee2('services') 

--8.	Ecrire une fonction nomm�e "getyear" qui renvoie la liste des Ids des employ�s et leurs ann�es d�embauche.

	go;
	CREATE FUNCTION getyear() 
		RETURNS  @tab table (id int, annee_embauche int)
		as
		 begin
			insert into @tab select EmployeeId, year(JoiningDate) from Employee
			
			return
		end
		go;	
		 -- Appel de la fonction
		select * from dbo.getyear() 

	

	go
	--9.	Ecrire une fonction nomm�e "qst9" qui renvoie une liste les nombres qui commence par un nombre d�finit 
	--par utilisateur et qui termine par un nombre aussi d�finit par utilisateur.

	create function qst9 (@i int, @j int)
	returns @tab table (nombre int)
	as
	begin
		WHILE @i <= @j
			BEGIN
				
				insert into @tab values (@i)
				SET @i = @i + 1;
			END
			return
	end

	go

	 -- Appel de la fonction
	select * from  dbo.qst9(1,20)






--////////////////////////////////////////////////////////////////////////////////////////////////

use ecole


--1.	Cr�er une connexion �log1� avec le mot de passe �DBgroup@�
create login log1 with password='DBgroup@'

--2.	Ajouter dans cette base de donn�es un utilisateur �user1� pour la connexion �log1�.

create user user1 for login log1
--3.	Ouvrir une nouvelle instance de SQL Server Management Studio, et se connecter avec le compte log1 :

--4. Ex�cuter la requ�te suivante : select * from eleve, Que remarquez-vous
/*L'autorisation SELECT a �t� refus�e sur l'objet 'eleve', base de donn�es 'ecole', sch�ma 'dbo'.
l'utilisateur user1 n'a aucune persmission sur aucune base de donn�e */

--5.	Accorder � l�utilisateur �user1� uniquement la permission d�acc�der aux donn�es de la table eleve.
grant  select on classe to user1

--6.	V�rifier si l�utilisateur �user1� peut acc�der aux donn�es de la table classe.

--7.	Ex�cuter la requ�te suivante insert into classe values ('P107'), Que remarquez-vous ?
--L'autorisation INSERT a �t� refus�e sur l'objet 'classe', base de donn�es 'ecole', sch�ma 'dbo'

--8.	Accorder � l�utilisateur �user1� la permission d�ins�rer des donn�es dans la table classe.
grant  insert on classe to user1

--10.	Ex�cuter la requ�te suivante : select * from eleve, Que remarquez-vous ?
--L'autorisation SELECT a �t� refus�e sur l'objet 'eleve', base de donn�es 'ecole', sch�ma 'dbo'.

--11.	Retirer le droit d�ins�rer des donn�es dans la table classe pour l�utilisateur �user1�
revoke insert on classe from user1

--12.	Cr�er une connexion �log2� avec le mot de passe �DBgroup2@�
create login log2 with password='DBgroup2@'

--13.	Ajouter dans la base de donn�es �ecole� un utilisateur �user2� pour la connexion �log2�.
create user user2 for login log2

--14.	Accorder � l�utilisateur �user1� la permission d�acc�der aux donn�es de la table classe avec 
--l�option de passer ce droit � d�autre utilisateurs
grant  select on classe to user1 WITH GRANT OPTION;

--16.	V�rifier si l�utilisateur �user2� peut acc�der aux donn�es de la table classe. Que remarquez-vous ?
-- Oui l�utilisateur �user2� peut acc�der aux donn�es de la table classe

--17.	Retirer le droit de SELECT � l�utilisateur �user1� avec : Revoke select on classe to user1; 
--Que remarquez-vous ?  Il faut sp�cifier l'option CASCADE.
Revoke  select on classe to user1 ;
Revoke  select on classe to user1 cascade;

--19.	Cr�er une connexion �log3� avec le mot de passe �DBgroup3@� et ajouter dans la base de donn�es �TP5� 
--un utilisateur �user3� pour la connexion �log3�.
use tp5ex1
create login log3 with password='DBgroup3@'
create user user3 for login log3

--20.	Accorder � l�utilisateur �user3� la permission de modifier la colonne salary de la table employee.
grant update(salary) on employee to user3

--23. Effectuer une sauvegarde de la base de donn�es ecole, puis supprimer cette derni�re avec drop et 
--essayer de faire d�une restauration.

backup database ecole to disk= 'ecolebackup.bak';
drop database ecole;
RESTORE database ecole from disk = 'ecolebackup.bak';