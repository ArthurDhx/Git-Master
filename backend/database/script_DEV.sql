create table if NOT exists YEARS(
	id_year SERIAL,
	label_year VARCHAR(25) NOT NULL,
	PRIMARY KEY(id_year)
);

create table if NOT exists STUDENTS (
	id SERIAL,
	firstname VARCHAR (25) NOT NULL,
	lastname VARCHAR (25) NOT NULL,
	email VARCHAR (50) NOT NULL,
	uid_ul VARCHAR (25) NOT NULL,
	formation VARCHAR (15) NOT NULL,
	primary key(id)
);

create table if NOT exists USERS (
	id_user SERIAL,
	firstname VARCHAR (25) NOT NULL,
	lastname VARCHAR (25) NOT NULL,
	uid_ul VARCHAR (25) NOT NULL,
	password VARCHAR (128) NOT NULL,
	email VARCHAR (50) NOT NULL,
	picture VARCHAR (100),
	id_gitlab INTEGER NOT NULL,
	token_gitlab VARCHAR(100),
	primary key(id_user)
);

create table if NOT exists ROLES (
	id_role SERIAL,
	label_role VARCHAR(25),
	display_role VARCHAR(25) NOT NULL,
	PRIMARY KEY(id_role)
);

create table if NOT exists ROLE_USER (
	id_user SERIAL,
	id_role SERIAL,
	PRIMARY KEY(id_user,id_role),
	FOREIGN KEY (id_user)
      REFERENCES USERS (id_user),
  	FOREIGN KEY (id_role)
      REFERENCES ROLES (id_role)
);

create table if NOT exists CLASS_GROUP (
	id_group SERIAL,
	label_group VARCHAR(25) NOT NULL,
	PRIMARY KEY (id_group)
);

create table if NOT exists REPO_GROUP (
    id_repo SERIAL,
    label_group VARCHAR(50) NOT NULL,
	start_date timestamp NOT NULL,
	end_date timestamp,
	id_creator INTEGER,
	is_open BOOLEAN,
    PRIMARY KEY (id_repo),
	FOREIGN KEY (id_creator)
      REFERENCES USERS (id_user)
);

create table if NOT exists REPO_GROUP_FILTERS (
	id SERIAL,
    id_repo INTEGER,
    file_path VARCHAR(150) NOT NULL,
    PRIMARY KEY (id),
	FOREIGN KEY (id_repo) REFERENCES REPO_GROUP (id_repo)
);

create table if NOT exists PUPIL_GROUP (
	id_pupil_group SERIAL,
	label_group VARCHAR(100) NOT NULL,
	PRIMARY KEY (id_pupil_group)
);


create table if NOT exists STUDENT_CLASS_GROUP (
    id_class SERIAL,
    id_student SERIAL,
    PRIMARY KEY(id_class,id_student),
    FOREIGN KEY (id_class)
      REFERENCES CLASS_GROUP(id_group),
    FOREIGN KEY (id_student)
      REFERENCES STUDENTS(id)
);

create table if NOT exists STUDENT_REPO_GROUP (
    id_repo SERIAL,
    id_student SERIAL,
	id_project INTEGER NOT NULL,
    PRIMARY KEY(id_repo,id_student),
    FOREIGN KEY (id_repo)
      REFERENCES REPO_GROUP(id_repo),
    FOREIGN KEY (id_student)
      REFERENCES STUDENTS(id)
);

create table if NOT exists STUDENT_PUPIL_GROUP (
    id_pupil_group SERIAL,
    id_student SERIAL,
    PRIMARY KEY(id_pupil_group,id_student),
    FOREIGN KEY (id_pupil_group)
      REFERENCES PUPIL_GROUP(id_pupil_group),
    FOREIGN KEY (id_student)
      REFERENCES STUDENTS(id)
);

create table if NOT exists USER_REPO_GROUP (
	id_repo SERIAL,
	id_user SERIAL,
	PRIMARY KEY(id_repo, id_user),
	FOREIGN KEY(id_repo)
	  REFERENCES REPO_GROUP(id_repo),
	FOREIGN KEY(id_user)
	  REFERENCES USERS(id_user)
);

create table if NOT exists YEAR_STUDENT (
    id_year SERIAL,
    id_student SERIAL,
    PRIMARY KEY(id_year,id_student),
    FOREIGN KEY (id_year)
      REFERENCES YEARS(id_year),
    FOREIGN KEY (id_student)
      REFERENCES STUDENTS(id)
);

-----YEARS------

INSERT INTO YEARS(label_year) VALUES ('1');
INSERT INTO YEARS(label_year) VALUES ('2');
INSERT INTO YEARS(label_year) VALUES ('3');


