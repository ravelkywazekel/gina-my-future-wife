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
CREATE TABLE pemesanan (
    id_penumpang VARCHAR(4) UNIQUE PRIMARY KEY,
    no_tiket VARCHAR(5) UNIQUE,
    harga DECIMAL(15, 2) NOT NULL
);


-- INSERT: data
INSERT INTO pemesanan (id_penumpang, no_tiket, harga) VALUES
('P001', 'SQ001', 1500000.00),
('P002', 'SQ002', 1800000.00),
('P003', 'SQ003', 1550000.00),
('P004', 'SQ004', 1600000.00),
('P005', 'SQ005', 600000.00);
    --  SELECT: awalnya data
    SELECT * FROM pemesanan;


-- ALTER: menambah kolom tabel
ALTER TABLE pemesanan
ADD pembayaran SET('DEBIT', 'CASH', 'KREDIT') default 'CASH';
    -- SELECT: menambah kolom
    SELECT * FROM pemesanan;


-- ALTER: mengubah nama kolomtabel
ALTER TABLE pemesanan
CHANGE pembayaran opsi_pembayaran SET('DEBIT', 'CASH', 'KREDIT') default 'CASH';
    -- SELECT: mengubah kolom
    SELECT * FROM pemesanan;


--  ALTER: menghapus kolom tabel
ALTER TABLE pemesanan
DROP COLUMN opsi_pembayaran;
    -- SELECT: menambah kolom
    SELECT * FROM pemesanan;


/*
-- DROP: menghapus tabel
DROP TABLE pemesanan;


-- TRUNCATE: menghapus isi data tabel
TRUNCATE TABLE pemesanan;
*/


-- UPDATE: ubah harga tiket SQ005
UPDATE pemesanan
SET harga = 650000.00
WHERE no_tiket = 'SQ005';
    --  SELECT: setelah di ubah
    SELECT * FROM pemesanan;


-- DELETE: hapus pemesanan SQ003
DELETE FROM pemesanan
WHERE no_tiket = 'SQ003';
    --  SELECT: setelah di hapus
    SELECT * FROM pemesanan;


/*
-- CREATE PROCEDURE
CREATE PROCEDURE semua_pemesanan
AS
SELECT * FROM pemesanan
GO;
    -- EXEC: mengeksekusi prosedur tersebut 
    EXEC semua_pemesanan;


-- CREATE INDEX
CREATE INDEX idx_no_tiket
ON pemesanan(no_tiket);
    -- DROP INDEX: menghapus index tersebut
    ALTER TABLE pemesanan 
    DROP INDEX idx_no_tiket;
*/


-- CREATE VIEW
CREATE VIEW harga_tiket AS
SELECT * FROM pemesanan
WHERE harga = 1600000.00;
    -- SELECT: menampilkan prosedur tersebut
    SELECT * FROM harga_tiket;




-- **CONTOH SEMUA PENGGUNAAN OPERATOR**

-- 1# operator logika (AND, OR, NOT)
