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
CREATE TABLE maskapai (
    id_maskapai CHAR(4) UNIQUE PRIMARY KEY,
    nama_maskapai ENUM('GARUDA INDONESIA', 'LION AIR', 'CITILINK'),
    website VARCHAR(30) NOT NULL
);


-- INSERT: data
INSERT INTO maskapai (id_maskapai, nama_maskapai, website) VALUES
('M001', 'GARUDA INDONESIA', 'GARUDA-INDONESIA.COM'),
('M002', 'LION AIR', 'LIONAIR.CO.ID'),
('M003', 'CITILINK', 'CITILINK.CO.ID'),
('M004', 'LION AIR', 'LIONAIR.CO.ID'),
('M005', 'GARUDA INDONESIA', 'GARUDA-INDONESIA.COM');
    --  SELECT: awalnya data
    SELECT * FROM maskapai;


-- ALTER: menambah kolom tabel
ALTER TABLE maskapai
ADD hq_operator VARCHAR(20) default 'test';
    -- SELECT: menambah kolom
    SELECT * FROM maskapai;


-- ALTER: mengubah nama kolomtabel
ALTER TABLE maskapai
CHANGE hq_operator kantor_operator VARCHAR(20) default 'test';
    -- SELECT: mengubah kolom
    SELECT * FROM maskapai;


--  ALTER: menghapus kolom tabel
ALTER TABLE maskapai
DROP COLUMN kantor_operator;
    -- SELECT: menambah kolom
    SELECT * FROM maskapai;


/*
-- DROP: menghapus tabel
DROP TABLE maskapai;


-- TRUNCATE: menghapus isi data tabel
TRUNCATE TABLE maskapai;
*/


-- UPDATE: ubah situs web untuk maskapai M002
UPDATE maskapai
SET website = 'LIONAIR-INDONESIA.CO.ID'
WHERE id_maskapai = 'M002';
    --  SELECT: setelah di ubah
    SELECT * FROM maskapai;


-- DELETE: hapus maskapai dengan airline_id M004
DELETE FROM maskapai
WHERE id_maskapai = 'M004';
    --  SELECT: setelah di hapus
    SELECT * FROM maskapai;


/*
-- CREATE PROCEDURE
CREATE PROCEDURE semua_website
AS
SELECT * FROM maskapai 
GO;
    -- EXEC: mengeksekusi prosedur tersebut 
    EXEC semua_maskapai;


-- CREATE INDEX
CREATE INDEX idx_website
ON maskapai(website);
    -- DROP INDEX: menghapus index tersebut
    ALTER TABLE maskapai
    DROP INDEX idx_website;


-- CREATE VIEW
CREATE VIEW [website maskapai] AS
SELECT * FROM maskapai
WHERE nama_operator = 'GARUDA-INDONESIA.COM';
    -- SELECT: menampilkan prosedur tersebut
    SELECT * FROM [website maskapai];
*/
    