------STUDENTS---------
----1A----
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Samir','ABDALLAH','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Maxence','AGRA','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Olivia','AING','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Lucas','ARIES','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Pierre','AUGUSTE','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Mathis','AULAGNIER','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Mathias','AURAND','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Angel','AYMÉ','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Guilhem','BARBIER SAINT HILAIRE','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Helena','BARBILLON','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Maxence','BEKHEDDA','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Léo','BERNARD','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Corentin','BILLARD','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Ugo','BIRKEL','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Yamine','BOUALIT','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Maxence','BOUCHADEL','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Hugo','BRINES','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Matthias','CABILLOT','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Léo','CAMBIER','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Damien','CAMPENS','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Arthur','CAPPELLINA','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Lina','CHAKROUN','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Adrien','CHRISTIAËN','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Quentin','COAN','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Julien','COMBELERAN','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Benjamin','CORDEBAR','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Titouan','COUVRAT--PAILLE','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Kieran','DALIGAUD','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Lana','DAMIENS','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Gabriel','DÉCAVÉ','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Bastien','DELHAYE','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Aurélie','DEMURE','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Augustin','DESBOIS','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Paul','DEVEAUX','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Théo','DEYGAS','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Adrien','DIDON','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Yann','DIONISIO','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Alexandre','DUCHESNE','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Aristide','DUHEM','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Romain','DUPRE','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Hajar','ELMADDAH','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Nicolas','FERNANDEZ','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Louis','FERRY','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Julie','FONDRAT','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Léo','FORNOFF','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Antonin','FREY','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Anna','GALKOWSKI','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Léo','GERMAIN','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Matthias','GERMAIN','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Thomas','GIANELLI','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Aurélien','GINDRE','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Arthur','GÔMES','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Florian','GONÇALVES','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Ugo','GOSSO','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Gabin','GRANJON','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('David','GUICHARD','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Calvin','GUILLEMET','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Pierre','GUYOT','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Amine','HARADJ','maxime.istace@telecomancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Meyssam','HNID','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Theo','HORNBERGER','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Christophe','HOYAU','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Pierre-Yves','JACQUIER','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Thomas','JEANJACQUOT','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Maëlle','JUILLIOT','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Orneil Serges','KONAN','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Arnaud','KRAFFT','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Thomas','LACROIX','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Louis','LANG','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Pierre-Louis','LANG','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Titouan','LANGLAIS','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Amandine','LAPIQUE--FAVRE','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Adrien','LAROUSSE','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Lucas','LAURENT','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Alexandre','LE FOLL','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Manon','LECUBIN','maxime.istace@telecomanncy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Corentin','LEFFONDRE','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Chad','LEPECUCHELLE','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Thomas','LERUEZ','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Victor','LEVREL','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Thibaud','LIMBACH','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('El Hadji Malick','LO','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Mathis','MANGOLD','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Alexis','MARCEL','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Rayan','MARRADO','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Antonin','MASSART','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Jérémi','MENTEC','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Stanislas','MEZUREUX','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Xavier','MONARD','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Célestin','MOREL','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Massimiliano','MORTAIGNE','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Kélian','MOY','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Alexis','MUNCH','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Elise','NEŸENS','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Thanh An','NGUYEN','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Nour','NSIRI','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('David','ORZECHOWSKI','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Yannis','OUAKRIM','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Ilyes','OUANEZAR','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Thomas','PERNIN','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Mathéo','ROBERT','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Aymeric','ROUSSEL','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Theo','ROVILLO','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Romain','SAMBA','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Lili','SCHMIDLIN','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Chahrazad','SEHRANI','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Noa','SÉNÉSI','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Maxime','SOLDATOV','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Noe','STEINER','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Terry','TEMPESTINI','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Clément','TEXIER','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Hugo','THEVENIN','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Killian','THUILLIER','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Maelan','TIGER','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Ahtisham','TOOR','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Cosimo','UNGARO','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Abel','VAGNE','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Erwan','VAILLANT','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Etienne','VATRY','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Léo','VESSE','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Victor','VOISIN','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Sirielle','WALTER','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Théo','WALTER','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Michaël','YANG','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Julie','ZHEN','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Alex','ZHOU','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Lucas','ZORMAN','maxime.istace@telecomnancy.eu','istace2u','fise');

insert into students(firstname,lastname,email,uid_ul,formation) values ('Gautier','BERTRAND','maxime.istace@telecomnancy.eu','istace2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Damien','BURST','maxime.istace@telecomnancy.eu','istace2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Gabin','CHASSARD','maxime.istace@telecomnancy.eu','istace2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Louis','COURRIER','maxime.istace@telecomnancy.eu','istace2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Aurelien','FRANCOIS','maxime.istace@telecomnancy.eu','istace2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Clément','GEHIN'	,'maxime.istace@telecomnancy.eu','istace2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Leopold','HENRY','maxime.istace@telecomnancy.eu','istace2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Romain','HERBIN','maxime.istace@telecomnancy.eu','istace2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Robin','KREROWICZ','maxime.istace@telecomnancy.eu','istace2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Hugo','LOISEAU','maxime.istace@telecomnancy.eu','istace2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Romain','NATANELIC','maxime.istace@telecomnancy.eu','istace2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Nicolas','RENARD','maxime.istace@telecomnancy.eu','istace2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Baptiste','ROBERT','maxime.istace@telecomnancy.eu','istace2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Emmanuel','SEVELEDER','maxime.istace@telecomnancy.eu','istace2u','fisa');

----2A----
insert into students(firstname,lastname,email,uid_ul,formation) values ('Sangoan','BRIGUE','sangoan.brigue@telecomnancy.eu','brigue2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Lucas','TABBONE','lucas.tabbone@telecomnancy.eu','tabbone4u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Baptiste','BRULLARD','baptiste.brullard@telecomnancy.eu','brullard4u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Rémy','HENEAUX','remy.heneaux@telecomnancy.eu','heneaux2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Arthur','DUHOUX','arthur.duhoux@telecomnancy.eu','duhoux4u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Maxime','ISTACE','maxime.istace@telecomnancy.eu','istace2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Romain','DEFRANOUX','maxime.istace@telecomnancy.eu','istace2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Antoine','CHAMPAULT','maxime.istace@telecomnancy.eu','istace2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Rémi','MARSAL','maxime.istace@telecomnancy.eu','istace2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Joshua','TETON','maxime.istace@telecomnancy.eu','istace2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Alexandra','DEMSKI','maxime.istace@telecomnancy.eu','istace2u','fisa');

insert into students(firstname,lastname,email,uid_ul,formation) values ('Léo','ALONZO','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Norman','ASSING','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Oceane','AVILA','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Mathilde','BARD','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Adrien','BASCHUNG','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Albert','BECQUET','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Thomas','PALLET','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Tristan','SMAGGHE','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Lucie','BOUCHER','maxime.istace@telecomnancy.eu','istace2u','fise');

----3A----
insert into students(firstname,lastname,email,uid_ul,formation) values ('Hamza','ABDOULHOUSSEN','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Kamal','ALLOUCHE','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('yohann','AMOSSE','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Paul','ANTONI','maxime.istace@telecomancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Yonah','BACK','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Rachel','BACZYNSKI','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Tommy','BARAFANI','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Nicolas','BEAUDOUIN','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Chloe','BERNARDET','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Thais','BERNARDI','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Elisa','BONIFAS','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Adrien','BONTEMS','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Baptiste','BOUDOU','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Sami','BOULECHFAR','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Anthony','BRIAN','maxime.istace@telecomnancy.eu','istace2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Tara','BRIDIER','maxime.istace@telecomnancy.eu','istace2u','fise');

insert into students(firstname,lastname,email,uid_ul,formation) values ('Théo','PONCHON','maxime.istace@telecomnancy.eu','istace2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Julien','NOEL','maxime.istace@telecomnancy.eu','istace2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Antoine','PINSTON','maxime.istace@telecomnancy.eu','istace2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Lisa','RAMLOT','maxime.istace@telecomnancy.eu','istace2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Sacha','CUENOT','maxime.istace@telecomnancy.eu','istace2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Hugo','BLAISON','maxime.istace@telecomnancy.eu','istace2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Loan','HELLER','maxime.istace@telecomnancy.eu','istace2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Kelyan','MARCHAL','maxime.istace@telecomnancy.eu','istace2u','fisa');

------USERS-------
insert into users(firstname,lastname,uid_ul,password,email,picture, id_gitlab) values ('Sebastien','DaSilva','dasilva5u','$2b$12$E4SYFlb7eVIugvCGsM07nekREmVqffiHX9P4lURnIhTljxJ9LVqhy','maxime.istace@telecomnancy.eu','', 1060);
insert into users(firstname,lastname,uid_ul,password,email,picture, id_gitlab) values ('Paul','Jacques','jacques8u','$2b$12$E4SYFlb7eVIugvCGsM07nekREmVqffiHX9P4lURnIhTljxJ9LVqhy','maxime.istace@telecomnancy.eu','', 1060);
insert into users(firstname,lastname,uid_ul,password,email,picture, id_gitlab) values ('Jeremy','Sah','sah6u','$2b$12$E4SYFlb7eVIugvCGsM07nekREmVqffiHX9P4lURnIhTljxJ9LVqhy','maxime.istace@telecomnancy.eu','', 1060);
insert into users(firstname,lastname,uid_ul,password,email,picture, id_gitlab) values ('Thierry','Hillion','hillion2u','$2b$12$E4SYFlb7eVIugvCGsM07nekREmVqffiHX9P4lURnIhTljxJ9LVqhy','maxime.istace@telecomnancy.eu','', 1060);
insert into users(firstname,lastname,uid_ul,password,email,picture, id_gitlab) values ('Olivier','Festor','festor2u','$2b$12$E4SYFlb7eVIugvCGsM07nekREmVqffiHX9P4lURnIhTljxJ9LVqhy','maxime.istace@telecomnancy.eu','', 1060);
insert into users(firstname,lastname,uid_ul,password,email,picture, id_gitlab) values ('Frederic','Maux','maux2u','$2b$12$E4SYFlb7eVIugvCGsM07nekREmVqffiHX9P4lURnIhTljxJ9LVqhy','maxime.istace@telecomnancy.eu','', 1060);
insert into users(firstname,lastname,uid_ul,password,email,picture, id_gitlab) values ('Lucas','Tabbone','tabbone4u','$2b$12$E4SYFlb7eVIugvCGsM07nekREmVqffiHX9P4lURnIhTljxJ9LVqhy','lucas.tabbone@telecomnancy.eu','', 1046);
insert into users(firstname,lastname,uid_ul,password,email,picture, id_gitlab) values ('Baptiste','Brullard','brullard4u','$2b$12$E4SYFlb7eVIugvCGsM07nekREmVqffiHX9P4lURnIhTljxJ9LVqhy','baptiste.brullard@telecomnancy.eu','', 1057);
insert into users(firstname,lastname,uid_ul,password,email,picture, id_gitlab) values ('Sangoan','Brigue','brigue4u','$2b$12$E4SYFlb7eVIugvCGsM07nekREmVqffiHX9P4lURnIhTljxJ9LVqhy','sangoan.brigue@telecomnancy.eu','', 1044);
insert into users(firstname,lastname,uid_ul,password,email,picture, id_gitlab) values ('Arthur','Duhoux','duhoux4u','$2b$12$E4SYFlb7eVIugvCGsM07nekREmVqffiHX9P4lURnIhTljxJ9LVqhy','arthur.duhoux@telecomnancy.eu','', 1048);
insert into users(firstname,lastname,uid_ul,password,email,picture, id_gitlab) values ('Maxime','Istace','istace2u','$2b$12$E4SYFlb7eVIugvCGsM07nekREmVqffiHX9P4lURnIhTljxJ9LVqhy','maxime.istace@telecomnancy.eu','', 1066);
insert into users(firstname,lastname,uid_ul,password,email,picture, id_gitlab) values ('Rémy','Heneaux','heneaux4u','$2b$12$E4SYFlb7eVIugvCGsM07nekREmVqffiHX9P4lURnIhTljxJ9LVqhy','remy.heneaux@telecomnancy.eu','', 1060);

-----STUDENT_YEARS------
---1A---
insert into YEAR_STUDENT(id_year,id_student) values (1,1);
insert into YEAR_STUDENT(id_year,id_student) values (1,2);
insert into YEAR_STUDENT(id_year,id_student) values (1,3);
insert into YEAR_STUDENT(id_year,id_student) values (1,4);
insert into YEAR_STUDENT(id_year,id_student) values (1,5);
insert into YEAR_STUDENT(id_year,id_student) values (1,6);
insert into YEAR_STUDENT(id_year,id_student) values (1,7);
insert into YEAR_STUDENT(id_year,id_student) values (1,8);
insert into YEAR_STUDENT(id_year,id_student) values (1,9);
insert into YEAR_STUDENT(id_year,id_student) values (1,10);
insert into YEAR_STUDENT(id_year,id_student) values (1,11);
insert into YEAR_STUDENT(id_year,id_student) values (1,12);
insert into YEAR_STUDENT(id_year,id_student) values (1,13);
insert into YEAR_STUDENT(id_year,id_student) values (1,14);
insert into YEAR_STUDENT(id_year,id_student) values (1,15);
insert into YEAR_STUDENT(id_year,id_student) values (1,16);
insert into YEAR_STUDENT(id_year,id_student) values (1,17);
insert into YEAR_STUDENT(id_year,id_student) values (1,18);
insert into YEAR_STUDENT(id_year,id_student) values (1,19);
insert into YEAR_STUDENT(id_year,id_student) values (1,20);
insert into YEAR_STUDENT(id_year,id_student) values (1,21);
insert into YEAR_STUDENT(id_year,id_student) values (1,22);
insert into YEAR_STUDENT(id_year,id_student) values (1,23);
insert into YEAR_STUDENT(id_year,id_student) values (1,24);
insert into YEAR_STUDENT(id_year,id_student) values (1,25);
insert into YEAR_STUDENT(id_year,id_student) values (1,26);
insert into YEAR_STUDENT(id_year,id_student) values (1,27);
insert into YEAR_STUDENT(id_year,id_student) values (1,28);
insert into YEAR_STUDENT(id_year,id_student) values (1,29);
insert into YEAR_STUDENT(id_year,id_student) values (1,30);
insert into YEAR_STUDENT(id_year,id_student) values (1,31);
insert into YEAR_STUDENT(id_year,id_student) values (1,32);
insert into YEAR_STUDENT(id_year,id_student) values (1,33);
insert into YEAR_STUDENT(id_year,id_student) values (1,34);
insert into YEAR_STUDENT(id_year,id_student) values (1,35);
insert into YEAR_STUDENT(id_year,id_student) values (1,36);
insert into YEAR_STUDENT(id_year,id_student) values (1,37);
insert into YEAR_STUDENT(id_year,id_student) values (1,38);
insert into YEAR_STUDENT(id_year,id_student) values (1,39);
insert into YEAR_STUDENT(id_year,id_student) values (1,40);
insert into YEAR_STUDENT(id_year,id_student) values (1,41);
insert into YEAR_STUDENT(id_year,id_student) values (1,42);
insert into YEAR_STUDENT(id_year,id_student) values (1,43);
insert into YEAR_STUDENT(id_year,id_student) values (1,44);
insert into YEAR_STUDENT(id_year,id_student) values (1,45);
insert into YEAR_STUDENT(id_year,id_student) values (1,46);
insert into YEAR_STUDENT(id_year,id_student) values (1,47);
insert into YEAR_STUDENT(id_year,id_student) values (1,48);
insert into YEAR_STUDENT(id_year,id_student) values (1,49);
insert into YEAR_STUDENT(id_year,id_student) values (1,50);
insert into YEAR_STUDENT(id_year,id_student) values (1,51);
insert into YEAR_STUDENT(id_year,id_student) values (1,52);
insert into YEAR_STUDENT(id_year,id_student) values (1,53);
insert into YEAR_STUDENT(id_year,id_student) values (1,54);
insert into YEAR_STUDENT(id_year,id_student) values (1,55);
insert into YEAR_STUDENT(id_year,id_student) values (1,56);
insert into YEAR_STUDENT(id_year,id_student) values (1,57);
insert into YEAR_STUDENT(id_year,id_student) values (1,58);
insert into YEAR_STUDENT(id_year,id_student) values (1,59);
insert into YEAR_STUDENT(id_year,id_student) values (1,60);
insert into YEAR_STUDENT(id_year,id_student) values (1,61);
insert into YEAR_STUDENT(id_year,id_student) values (1,62);
insert into YEAR_STUDENT(id_year,id_student) values (1,63);
insert into YEAR_STUDENT(id_year,id_student) values (1,64);
insert into YEAR_STUDENT(id_year,id_student) values (1,65);
insert into YEAR_STUDENT(id_year,id_student) values (1,66);
insert into YEAR_STUDENT(id_year,id_student) values (1,67);
insert into YEAR_STUDENT(id_year,id_student) values (1,68);
insert into YEAR_STUDENT(id_year,id_student) values (1,69);
insert into YEAR_STUDENT(id_year,id_student) values (1,70);
insert into YEAR_STUDENT(id_year,id_student) values (1,71);
insert into YEAR_STUDENT(id_year,id_student) values (1,72);
insert into YEAR_STUDENT(id_year,id_student) values (1,73);
insert into YEAR_STUDENT(id_year,id_student) values (1,74);
insert into YEAR_STUDENT(id_year,id_student) values (1,75);
insert into YEAR_STUDENT(id_year,id_student) values (1,76);
insert into YEAR_STUDENT(id_year,id_student) values (1,77);
insert into YEAR_STUDENT(id_year,id_student) values (1,78);
insert into YEAR_STUDENT(id_year,id_student) values (1,79);
insert into YEAR_STUDENT(id_year,id_student) values (1,80);
insert into YEAR_STUDENT(id_year,id_student) values (1,81);
insert into YEAR_STUDENT(id_year,id_student) values (1,82);
insert into YEAR_STUDENT(id_year,id_student) values (1,83);
insert into YEAR_STUDENT(id_year,id_student) values (1,84);
insert into YEAR_STUDENT(id_year,id_student) values (1,85);
insert into YEAR_STUDENT(id_year,id_student) values (1,86);
insert into YEAR_STUDENT(id_year,id_student) values (1,87);
insert into YEAR_STUDENT(id_year,id_student) values (1,88);
insert into YEAR_STUDENT(id_year,id_student) values (1,89);
insert into YEAR_STUDENT(id_year,id_student) values (1,90);
insert into YEAR_STUDENT(id_year,id_student) values (1,91);
insert into YEAR_STUDENT(id_year,id_student) values (1,92);
insert into YEAR_STUDENT(id_year,id_student) values (1,93);
insert into YEAR_STUDENT(id_year,id_student) values (1,94);
insert into YEAR_STUDENT(id_year,id_student) values (1,95);
insert into YEAR_STUDENT(id_year,id_student) values (1,96);
insert into YEAR_STUDENT(id_year,id_student) values (1,97);
insert into YEAR_STUDENT(id_year,id_student) values (1,98);
insert into YEAR_STUDENT(id_year,id_student) values (1,99);
insert into YEAR_STUDENT(id_year,id_student) values (1,100);
insert into YEAR_STUDENT(id_year,id_student) values (1,101);
insert into YEAR_STUDENT(id_year,id_student) values (1,102);
insert into YEAR_STUDENT(id_year,id_student) values (1,103);
insert into YEAR_STUDENT(id_year,id_student) values (1,104);
insert into YEAR_STUDENT(id_year,id_student) values (1,105);
insert into YEAR_STUDENT(id_year,id_student) values (1,106);
insert into YEAR_STUDENT(id_year,id_student) values (1,107);
insert into YEAR_STUDENT(id_year,id_student) values (1,108);
insert into YEAR_STUDENT(id_year,id_student) values (1,109);
insert into YEAR_STUDENT(id_year,id_student) values (1,110);
insert into YEAR_STUDENT(id_year,id_student) values (1,111);
insert into YEAR_STUDENT(id_year,id_student) values (1,112);
insert into YEAR_STUDENT(id_year,id_student) values (1,113);
insert into YEAR_STUDENT(id_year,id_student) values (1,114);
insert into YEAR_STUDENT(id_year,id_student) values (1,115);
insert into YEAR_STUDENT(id_year,id_student) values (1,116);
insert into YEAR_STUDENT(id_year,id_student) values (1,117);
insert into YEAR_STUDENT(id_year,id_student) values (1,118);
insert into YEAR_STUDENT(id_year,id_student) values (1,119);
insert into YEAR_STUDENT(id_year,id_student) values (1,120);
insert into YEAR_STUDENT(id_year,id_student) values (1,121);
insert into YEAR_STUDENT(id_year,id_student) values (1,122);
insert into YEAR_STUDENT(id_year,id_student) values (1,123);
insert into YEAR_STUDENT(id_year,id_student) values (1,124);
insert into YEAR_STUDENT(id_year,id_student) values (1,125);
insert into YEAR_STUDENT(id_year,id_student) values (1,126);
insert into YEAR_STUDENT(id_year,id_student) values (1,127);
insert into YEAR_STUDENT(id_year,id_student) values (1,128);
insert into YEAR_STUDENT(id_year,id_student) values (1,129);
insert into YEAR_STUDENT(id_year,id_student) values (1,130);
insert into YEAR_STUDENT(id_year,id_student) values (1,131);
insert into YEAR_STUDENT(id_year,id_student) values (1,132);
insert into YEAR_STUDENT(id_year,id_student) values (1,133);
insert into YEAR_STUDENT(id_year,id_student) values (1,134);
insert into YEAR_STUDENT(id_year,id_student) values (1,135);
insert into YEAR_STUDENT(id_year,id_student) values (1,136);
insert into YEAR_STUDENT(id_year,id_student) values (1,137);
insert into YEAR_STUDENT(id_year,id_student) values (1,138);
insert into YEAR_STUDENT(id_year,id_student) values (1,139);
insert into YEAR_STUDENT(id_year,id_student) values (1,140);
insert into YEAR_STUDENT(id_year,id_student) values (1,141);

---2A---
insert into YEAR_STUDENT(id_year,id_student) values (2,142);
insert into YEAR_STUDENT(id_year,id_student) values (2,143);
insert into YEAR_STUDENT(id_year,id_student) values (2,144);
insert into YEAR_STUDENT(id_year,id_student) values (2,145);
insert into YEAR_STUDENT(id_year,id_student) values (2,146);
insert into YEAR_STUDENT(id_year,id_student) values (2,147);
insert into YEAR_STUDENT(id_year,id_student) values (2,148);
insert into YEAR_STUDENT(id_year,id_student) values (2,149);
insert into YEAR_STUDENT(id_year,id_student) values (2,150);
insert into YEAR_STUDENT(id_year,id_student) values (2,151);
insert into YEAR_STUDENT(id_year,id_student) values (2,152);
insert into YEAR_STUDENT(id_year,id_student) values (2,153);
insert into YEAR_STUDENT(id_year,id_student) values (2,154);
insert into YEAR_STUDENT(id_year,id_student) values (2,155);
insert into YEAR_STUDENT(id_year,id_student) values (2,156);
insert into YEAR_STUDENT(id_year,id_student) values (2,157);
insert into YEAR_STUDENT(id_year,id_student) values (2,158);
insert into YEAR_STUDENT(id_year,id_student) values (2,159);
insert into YEAR_STUDENT(id_year,id_student) values (2,160);
insert into YEAR_STUDENT(id_year,id_student) values (2,161);

---3A---
insert into YEAR_STUDENT(id_year,id_student) values (3,162);
insert into YEAR_STUDENT(id_year,id_student) values (3,163);
insert into YEAR_STUDENT(id_year,id_student) values (3,164);
insert into YEAR_STUDENT(id_year,id_student) values (3,165);
insert into YEAR_STUDENT(id_year,id_student) values (3,166);
insert into YEAR_STUDENT(id_year,id_student) values (3,167);
insert into YEAR_STUDENT(id_year,id_student) values (3,168);
insert into YEAR_STUDENT(id_year,id_student) values (3,169);
insert into YEAR_STUDENT(id_year,id_student) values (3,170);
insert into YEAR_STUDENT(id_year,id_student) values (3,171);
insert into YEAR_STUDENT(id_year,id_student) values (3,172);
insert into YEAR_STUDENT(id_year,id_student) values (3,173);
insert into YEAR_STUDENT(id_year,id_student) values (3,174);
insert into YEAR_STUDENT(id_year,id_student) values (3,175);
insert into YEAR_STUDENT(id_year,id_student) values (3,176);
insert into YEAR_STUDENT(id_year,id_student) values (3,177);
insert into YEAR_STUDENT(id_year,id_student) values (3,178);
insert into YEAR_STUDENT(id_year,id_student) values (3,179);
insert into YEAR_STUDENT(id_year,id_student) values (3,180);
insert into YEAR_STUDENT(id_year,id_student) values (3,181);
insert into YEAR_STUDENT(id_year,id_student) values (3,182);
insert into YEAR_STUDENT(id_year,id_student) values (3,183);
insert into YEAR_STUDENT(id_year,id_student) values (3,184);
insert into YEAR_STUDENT(id_year,id_student) values (3,185);

-------ROLES-------
insert into  roles(label_role, display_role) values ('teacher','Enseignant');
insert into  roles(label_role, display_role) values ('administrator','Administrateur');


-------ROLE_USER-------
insert into role_user(id_user,id_role) values(1,1);
insert into role_user(id_user,id_role) values(2,1);
insert into role_user(id_user,id_role) values(3,1);
insert into role_user(id_user,id_role) values(4,1);
insert into role_user(id_user,id_role) values(5,1);
insert into role_user(id_user,id_role) values(6,1);
insert into role_user(id_user,id_role) values(7,2);
insert into role_user(id_user,id_role) values(8,2);
insert into role_user(id_user,id_role) values(9,2);
insert into role_user(id_user,id_role) values(10,2);
insert into role_user(id_user,id_role) values(11,2);
insert into role_user(id_user,id_role) values(12,2);

--------GROUP--------
insert into class_group(label_group) values ('g1');
insert into class_group(label_group) values ('g11');
insert into class_group(label_group) values ('g12');
insert into class_group(label_group) values ('g2');
insert into class_group(label_group) values ('g21');
insert into class_group(label_group) values ('g22');
insert into class_group(label_group) values ('g3');
insert into class_group(label_group) values ('g31');
insert into class_group(label_group) values ('g32');
insert into class_group(label_group) values ('g4');
insert into class_group(label_group) values ('g41');
insert into class_group(label_group) values ('g42');
insert into class_group(label_group) values ('IAMD');
insert into class_group(label_group) values ('IL');
insert into class_group(label_group) values ('SIE');
insert into class_group(label_group) values ('ISS');
insert into class_group(label_group) values ('LE');
insert into class_group(label_group) values ('APP');

-----REPO_GROUP-------

insert into REPO_GROUP(label_group, start_date, id_creator) values ('Examen JAVA apprentis 2A', '2022-11-09 18:21:00', 5);
insert into REPO_GROUP(label_group, start_date, id_creator) values ('Examen MSED apprentis 1A', '2022-11-09 18:21:00', 1);
insert into REPO_GROUP(label_group, start_date, id_creator) values ('Examen C fise 2A', '2022-11-09 18:21:00', 5);

-----PUPIL_GROUP------

insert into PUPIL_GROUP(label_group) values ('PMU');

-----USER_REPO_GROUP------

INSERT INTO USER_REPO_GROUP(id_repo, id_user) VALUES(1, 5);
INSERT INTO USER_REPO_GROUP(id_repo, id_user) VALUES(2, 1);
INSERT INTO USER_REPO_GROUP(id_repo, id_user) VALUES(3, 5);

------STUDENT_CLASS_GROUP-------
insert into student_class_group(id_class,id_student) values (18,142);
insert into student_class_group(id_class,id_student) values (18,143);
insert into student_class_group(id_class,id_student) values (18,144);
insert into student_class_group(id_class,id_student) values (18,145);
insert into student_class_group(id_class,id_student) values (18,146);
insert into student_class_group(id_class,id_student) values (18,147);
insert into student_class_group(id_class,id_student) values (18,148);
insert into student_class_group(id_class,id_student) values (18,149);
insert into student_class_group(id_class,id_student) values (18,150);
insert into student_class_group(id_class,id_student) values (18,151);
insert into student_class_group(id_class,id_student) values (18,152);
insert into student_class_group(id_class,id_student) values (16,153);
insert into student_class_group(id_class,id_student) values (17,154);

insert into student_class_group(id_class,id_student) values (14,155);
insert into student_class_group(id_class,id_student) values (15,156);
insert into student_class_group(id_class,id_student) values (16,157);
insert into student_class_group(id_class,id_student) values (13,158);
insert into student_class_group(id_class,id_student) values (17,159);
insert into student_class_group(id_class,id_student) values (13,160);
insert into student_class_group(id_class,id_student) values (16,161);
insert into student_class_group(id_class,id_student) values (16,162);
insert into student_class_group(id_class,id_student) values (13,163);
insert into student_class_group(id_class,id_student) values (14,164);
insert into student_class_group(id_class,id_student) values (15,165);

insert into student_class_group(id_class,id_student) values(18,128);
insert into student_class_group(id_class,id_student) values(18,129);
insert into student_class_group(id_class,id_student) values(18,130);
insert into student_class_group(id_class,id_student) values(18,131);
insert into student_class_group(id_class,id_student) values(18,132);
insert into student_class_group(id_class,id_student) values(18,133);
insert into student_class_group(id_class,id_student) values(18,134);
insert into student_class_group(id_class,id_student) values(18,135);
insert into student_class_group(id_class,id_student) values(18,136);
insert into student_class_group(id_class,id_student) values(18,137);
insert into student_class_group(id_class,id_student) values(18,138);
insert into student_class_group(id_class,id_student) values(18,139);
insert into student_class_group(id_class,id_student) values(18,140);
insert into student_class_group(id_class,id_student) values(18,141);

insert into student_class_group(id_class,id_student) values(5,1);
insert into student_class_group(id_class,id_student) values(2,2);
insert into student_class_group(id_class,id_student) values(2,3);
insert into student_class_group(id_class,id_student) values(8,4);
insert into student_class_group(id_class,id_student) values(8,5);
insert into student_class_group(id_class,id_student) values(11,6);
insert into student_class_group(id_class,id_student) values(2,7);
insert into student_class_group(id_class,id_student) values(8,8);
insert into student_class_group(id_class,id_student) values(5,9);
insert into student_class_group(id_class,id_student) values(5,10);


insert into student_class_group(id_class,id_student) values(1,47);
insert into student_class_group(id_class,id_student) values(1,125);
insert into student_class_group(id_class,id_student) values(1,126);
insert into student_class_group(id_class,id_student) values(18,178);
insert into student_class_group(id_class,id_student) values(18,185);

-----STUDENT_PUPIL_GROUP------

insert into STUDENT_PUPIL_GROUP(id_pupil_group,id_student) values (1,142);
insert into STUDENT_PUPIL_GROUP(id_pupil_group,id_student) values (1,143);
insert into STUDENT_PUPIL_GROUP(id_pupil_group,id_student) values (1,144);
insert into STUDENT_PUPIL_GROUP(id_pupil_group,id_student) values (1,145);
insert into STUDENT_PUPIL_GROUP(id_pupil_group,id_student) values (1,146);
insert into STUDENT_PUPIL_GROUP(id_pupil_group,id_student) values (1,147);