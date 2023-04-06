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

create table if NOT exists YEAR_STUDENT  (
    id_year SERIAL,
    id_student SERIAL,
    PRIMARY KEY(id_year,id_student),
    FOREIGN KEY (id_year)
      REFERENCES YEARS(id_year),
    FOREIGN KEY (id_student)
      REFERENCES STUDENTS(id)
);


-----year_student------

INSERT INTO YEARS( label_year) VALUES ('1');
INSERT INTO YEARS( label_year) VALUES ('2');
INSERT INTO YEARS( label_year) VALUES ('3');


------STUDENTS---------
----1A----
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Samir','ABDALLAH','samir.abdallah@telecomnancy.eu','abdallah7u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Maxence','AGRA','maxence.agra@telecomnancy.eu','agra3u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Olivia','AING','olivia.aing@telecomnancy.eu','aing9u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Lucas','ARIES','lucas.aries@telecomnancy.eu','aries4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Pierre','AUGUSTE','pierre.auguste@telecomnancy.eu','auguste9u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Mathis','AULAGNIER','mathis.aulagnier@telecomnancy.eu','aulagnier2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Mathias','AURAND','mathias.aurand@telecomnancy.eu','aurand1u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Angel','AYMÉ','angel.ayme@telecomnancy.eu','ayme1u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Guilhem','BARBIER SAINT HILAIRE','guilhem.barbier-saint-hilaire@telecomnancy.eu','barbier4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Helena','BARBILLON','helena.barbillon@telecomnancy.eu','barbillon7u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Maxence','BEKHEDDA','maxence.bekhedda@telecomnancy.eu','bekhedda1u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Léo','BERNARD','leo.bernard@telecomnancy.eu','bernard1u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Corentin','BILLARD','corentin.billard@telecomnancy.eu','billard2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Ugo','BIRKEL','ugo.birkel@telecomnancy.eu','birkel1u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Yamine','BOUALIT','yamine.boualit@telecomnancy.eu','boualit1u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Maxence','BOUCHADEL','maxence.bouchadel@telecomnancy.eu','bouchadel1u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Hugo','BRINES','hugo.brines@telecomnancy.eu','brines1u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Matthias','CABILLOT','matthias.cabillot@telecomnancy.eu','cabillot1u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Léo','CAMBIER','leo.cambier@telecomnancy.eu','cambier8u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Damien','CAMPENS','damien.campens@telecomnancy.eu','campens2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Arthur','CAPPELLINA','arthur.cappellina@telecomnancy.eu','cappellina2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Lina','CHAKROUN','lina.chakroun@telecomnancy.eu','chakroun2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Adrien','CHRISTIAËN','adrien.christiaen@telecomnancy.eu','christiaen2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Quentin','COAN','quentin.coan@telecomnancy.eu','coan2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Julien','COMBELERAN','julien.combeleran@telecomnancy.eu','combeleran2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Benjamin','CORDEBAR','benjamin.cordebar@telecomnancy.eu','cordebar2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Titouan','COUVRAT--PAILLE','titouan.couvrat-paille@telecomnancy.eu','couvrat4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Kieran','DALIGAUD','kiean.daligaud@telecomnancy.eu','daligaud2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Lana','DAMIENS','lana.damiens@telecomnancy.eu','damiens8u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Gabriel','DÉCAVÉ','gabriel.decave@telecomnancy.eu','decave3u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Bastien','DELHAYE','bastien.delhaye@telecomnancy.eu','delhaye3u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Aurélie','DEMURE','aurelie.demure@telecomnancy.eu','demure2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Augustin','DESBOIS','augustin.desbois@telecomnancy.eu','desbois6u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Paul','DEVEAUX','paul.deveaux@telecomnancy.eu','deveaux3u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Théo','DEYGAS','theo.deygas@telecomnancy.eu','deygas2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Adrien','DIDON','adrien.didon@telecomnancy.eu','didon4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Yann','DIONISIO','yann.dionisio@telecomnancy.eu','dionisio2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Alexandre','DUCHESNE','alexandre.duchesne@telecomnancy.eu','duchesne7u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Aristide','DUHEM','aristide.duhem@telecomnancy.eu','duhem2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Romain','DUPRE','romain.dupre@telecomnancy.eu','dupre9u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Hajar','ELMADDAH','hajar.elmaddah@telecomnancy.eu','elmaddah2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Nicolas','FERNANDEZ','nicolas.fernandez@telecomnancy.eu','fernandez8u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Louis','FERRY','louis.ferry@telecomnancy.eu','ferry6u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Julie','FONDRAT','julie.fondrat@telecomnancy.eu','fondrat4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Léo','FORNOFF','leo.fornoff@telecomnancy.eu','fornoff2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Antonin','FREY','antonin.frey@telecomnancy.eu','frey5u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Anna','GALKOWSKI','anna.galkowski@telecomnancy.eu','galkowski2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Léo','GERMAIN','leo.germain@telecomnancy.eu','germain2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Matthias','GERMAIN','matthias.germain@telecomnancy.eu','germain3u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Thomas','GIANELLI','thomas.gianelli@telecomnancy.eu','gianelli2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Aurélien','GINDRE','aurelien.gindre@telecomnancy.eu','gindre2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Arthur','GÔMES','arthur.gomes@telecomnancy.eu','gomes2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Florian','GONÇALVES','florian.goncalves@telecomnancy.eu','goncalves5u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Ugo','GOSSO','hugo.gosso@telecomnancy.eu','gosso6u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Gabin','GRANJON','gabin.granjon@telecomnancy.eu','granjon2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('David','GUICHARD','david.guichard@telecomnancy.eu','guichard8u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Calvin','GUILLEMET','calvin.guillemet@telecomnancy.eu','guillemet3u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Pierre','GUYOT','pierre.guyot@telecomnancy.eu','guyot4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Amine','HARADJ','amine.haradj@telecomancy.eu','haradj3u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Meyssam','HNID','meyssam.hnid@telecomnancy.eu','hnid2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Theo','HORNBERGER','theo.hornberger@telecomnancy.eu','hornberger2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Christophe','HOYAU','christophe.hoyau@telecomnancy.eu','hoyau2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Pierre-Yves','JACQUIER','pierre-yves.jacquier@telecomnancy.eu','jacquier8u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Thomas','JEANJACQUOT','thomas.jeanjacquot@telecomnancy.eu','jeanjacquot2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Maëlle','JUILLIOT','maelle.juilliot@telecomnancy.eu','maelle.juilliot2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Orneil Serges','KONAN','serges-orneil.konan@telecomnancy.eu','konan3u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Arnaud','KRAFFT','arnaud.krafft@telecomnancy.eu','krafft2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Thomas','LACROIX','thomas.lacroix@telecomnancy.eu','lacroix4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Louis','LANG','louis.lang@telecomnancy.eu','lang7u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Pierre-Louis','LANG','pierre-louis.lang@telecomnancy.eu','lang8u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Titouan','LANGLAIS','titouan.langlais@telecomnancy.eu','langlais8u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Amandine','LAPIQUE--FAVRE','amandine.lapique--favre@telecomnancy.eu','lapique9u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Adrien','LAROUSSE','adrien.larousse@telecomnancy.eu','larousse6u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Lucas','LAURENT','lucas.laurent@telecomnancy.eu','laurent12u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Alexandre','LE FOLL','alexandre.le-foll@telecomnancy.eu','le-foll6u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Manon','LECUBIN','manon.lecubin@telecomanncy.eu','lecubin4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Corentin','LEFFONDRE','corentin.leffondre@telecomnancy.eu','leffondre4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Chad','LEPECUCHELLE','chad.lepecuchelle@telecomnancy.eu','lepecuchelle2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Thomas','LERUEZ','thomas.leruez@telecomnancy.eu','leruez2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Victor','LEVREL','victor.levrel@telecomnancy.eu','levrel2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Thibaud','LIMBACH','thibaud.limbach@telecomnancy.eu','limbache4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('El Hadji Malick','LO','El-Hadji-Malick.Lo@telecomnancy.eu','lo7u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Mathis','MANGOLD','mathis.mangold@telecomnancy.eu','mangold4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Alexis','MARCEL','alexis.marcel@telecomnancy.eu','marcel11u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Rayan','MARRADO','rayan.marrado@telecomnancy.eu','marrado4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Antonin','MASSART','antonin.massart@telecomnancy.eu','massart4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Jérémi','MENTEC','jeremi.mentec@telecomnancy.eu','mentec5u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Stanislas','MEZUREUX','stanislas.mezureux@telecomnancy.eu','mezureux6u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Xavier','MONARD','xavier.monard@telecomnancy.eu','monard5u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Célestin','MOREL','celestin.morel@telecomnancy.eu','morel14u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Massimiliano','MORTAIGNE','massimiliano.mortaigne@telecomnancy.eu','mortaigne4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Kélian','MOY','kelian.moy@telecomnancy.eu','moy4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Alexis','MUNCH','alexis.munch@telecomnancy.eu','munch6u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Elise','NEŸENS','elise.neyens@telecomnancy.eu','neyens2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Thanh An','NGUYEN','thanh-an.nguyen@telecomnancy.eu','nguyen18u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Nour','NSIRI','nour.nsiri@telecomnancy.eu','nsiri9u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('David','ORZECHOWSKI','david.ORZECHOWSKI@telecomnancy.eu','orzechowski2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Yannis','OUAKRIM','yannis.ouakrim@telecomnancy.eu','ouakrim6u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Ilyes','OUANEZAR','ilyes.ouanezar@telecomnancy.eu','ouanezar4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Thomas','PERNIN','thomas.pernin@telecomnancy.eu','pernin7u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Mathéo','ROBERT','matheo.robert@telecomnancy.eu','robert14u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Aymeric','ROUSSEL','aymeric.roussel@telecomnancy.eu','roussel9u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Theo','ROVILLO','theo.rovillo@telecomnancy.eu','rovillo5u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Romain','SAMBA','romain.samba@telecomnancy.eu','samba5u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Lili','SCHMIDLIN','lili.schmidlin@telecomnancy.eu','schmidlin4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Chahrazad','SEHRANI','Chahrazad.sehrani@telecomnancy.eu','sehrani4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Noa','SÉNÉSI','noa.senesi@telecomnancy.eu','senesi4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Maxime','SOLDATOV','maxime.soldatov@telecomnancy.eu','soldatov2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Noe','STEINER','noe.steiner@telecomnancy.eu','steiner5u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Terry','TEMPESTINI','terry.tempestini@telecomnancy.eu','tempestini4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Clément','TEXIER','clement.texier@telecomnancy.eu','texier8u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Hugo','THEVENIN','hugo.thevenin@telecomnancy.eu','thevenin7u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Killian','THUILLIER','killian.thuillier@telecomnancy.eu','thuillier4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Maelan','TIGER','maelan.tiger@telecomnancy.eu','tiger4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Ahtisham','TOOR','Ahtisham.toor@telecomnancy.eu','toor3u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Cosimo','UNGARO','cosimo.ungaro@telecomnancy.eu','ungaro4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Abel','VAGNE','abel.vagne@telecomnancy.eu','vagne6u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Erwan','VAILLANT','erwan.vaillant@telecomnancy.eu','vaillant6u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Etienne','VATRY','etienne.vatry@telecomnancy.eu','vatry4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Léo','VESSE','leo.vesse@telecomnancy.eu','vesse2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Victor','VOISIN','victor.voison@telecomnancy.eu','voisin6u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Sirielle','WALTER','sirielle.walter@telecomnancy.eu','walter4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Théo','WALTER','theo.walter@telecomnancy.eu','walter5u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Michaël','YANG','michael.yang@telecomnancy.eu','yang6u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Julie','ZHEN','julie.zhen@telecomnancy.eu','zhen4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Alex','ZHOU','alex.zhou@telecomnancy.eu','zhou6u','fise');
insert into students(firstname,lastname,email,uid_ul,formation ) values ('Lucas','ZORMAN','lucas.zorman@telecomnancy.eu','zorman3u','fise');

insert into students(firstname,lastname,email,uid_ul,formation) values ('Gautier','BERTRAND','gautier.Bertrand@telecomnancy.eu','bertrand6u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Damien','BURST','damien.Burst@telecomnancy.eu','burst2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Gabin','CHASSARD','gabin.Chassard@telecomnancy.eu','chassard4u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Louis','COURRIER','louis.Courrier@telecomnancy.eu','courrier2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Aurelien','FRANCOIS','aurelien.Francois@telecomnancy.eu','francois7u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Clément','GEHIN'	,'clement.Gehin@telecomnancy.eu','gehin4u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Leopold','HENRY','leopold.Henry@telecomnancy.eu','henry12u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Romain','HERBIN','romain.Herbin@telecomnancy.eu','herbin4u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Robin','KREROWICZ','robin.Krerowicz@telecomnancy.eu','krerowicz2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Hugo','LOISEAU','hugo.loiseau@telecomnancy.eu','loiseau4u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Romain','NATANELIC','romain.natanelic@telecomnancy.eu','natanelic2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Nicolas','RENARD','nicolas.renard@telecomnancy.eu','renard6u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Baptiste','ROBERT','Baptiste.Robert@telecomnancy.eu','robert10u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Emmanuel','SEVELEDER','emmanuel.seveleder@telecomnancy.eu','seveleder2u','fisa');

----2A----
insert into students(firstname,lastname,email,uid_ul,formation) values ('Sangoan','BRIGUE','sangoan.brigue@telecomnancy.eu','brigue4u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Lucas','TABBONE','lucas.tabbone@telecomnancy.eu','tabbone4u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Baptiste','BRULLARD','baptiste.brullard@telecomnancy.eu','brullard4u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Rémy','HENEAUX','remy.heneaux@telecomnancy.eu','heneaux4u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Arthur','DUHOUX','arthur.duhoux@telecomnancy.eu','duhoux4u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Maxime','ISTACE','maxime.istace@telecomnancy.eu','istace2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Romain','DEFRANOUX','romain.defranoux@telecomnancy.eu','defranoux2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Antoine','CHAMPAULT','antoine.champault@telecomnancy.eu','champault4u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Rémi','MARSAL','remi.marsal@telecomnancy.eu','marsal2u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Joshua','TETON','joshua.teton@telecomnancy.eu','teton4u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Alexandra','DEMSKI','alexandra.demski@telecomnancy.eu','demski4u','fisa');

insert into students(firstname,lastname,email,uid_ul,formation) values ('Léo','ALONZO','leo.alonzo@telecomnancy.eu','alonzo7u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Norman','ASSING','norman.assing@telecomnancy.eu','assing5u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Oceane','AVILA','oceane.avila@telecomnancy.eu','avila4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Mathilde','BARD','mathilde.bard@telecomnancy.eu','bard4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Adrien','BASCHUNG','adrien.baschung@telecomnancy.eu','baschung4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Albert','BECQUET','Albert.Becquet@telecomnancy.eu','becquet7u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Thomas','PALLET','thomas.pallet@telecomnancy.eu','pallet4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Tristan','SMAGGHE','tristan.smagghe@telecomnancy.eu','smagghe2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Lucie','BOUCHER','lucie.boucher@telecomnancy.eu','boucher3u','fise');

----3A----
insert into students(firstname,lastname,email,uid_ul,formation) values ('Hamza','ABDOULHOUSSEN','hamza.abdoulhoussen@telecomnancy.eu','abdoulhoussen4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Kamal','ALLOUCHE','kamal.allouche@telecomnancy.eu','allouche4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('yohann','AMOSSE','yohann.amosse@telecomnancy.eu','amosse5u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Paul','ANTONI','paul.antoni@telecomancy.eu','antoni5u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Yonah','BACK','yonah.back@telecomnancy.eu','back7u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Rachel','BACZYNSKI','rachel.baczynski@telecomnancy.eu','baczynski4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Tommy','BARAFANI','tommy.barafani@telecomnancy.eu','barafani5u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Nicolas','BEAUDOUIN','nicolas.beaudouin@telecomnancy.eu','beaudouin6u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Chloe','BERNARDET','chloe.bernardet@telecomnancy.eu','bernardet4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Thais','BERNARDI','thais.bernardi@telecomnancy.eu','bernardi4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Elisa','BONIFAS','elisa.bonifas@telecomnancy.eu','bonifas7u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Adrien','BONTEMS','adrien.bontems@telecomnancy.eu','bontemps2u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Baptiste','BOUDOU','baptiste.boudou@telecomnancy.eu','boudou6u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Sami','BOULECHFAR','sami.boulechfar@telecomnancy.eu','boulechfar4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Anthony','BRIAN','anthony.brian@telecomnancy.eu','brian4u','fise');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Tara','BRIDIER','tara.bridier@telecomnancy.eu','bridier4u','fise');

insert into students(firstname,lastname,email,uid_ul,formation) values ('Théo','PONCHON','theo.ponchon@telecomnancy.eu','ponchon4u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Julien','NOEL','julien.noel@telecomnancy.eu','noel7u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Antoine','PINSTON','antoine.pinston@telecomnancy.eu','pinston4u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Lisa','RAMLOT','lisa.ramlot@telecomnancy.eu','ramlot4u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Sacha','CUENOT','sachat.cuenot@telecomnancy.eu','cuenot4u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Hugo','BLAISON','hugo.blaison@telecomnancy.eu','blaison4u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Loan','HELLER','loan.heller@telecomnancy.eu','heller4u','fisa');
insert into students(firstname,lastname,email,uid_ul,formation) values ('Kelyan','MARCHAL','kelyan.marchal@telecomnancy.eu','marchal6u','fisa');


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


------USERS-------
insert into users(firstname,lastname,uid_ul,password,email,picture, id_gitlab) values ('Sebastien','DaSilva','dasilva1','$2b$12$E4SYFlb7eVIugvCGsM07nekREmVqffiHX9P4lURnIhTljxJ9LVqhy','sebastien.dasilva@telecomnancy.eu','', 264);
insert into users(firstname,lastname,uid_ul,password,email,picture, id_gitlab) values ('Olivier','Festor','festor1','$2b$12$E4SYFlb7eVIugvCGsM07nekREmVqffiHX9P4lURnIhTljxJ9LVqhy','olvier.festor@telecomnancy.eu','', 3);
insert into users(firstname,lastname,uid_ul,password,email,picture, id_gitlab) values ('Gerald','Oster','oster1','$2b$12$E4SYFlb7eVIugvCGsM07nekREmVqffiHX9P4lURnIhTljxJ9LVqhy','gerald.oster@telecomnancy.eu','',6);
insert into users(firstname,lastname,uid_ul,password,email,picture, id_gitlab) values ('Christophe','Bouthier','bouthier1','$2b$12$E4SYFlb7eVIugvCGsM07nekREmVqffiHX9P4lURnIhTljxJ9LVqhy','christophe.bouthier@telecomnancy.eu','',2);
insert into users(firstname,lastname,uid_ul,password,email,picture, id_gitlab) values ('Thibault','Cholez','cholez1','$2b$12$E4SYFlb7eVIugvCGsM07nekREmVqffiHX9P4lURnIhTljxJ9LVqhy','thibault.cholez@telecomnancy.eu','',9);

insert into users(firstname,lastname,uid_ul,password,email,picture, id_gitlab) values ('Lucas','Tabbone','tabbone4u','$2b$12$E4SYFlb7eVIugvCGsM07nekREmVqffiHX9P4lURnIhTljxJ9LVqhy','lucas.tabbone@telecomnancy.eu','', 1046);
insert into users(firstname,lastname,uid_ul,password,email,picture, id_gitlab) values ('Baptiste','Brullard','brullard4u','$2b$12$E4SYFlb7eVIugvCGsM07nekREmVqffiHX9P4lURnIhTljxJ9LVqhy','baptiste.brullard@telecomnancy.eu','', 1057);
insert into users(firstname,lastname,uid_ul,password,email,picture, id_gitlab) values ('Sangoan','Brigue','brigue4u','$2b$12$E4SYFlb7eVIugvCGsM07nekREmVqffiHX9P4lURnIhTljxJ9LVqhy','sangoan.brigue@telecomnancy.eu','', 1044);
insert into users(firstname,lastname,uid_ul,password,email,picture, id_gitlab) values ('Arthur','Duhoux','duhoux4u','$2b$12$E4SYFlb7eVIugvCGsM07nekREmVqffiHX9P4lURnIhTljxJ9LVqhy','arthur.duhoux@telecomnancy.eu','', 1048);
insert into users(firstname,lastname,uid_ul,password,email,picture, id_gitlab) values ('Maxime','Istace','istace2u','$2b$12$E4SYFlb7eVIugvCGsM07nekREmVqffiHX9P4lURnIhTljxJ9LVqhy','maxime.istace@telecomnancy.eu','', 1066);
insert into users(firstname,lastname,uid_ul,password,email,picture, id_gitlab) values ('Rémy','Heneaux','heneaux4u','$2b$12$E4SYFlb7eVIugvCGsM07nekREmVqffiHX9P4lURnIhTljxJ9LVqhy','remy.heneaux@telecomnancy.eu','', 1060);

-------ROLES-------
insert into  roles(label_role, display_role) values ('teacher', 'Enseignant');
insert into  roles(label_role, display_role) values ('administrator', 'Administrateur');


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

------student_class_group-------
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