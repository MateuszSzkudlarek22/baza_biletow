BEGIN;

DROP TABLE IF EXISTS sektory cascade;
DROP TABLE IF EXISTS mecze_rodzaje cascade;
DROP TABLE IF EXISTS mecze cascade;
DROP TABLE IF EXISTS bilety_ceny cascade;
DROP TABLE IF EXISTS kibice cascade;
DROP TABLE IF EXISTS bilety cascade;
DROP TABLE IF EXISTS fancluby cascade;
DROP TABLE IF EXISTS fancluby_kibice cascade;
DROP TABLE IF EXISTS karnety_ceny cascade;
DROP TABLE IF EXISTS karnety cascade;
DROP TABLE IF EXISTS zwolnione_karnety cascade;
DROP TABLE IF EXISTS sektory_restrykcje cascade;
DROP TABLE IF EXISTS kibice_restrykcje cascade;
DROP TABLE IF EXISTS sektory_rzedy cascade;


CREATE TABLE sektory (
  id numeric(6,0) PRIMARY KEY,
  nazwa varchar(6) UNIQUE,
  sektor_gosci boolean
);

CREATE TABLE mecze_rodzaje(
  id numeric(1) PRIMARY KEY,
  opis varchar(10) CHECK(opis IN ('liga', 'puchar', 'puchar_eu'))
)
;

CREATE TABLE mecze(
  id numeric PRIMARY KEY,
  przeciwnik varchar(20),
  "data" date UNIQUE,
  id_rodzaj numeric REFERENCES mecze_rodzaje (id),
  sezon date,
  CONSTRAINT przeciwnik_sezon UNIQUE (przeciwnik, sezon, id_rodzaj)
)
;

CREATE TABLE bilety_ceny(
  id_sektor numeric REFERENCES sektory(id),
  id_rodzaj numeric REFERENCES mecze_rodzaje(id),
  cena numeric(5, 2),
  sezon_zmiany date,
  PRIMARY KEY(id_sektor, id_rodzaj, sezon_zmiany)
)
;

CREATE TABLE kibice(
  id numeric PRIMARY KEY,
  imie varchar(20),
  nazwisko varchar(25),
  pesel numeric UNIQUE
)
;

CREATE TABLE bilety(
  id_kibica numeric REFERENCES kibice(id),
  id_meczu numeric REFERENCES mecze(id),
  id_sektor numeric REFERENCES sektory(id),
  rzad numeric,
  miejsce numeric,
  PRIMARY KEY(id_kibica, id_meczu),
  CONSTRAINT unique_miejsce UNIQUE(id_meczu, id_sektor, rzad, miejsce),
  CONSTRAINT unique_kibice UNIQUE(id_kibica, id_meczu)
)
;

CREATE TABLE fancluby(
  id numeric PRIMARY KEY,
  nazwa varchar(30) UNIQUE
)
;

CREATE TABLE fancluby_kibice(
  id_kibica numeric REFERENCES kibice(id),
  id_fanclubu numeric REFERENCES fancluby(id),
  PRIMARY KEY(id_kibica, id_fanclubu)
)
;

CREATE TABLE karnety_ceny(
  id_sektor numeric REFERENCES sektory(id),
  pierwsza_runda boolean,
  druga_runda boolean, 
  cena numeric(5,2),
  sezon_zmiany date
)
;

CREATE TABLE karnety(
  id numeric PRIMARY KEY,
  id_kibica numeric REFERENCES kibice(id),
  pierwsza_runda boolean,
  druga_runda boolean,
  sezon date,
  id_sektor numeric REFERENCES sektory(id),
  rzad numeric(2),
  miejsce numeric(2),
  CONSTRAINT unique_kibic UNIQUE(id_kibica, pierwsza_runda, druga_runda, sezon),
  CONSTRAINT unique_miejsce_k UNIQUE(pierwsza_runda, druga_runda, sezon, id_sektor, rzad, miejsce)
)
;

CREATE TABLE zwolnione_karnety(
  id_karnetu numeric REFERENCES karnety(id),
  id_meczu numeric REFERENCES mecze(id),
  PRIMARY KEY (id_karnetu, id_meczu)
)
;

