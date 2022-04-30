BEGIN;

DROP TABLE IF EXISTS sektory cascade;
DROP TYPE IF EXISTS rodzaj_meczu cascade;
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
  id smallint PRIMARY KEY generated always as identity,
  nazwa varchar(6) UNIQUE,
  sektor_gosci boolean
);

CREATE TYPE rodzaj_meczu AS ENUM ('liga', 'puchar', 'puchar_eu');

CREATE TABLE mecze(
  id integer PRIMARY KEY generated always as identity,
  przeciwnik varchar(20),
  "data" date UNIQUE,
  rodzaj rodzaj_meczu,
  sezon date,
  CONSTRAINT przeciwnik_sezon UNIQUE (przeciwnik, sezon, rodzaj)
)
;

CREATE TABLE bilety_ceny(
  id_sektor integer REFERENCES sektory(id),
  rodzaj rodzaj_meczu,
  cena numeric(5, 2),
  sezon_zmiany date,
  PRIMARY KEY(id_sektor, rodzaj, sezon_zmiany)
)
;

CREATE TABLE kibice(
  id integer PRIMARY KEY generated always as identity,
  imie varchar(20),
  nazwisko varchar(25),
  pesel char(11) UNIQUE
)
;

CREATE TABLE bilety(
  id_kibica integer REFERENCES kibice(id),
  id_meczu integer REFERENCES mecze(id),
  id_sektor integer REFERENCES sektory(id),
  rzad smallint,
  miejsce smallint,
  PRIMARY KEY(id_kibica, id_meczu),
  CONSTRAINT unique_miejsce UNIQUE(id_meczu, id_sektor, rzad, miejsce),
  CONSTRAINT unique_kibice UNIQUE(id_kibica, id_meczu)
)
;

CREATE TABLE fancluby(
  id integer PRIMARY KEY generated always as identity,
  nazwa varchar(30) UNIQUE
)
;

CREATE TABLE fancluby_kibice(
  id_kibica integer REFERENCES kibice(id),
  id_fanclubu integer REFERENCES fancluby(id),
  PRIMARY KEY(id_kibica, id_fanclubu)
)
;

CREATE TABLE karnety_ceny(
  id_sektor integer REFERENCES sektory(id),
  pierwsza_runda boolean,
  druga_runda boolean, 
  cena numeric(5,2),
  sezon_zmiany date
)
;

CREATE TABLE karnety(
  id integer PRIMARY KEY generated always as identity,
  id_kibica integer REFERENCES kibice(id),
  pierwsza_runda boolean,
  druga_runda boolean,
  sezon date,
  id_sektor smallint REFERENCES sektory(id),
  rzad smallint,
  miejsce smallint,
  CONSTRAINT unique_kibic UNIQUE(id_kibica, pierwsza_runda, druga_runda, sezon),
  CONSTRAINT unique_miejsce_k UNIQUE(pierwsza_runda, druga_runda, sezon, id_sektor, rzad, miejsce)
)
;

CREATE TABLE zwolnione_karnety(
  id_karnetu integer REFERENCES karnety(id),
  id_meczu integer REFERENCES mecze(id),
  PRIMARY KEY (id_karnetu, id_meczu)
)
;

CREATE TABLE sektory_restrykcje(
  id_sektora smallint REFERENCES sektory(id),
  opis varchar(100),
  data_od date,
  data_do date CHECK(data_do>data_od),
  PRIMARY KEY(id_sektora, data_od, data_do)
)
;

CREATE TABLE kibice_restrykcje(
  id_kibica integer REFERENCES kibice(id),
  opis varchar(100),
  data_od date,
  data_do date
)
;

CREATE TABLE sektory_rzedy(
  id_sektor smallint REFERENCES sektory(id),
  rzad smallint,
  liczba_miejsc smallint
)
;

COMMIT;
