BEGIN;
DROP TYPE IF EXISTS mecz_rodzaj cascade;
DROP TABLE IF EXISTS sektory cascade;
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

COMMIT;
