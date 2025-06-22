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
CREATE TABLE tiket (
    no_tiket VARCHAR(5) UNIQUE PRIMARY KEY,
    id_pemesanan VARCHAR(5) UNIQUE NOT NULL,
    tanggal_penerbangan DATE,
    id_kursi VARCHAR(3) UNIQUE,
    jadwal TIME
);


-- INSERT: data
INSERT INTO tiket (no_tiket, id_pemesanan, tanggal_penerbangan, id_kursi, jadwal) VALUES
('SQ001', 'PM001', '2025-04-05', '45A', '13:15:00'),
('SQ002', 'PM002', '2025-04-05', '07A', '07:42:00'),
('SQ003', 'PM003', '2025-04-06', '50A', '21:15:00'),
('SQ004', 'PM004', '2025-04-08', '53D', '16:00:00'),
('SQ005', 'PM005', '2025-04-10', '42E', '04:30:00');
    --  SELECT: awalnya data
    SELECT * FROM tiket;


-- ALTER: menambah kolom tabel
ALTER TABLE tiket
ADD maksimal_barang_bawaan VARCHAR(5) default '5kg';
    -- SELECT: menambah kolom
    SELECT * FROM tiket;


-- ALTER: mengubah nama kolomtabel
ALTER TABLE tiket
CHANGE maksimal_barang_bawaan maksimal_payload VARCHAR(5) default '5kg';
    -- SELECT: mengubah kolom
    SELECT * FROM tiket;


--  ALTER: menghapus kolom tabel
ALTER TABLE tiket
DROP COLUMN maksimal_payload;
    -- SELECT: menambah kolom
    SELECT * FROM tiket;


/*
-- DROP: menghapus tabel
DROP TABLE tiket;


-- TRUNCATE: menghapus isi data tabel
TRUNCATE TABLE tiket;
*/


-- UPDATE: ganti kursi untuk tiket SQ004
UPDATE tiket
SET id_kursi = '54D'
WHERE no_tiket = 'SQ004';
    --  SELECT: setelah di ubah
    SELECT * FROM tiket;


-- DELETE: hapus tiket SQ005
DELETE FROM tiket
WHERE no_tiket = 'SQ005';
    --  SELECT: setelah di hapus
    SELECT * FROM tiket;


/*
-- CREATE PROCEDURE
CREATE PROCEDURE semua_tiket
AS
SELECT * FROM tiket
GO;
    -- EXEC: mengeksekusi prosedur tersebut 
    EXEC semua_tiket;


-- CREATE INDEX
CREATE INDEX idx_id_kursi
ON tiket(id_kursi);
    -- DROP INDEX: menghapus index tersebut
    ALTER TABLE tiket
    DROP INDEX idx_id_kursi;
*/


-- CREATE VIEW
CREATE VIEW tiket_penerbangan AS
SELECT * FROM tiket
WHERE tanggal_penerbangan = '2025-04-05';
    -- SELECT: menampilkan prosedur tersebut
    SELECT * FROM tiket_penerbangan;




-- **CONTOH SEMUA PENGGUNAAN OPERATOR**

-- 1# operator logika (AND, OR, NOT)
