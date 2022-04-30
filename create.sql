BEGIN;

DROP TABLE IF EXISTS sektory cascade;
DROP TYPE IF EXISTS mecz_rodzaj cascade;
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
  nazwa varchar(6) UNIQUE NOT NULL,
  sektor_gosci boolean NOT NULL
);

CREATE TYPE mecz_rodzaj AS ENUM ('liga', 'puchar', 'puchar_eu');

CREATE TABLE mecze(
  id integer PRIMARY KEY generated always as identity,
  przeciwnik varchar(20) NOT NULL,
  "data" date UNIQUE NOT NULL,
  rodzaj_meczu mecz_rodzaj NOT NULL,
  sezon date NOT NULL,
  CONSTRAINT przeciwnik_sezon UNIQUE (przeciwnik, sezon, rodzaj_meczu),
  CONSTRAINT data_sezon CHECK("data">sezon)
)
;

CREATE TABLE bilety_ceny(
  id int PRIMARY KEY generated always as identity,
  id_sektor integer REFERENCES sektory(id) NOT NULL,
  rodzaj_meczu mecz_rodzaj NOT NULL,
  cena numeric(5, 2) NOT NULL,
  sezon_zmiany date NOT NULL
)
;

CREATE TABLE kibice(
  id integer PRIMARY KEY generated always as identity,
  imie varchar(20) NOT NULL,
  nazwisko varchar(25) NOT NULL,
  pesel char(11) UNIQUE NOT NULL
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
  nazwa varchar(30) UNIQUE NOT NULL
)
;

CREATE TABLE fancluby_kibice(
  id_kibica integer REFERENCES kibice(id),
  id_fanclubu integer REFERENCES fancluby(id),
  PRIMARY KEY(id_kibica, id_fanclubu)
)
;

CREATE TABLE karnety_ceny(
  id integer PRIMARY KEY generated always as identity,
  id_sektor integer REFERENCES sektory(id) NOT NULL,
  pierwsza_runda boolean NOT NULL,
  druga_runda boolean NOT NULL, 
  cena numeric(5,2) NOT NULL,
  sezon_zmiany date NOT NULL
)
;

CREATE TABLE karnety(
  id integer PRIMARY KEY generated always as identity,
  id_kibica integer REFERENCES kibice(id) NOT NULL,
  pierwsza_runda boolean NOT NULL,
  druga_runda boolean NOT NULL,
  sezon date NOT NULL,
  id_sektor smallint REFERENCES sektory(id) NOT NULL,
  rzad smallint NOT NULL,
  miejsce smallint NOT NULL,
  CONSTRAINT unique_kibic_runda1 UNIQUE(id_kibica, pierwsza_runda, sezon),
  CONSTRAINT unique_kibic_runda2 UNIQUE(id_kibica, druga_runda, sezon),
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
  id integer PRIMARY KEY generated always as identity,
  id_sektora smallint REFERENCES sektory(id) NOT NULL,
  opis varchar(100) NOT NULL,
  data_od date NOT NULL,
  data_do date CHECK(data_do>data_od) NOT NULL
)
;

CREATE TABLE kibice_restrykcje(
  id integer PRIMARY KEY generated always as identity,
  id_kibica integer REFERENCES kibice(id) NOT NULL,
  opis varchar(100),
  data_od date NOT NULL,
  data_do date NOT NULL
  CONSTRAINT duration_positive CHECK(data_od<data_do)
)
;

CREATE TABLE sektory_rzedy(
  id_sektor smallint REFERENCES sektory(id),
  rzad smallint,
  liczba_miejsc smallint NOT NULL,
  PRIMARY KEY(id_sektor, rzad)
)
;

COMMIT;
