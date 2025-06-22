/*
-- CREATE DATABASE
CREATE DATABASE pemesanan_tiket_pesawat;

-- BACKUP DATABASE 
BACKUP DATABASE pemesanan_tiket_pesawat
TO DISK = 'D:\backups\pemesanan_tiket_pesawat.bak'
WITH DIFFERENTIAL; -- menyimpan semua perubahan data yang dibuat sejak pencadangan penuh terakhir

-- DROP DATABASE
DROP DATABASE pemesanan_tiket_pesawat;
*/




-- CREATE: table
CREATE TABLE pesawat (
    id_pesawat VARCHAR(5) PRIMARY KEY,
    jenis_pesawat VARCHAR(25) NOT NULL,
    merek_pesawat VARCHAR(4) NOT NULL,
    id_maskapai VARCHAR(4) NOT NULL,
    rute_penerbangan VARCHAR(25) NOT NULL
);


-- INSERT: data
INSERT INTO pesawat (id_pesawat, jenis_pesawat, merek_pesawat, id_maskapai, rute_penerbangan) VALUES
('PE001', 'MINI PASSENGER JETS', 'A220', 'M001', 'PADANG - JAKARTA'),
('PE002', 'JUMBO PASSENGER JETS', 'A350', 'M002', 'JAKARTA - BALI'),
('PE003', 'NORMAL PASSENGER JETS', 'A330', 'M003', 'BANDUNG - BALI'),
('PE004', 'NORMAL PASSENGER JETS', 'A320', 'M003', 'JAKARTA - PADANG'),
('PE005', 'JUMBO PASSENGER JETS', 'A350', 'M005', 'PADANG - PEKANBARU');
    --  SELECT: awalnya data
    SELECT * FROM pesawat;


-- ALTER: menambah kolom tabel
ALTER TABLE pesawat
ADD panjang_pesawat VARCHAR(10) default '60meter';
    -- SELECT: menambah kolom
    SELECT * FROM pesawat;


-- ALTER: mengubah nama kolomtabel
ALTER TABLE pesawat
CHANGE panjang_pesawat dimensi_panjang VARCHAR(10) default '60meter';
    -- SELECT: mengubah kolom
    SELECT * FROM pesawat;


--  ALTER: menghapus kolom tabel
ALTER TABLE pesawat
DROP COLUMN dimensi_panjang;
    -- SELECT: menambah kolom
    SELECT * FROM pesawat;


/*
-- DROP: menghapus tabel
DROP TABLE pesawat;


-- TRUNCATE: menghapus isi data tabel
TRUNCATE TABLE pesawat;
*/


-- UPDATE: ubah merek pesawat untuk penerbangan PE004
UPDATE pesawat
SET merek_pesawat = 'A321'
WHERE id_pesawat = 'PE004';
    --  SELECT: setelah di ubah
    SELECT * FROM pesawat;


-- DELETE: hapus catatan pesawat untuk penerbangan PE002
DELETE FROM pesawat
WHERE id_pesawat = 'PE002';
    --  SELECT: setelah di hapus
    SELECT * FROM pesawat;


/*
-- CREATE PROCEDURE
CREATE PROCEDURE semua_pesawat
AS
SELECT * FROM pesawat
GO;
    -- EXEC: mengeksekusi prosedur tersebut 
    EXEC semua_pesawat;


-- CREATE INDEX
CREATE INDEX idx_merek_pesawat
ON pesawat(merek_pesawat);
    -- DROP INDEX: menghapus index tersebut
    ALTER TABLE pesawat
    DROP INDEX idx_merek_pesawat;
*/


-- CREATE VIEW
CREATE VIEW pesawat_jumbo AS
SELECT * FROM pesawat
WHERE jenis_pesawat = 'JUMBO PASSENGER JETS';
    -- SELECT: menampilkan prosedur tersebut
    SELECT * FROM pesawat_jumbo;