CREATE TABLE sektory_restrykcje(
  id_sektoru numeric REFERENCES sektory(id),
  opis varchar(100),
  data_od date,
  data_do date CHECK(data_do>data_od),
  PRIMARY KEY(id_sektoru, data_od, data_do)
)
;

CREATE TABLE kibice_restrykcje(
  id_kibica numeric REFERENCES kibice(id),
  opis varchar(100),
  data_od date,
  data_do date
)
;

CREATE TABLE sektory_rzedy(
  id_sektor numeric REFERENCES sektory(id),
  rzad numeric(2),
  liczba_miejsc numeric(2)
)
;

INSERT INTO sektory VALUES(100, 'A1', false);
INSERT INTO sektory VALUES(101, 'A2', false);
INSERT INTO sektory VALUES(102, 'A3', false);
INSERT INTO sektory VALUES(103, 'A4-vip', false);
INSERT INTO sektory VALUES(104, 'A5', false);
INSERT INTO sektory VALUES(105, 'A6', false);
INSERT INTO sektory VALUES(106, 'A7', false);
INSERT INTO sektory VALUES(107, 'A8', false);
INSERT INTO sektory VALUES(200, 'B1', false);
INSERT INTO sektory VALUES(201, 'B2', false);
INSERT INTO sektory VALUES(202, 'B3', false);
INSERT INTO sektory VALUES(203, 'B4', true);
INSERT INTO sektory VALUES(204, 'B5', true);
INSERT INTO sektory VALUES(300, 'C1', false);
INSERT INTO sektory VALUES(301, 'C2', false);
INSERT INTO sektory VALUES(302, 'C3', false);
INSERT INTO sektory VALUES(303, 'C4', false);
INSERT INTO sektory VALUES(304, 'C5', false);
INSERT INTO sektory VALUES(305, 'C6', false);
INSERT INTO sektory VALUES(306, 'C7', false);
INSERT INTO sektory VALUES(307, 'C8', false);
INSERT INTO sektory VALUES(400, 'D1', false);
INSERT INTO sektory VALUES(401, 'D2', false);
INSERT INTO sektory VALUES(402, 'D3', false);
INSERT INTO sektory VALUES(403, 'D4', false);

INSERT INTO mecze_rodzaje VALUES(1, 'liga');
INSERT INTO mecze_rodzaje VALUES(2, 'puchar');
INSERT INTO mecze_rodzaje VALUES(3, 'puchar_eu');

INSERT INTO mecze VALUES(1, 'Sandecja Nowy Sącz', '2021-08-1', 1, '2021-07-1');
INSERT INTO mecze VALUES(2, 'Chrobry Głogów', '2021-08-15', 1, '2021-07-1');
INSERT INTO mecze VALUES(3, 'Stomil Olsztyn', '2021-08-21', 1, '2021-07-1');
INSERT INTO mecze VALUES(4, 'Górnik Polkowice', '2021-08-28', 1, '2021-07-1');
INSERT INTO mecze VALUES(5, 'GKS Katowice', '2021-09-10', 1, '2021-07-1');
INSERT INTO mecze VALUES(6, 'Skra Częstochowa', '2021-09-24', 1, '2021-07-01');
INSERT INTO mecze VALUES(7, 'GKS Jastrzębie Zdrój', '2021-10-10', 1, '2021-07-1');
INSERT INTO mecze VALUES(8, 'ŁKS Łódź', '2021-10-24', 1, '2021-07-1');
INSERT INTO mecze VALUES(9, 'Miedź Legnica', '2021-11-4', 1, '2021-07-1');
INSERT INTO mecze VALUES(10, 'Zagłębie Sosnowiec', '2021-11-28', 1, '2021-07-1');
INSERT INTO mecze VALUES(11, 'Arka Gdynia', '2022-02-25', 1, '2021-07-1');
INSERT INTO mecze VALUES(12, 'Odra Opole', '2022-03-18', 1, '2021-07-1');
INSERT INTO mecze VALUES(13, 'GKS Tychy', '3-04-2022', 1, '2021-07-1');
INSERT INTO mecze VALUES(14, 'Puszcza Niepołomice', '2022-04-16', 1, '2021-07-1');
INSERT INTO mecze VALUES(15, 'Korona Kielce', '2022-04-26', 1, '2021-07-1');
INSERT INTO mecze VALUES(16, 'GKS Jastrzębie Zdrój', '2021-11-2', 2, '2021-07-1');
INSERT INTO mecze VALUES(17, 'Wisła Kraków', '2021-12-2', 2, '2021-07-1');
INSERT INTO mecze VALUES(18, 'ŁKS Łódź', '2020-09-6', 1, '2020-07-1');
INSERT INTO mecze VALUES(19, 'Stomil Olsztyn', '2018-09-19', 1, '2018-07-1');
INSERT INTO mecze VALUES(20, 'Sparta Praga', '2019-08-12', 3, '2019-07-1');

