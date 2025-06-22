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
CREATE TABLE tujuan (
    id_pesawat VARCHAR(5) UNIQUE PRIMARY KEY,
    id_penumpang VARCHAR(4) UNIQUE,
    tujuan_pesawat VARCHAR(15) NOT NULL
);


-- INSERT: data
INSERT INTO tujuan (id_pesawat, id_penumpang, tujuan_pesawat) VALUES
('PE001', 'P001', 'JAKARTA'),
('PE002', 'P002', 'BALI'),
('PE003', 'P003', 'SURABAYA'),
('PE004', 'P004', 'PADANG'),
('PE005', 'P005', 'PEKANBARU');
    --  SELECT: awalnya data
    SELECT * FROM tujuan;

        
-- ALTER: menambah kolom tabel
ALTER TABLE tujuan 
ADD transit VARCHAR(15) default 'test';
    -- SELECT: menambah kolom
    SELECT * FROM tujuan;


-- ALTER: mengubah nama kolomtabel
ALTER TABLE tujuan 
CHANGE transit tempat_transit VARCHAR(15) default 'test';
    -- SELECT: mengubah kolom
    SELECT * FROM tujuan;


--  ALTER: menghapus kolom tabel
ALTER TABLE tujuan 
DROP COLUMN tempat_transit;
    -- SELECT: menambah kolom
    SELECT * FROM tujuan;


/*
-- DROP: menghapus tabel
DROP TABLE tujuan;


-- TRUNCATE: menghapus isi data tabel
TRUNCATE TABLE tujuan;
*/


-- UPDATE: ubah tujuan untuk penumpang P003 pada penerbangan PE003
UPDATE tujuan
SET tujuan_pesawat = 'MALANG'
WHERE id_pesawat = 'PE003' AND id_penumpang = 'P003';
    --  SELECT: setelah di ubah
    SELECT * FROM tujuan;

        
-- DELETE: hapus catatan tujuan untuk penumpang P005 pada penerbangan PE005
DELETE FROM tujuan
WHERE id_pesawat = 'PE005' AND id_penumpang = 'P005';
    --  SELECT: setelah di hapus
    SELECT * FROM tujuan;


/*
-- CREATE PROCEDURE
CREATE PROCEDURE semua_tujuan
AS
SELECT * FROM tujuan
GO;
    -- EXEC: mengeksekusi prosedur tersebut 
    EXEC semua_tujuan;


-- CREATE INDEX
CREATE INDEX idx_id_penumpang
ON tujuan(id_penumpang);
    -- DROP INDEX: menghapus index tersebut
    ALTER TABLE tujuan
    DROP INDEX idx_id_penumpang;
*/


-- CREATE VIEW
CREATE VIEW tujuan_destinasi AS
SELECT * FROM tujuan
WHERE tujuan_pesawat = 'PADANG';
    -- SELECT: menampilkan prosedur tersebut
    SELECT * FROM tujuan_destinasi;





-- **CONTOH SEMUA PENGGUNAAN OPERATOR**

-- 1# operator logika (AND, OR, NOT)