INSERT INTO bilety_ceny VALUES(100, 1, 12.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(100, 2, 20.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(101, 1, 12.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(101, 2, 22.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(102, 1, 20.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(102, 2, 32.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(103, 1, 20.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(103, 2, 32.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(104, 1, 22.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(104, 2, 24.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(105, 1, 22.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(105, 2, 32.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(106, 1, 17.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(106, 2, 19.90, '2019-07-01');
INSERT INTO bilety_ceny VALUES(107, 1, 12.90, '2019-07-01');
INSERT INTO bilety_ceny VALUES(107, 2, 20.90, '2018-01-01');
INSERT INTO bilety_ceny VALUES(200, 1, 10.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(200, 2, 12.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(201, 1, 14.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(201, 2, 16.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(202, 1, 10.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(202, 2, 18.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(202, 3, 58.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(203, 1, 90.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(203, 2, 120.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(203, 3, 300.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(204, 1, 90.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(204, 2, 120.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(204, 3, 300.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(302, 1, 10.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(302, 2, 15.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(302, 3, 20.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(303, 1, 13.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(303, 2, 17.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(303, 3, 20.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(304, 1, 22.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(304, 2, 25.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(304, 3, 28.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(305, 1, 17.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(305, 2, 19.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(305, 3, 24.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(306, 1, 9.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(306, 2, 12.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(306, 3, 15.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(307, 1, 22.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(307, 2, 25.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(307, 3, 27.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(300, 1, 28.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(300, 2, 30.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(300, 3, 33.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(301, 1, 20.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(301, 2, 21.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(301, 3, 22.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(400, 1, 10.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(400, 2, 12.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(400, 3, 14.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(401, 1, 15.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(401, 2, 17.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(401, 3, 19.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(402, 1, 22.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(402, 2, 24.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(402, 3, 27.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(403, 1, 26.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(403, 2, 21.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(403, 3, 32.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(100, 3, 29.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(101, 3, 49.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(102, 3, 37.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(103, 3, 39.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(104, 3, 50.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(105, 3, 69.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(106, 3, 20.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(107, 3, 29.90, '2018-07-01');
INSERT INTO bilety_ceny VALUES(102, 2, 30.90, '2021-01-01');
INSERT INTO bilety_ceny VALUES(200, 1, 25.90, '2021-07-01');

INSERT INTO fancluby VALUES(1, 'Fan Club Piotrków Trybunalsk');
INSERT INTO fancluby VALUES(2, 'Fan Club Łódź Wschód' );
INSERT INTO fancluby VALUES(3, 'Fan Club Stary Widzew' );
INSERT INTO fancluby VALUES(4, 'Fan Club Bałuty' );
INSERT INTO fancluby VALUES(5, 'Fan Club Śródmieście');
INSERT INTO fancluby VALUES(6, 'Fan Club Aleksandrów Łódzki');
INSERT INTO fancluby VALUES(7, 'Fan Club Konstantynów Łódzki');
INSERT INTO fancluby VALUES(8, 'Fan Club Końskie');
INSERT INTO fancluby VALUES(9, 'Fan Club Skierniewice');
INSERT INTO fancluby VALUES(10, 'Fan Club Żyrardów');
INSERT INTO fancluby VALUES(11, 'Fan Club Stryków');
INSERT INTO fancluby VALUES(12, 'Czerwone Opoczno');
INSERT INTO fancluby VALUES(13, 'Fan Club Sulejów' );
INSERT INTO fancluby VALUES(14, 'Fan Club Będków');
INSERT INTO fancluby VALUES(15, 'Fan Club Zgierz');
INSERT INTO fancluby VALUES(16, 'Fan Club Skarżysko-Kamienna');
INSERT INTO fancluby VALUES(17, 'Fan Club Kraków');
INSERT INTO fancluby VALUES(18, 'Fan Club Bełchatów');
INSERT INTO fancluby VALUES(19, 'Fan Club Łowicz');

INSERT INTO karnety_ceny VALUES(100, true, false, 180.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(100, false, true, 220.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(100, true, true, 370.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(101, true, false, 170.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(101, false, true, 210.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(101, true, true, 350.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(102, true, false, 200.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(102, false, true, 220.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(102, true, true, 400.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(103, true, false, 180.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(103, false, true, 200.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(103, true, true, 360.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(104, true, false, 150.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(104, false, true, 170.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(104, true, true, 300.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(105, true, false, 220.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(105, false, true, 250.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(105, true, true, 430.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(106, true, false, 180.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(106, false, true, 200.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(106, true, true, 360.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(107, true, false, 200.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(107, false, true, 230.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(107, true, true, 400.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(200, true, false, 170.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(200, false, true, 200.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(200, true, true, 350.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(201, true, false, 100.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(201, false, true, 120.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(201, true, true, 300.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(202, true, false, 280.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(202, false, true, 300.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(202, true, true, 500.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(300, true, false, 200.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(300, false, true, 200.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(300, true, true, 330.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(301, true, false, 170.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(301, false, true, 180.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(301, true, true, 330.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(302, true, false, 230.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(302, false, true, 250.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(302, true, true, 450.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(303, true, false, 200.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(303, false, true, 180.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(303, true, true, 350.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(304, true, false, 180.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(304, false, true, 200.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(304, true, true, 350.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(305, true, false, 170.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(305, false, true, 200.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(305, true, true, 350.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(306, true, false, 100.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(306, false, true, 120.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(306, true, true, 150.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(400, true, false, 200.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(400, false, true, 170.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(400, true, true, 330.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(401, true, false, 140.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(401, false, true, 160.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(401, true, true, 250.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(402, true, false, 200.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(402, false, true, 230.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(402, true, true, 400.90, '2018-07-01' );
INSERT INTO karnety_ceny VALUES(102, true, true, 380.90, '2020-07-01');
INSERT INTO karnety_ceny VALUES(103, true, false, 80.90, '2020-07-01');

INSERT INTO sektory_restrykcje VALUES(100, 'Kara za użycie pirotechniki podczas meczu z ŁKS-em Łódź 24-10-2021', '2021-10-27', '2021-12-27' );
INSERT INTO sektory_restrykcje VALUES(101, 'Kara za użycie pirotechniki podczas meczu z ŁKS-em Łódź 24-10-2021', '2021-10-27', '2021-12-27' );
INSERT INTO sektory_restrykcje VALUES(102, 'Kara za użycie pirotechniki podczas meczu z ŁKS-em Łódź 24-10-2021', '2021-10-27', '2021-12-27' );
INSERT INTO sektory_restrykcje VALUES(103, 'Kara za użycie pirotechniki podczas meczu z ŁKS-em Łódź 24-10-2021', '2021-10-27', '2021-12-27' );
INSERT INTO sektory_restrykcje VALUES(104, 'Kara za użycie pirotechniki podczas meczu z ŁKS-em Łódź 24-10-2021', '2021-10-27', '2021-12-27' );
INSERT INTO sektory_restrykcje VALUES(105, 'Kara za użycie pirotechniki podczas meczu z ŁKS-em Łódź 24-10-2021', '2021-10-27', '2021-12-27' );
INSERT INTO sektory_restrykcje VALUES(106, 'Kara za użycie pirotechniki podczas meczu z ŁKS-em Łódź 24-10-2021', '2021-10-27', '2021-12-27' );
INSERT INTO sektory_restrykcje VALUES(107, 'Kara za użycie pirotechniki podczas meczu z ŁKS-em Łódź 24-10-2021', '2021-10-27', '2021-12-27' );


