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
CREATE TABLE penerbangan (
    id_maskapai VARCHAR(10) UNIQUE PRIMARY KEY,
    id_operator VARCHAR(10) UNIQUE,
    status_penerbangan ENUM('AKTIF', 'DITUNDA', 'DIBATALKAN')
);


-- INSERT: data
INSERT INTO penerbangan (id_maskapai, id_operator, status_penerbangan) VALUES
('M001', 'OP1', 'AKTIF'),
('M002', 'OP2', 'DITUNDA'),
('M003', 'OP3', 'AKTIF'),
('M004', 'OP4', 'DIBATALKAN'),
('M005', 'OP5', 'AKTIF');
    --  SELECT: awalnya data
    SELECT * FROM penerbangan;



-- ALTER: menambah kolom tabel
ALTER TABLE penerbangan 
ADD cuaca VARCHAR(10) default 'test';
    -- SELECT: menambah kolom
    SELECT * FROM penerbangan;


-- ALTER: mengubah nama kolomtabel
ALTER TABLE penerbangan 
CHANGE cuaca kondisi_cuaca VARCHAR(10) default 'test';
    -- SELECT: mengubah kolom
    SELECT * FROM penerbangan;


--  ALTER: menghapus kolom tabel
ALTER TABLE penerbangan 
DROP COLUMN kondisi_cuaca;
    -- SELECT: menambah kolom
    SELECT * FROM penerbangan;


/*
-- DROP: menghapus tabel
DROP TABLE penerbangan;


-- TRUNCATE: menghapus isi data tabel
TRUNCATE TABLE penerbangan;
*/


-- UPDATE: ubah status untuk maskapai M002 dan operator OP2
UPDATE penerbangan
SET status_penerbangan = 'AKTIF'
WHERE id_maskapai = 'M002' AND id_operator = 'OP2';
      --  SELECT: setelah di ubah
    SELECT * FROM penerbangan;


-- DELETE: hapus catatan penerbangan untuk maskapai M004 dan operator OP4
DELETE FROM penerbangan
WHERE id_maskapai = 'M004' AND id_operator = 'OP4';
    --  SELECT: setelah di hapus
    SELECT * FROM penerbangan;


/*
-- CREATE PROCEDURE
CREATE PROCEDURE semua_penerbangan
AS
SELECT * FROM penerbangan
GO;
    -- EXEC: mengeksekusi prosedur tersebut 
    EXEC semua_penerbangan;


-- CREATE INDEX
CREATE INDEX idx_status_penerbangan
ON penerbangan(status_penerbangan);
    -- DROP INDEX: menghapus index tersebut
    ALTER TABLE penerbangan
    DROP INDEX idx_status_penerbangan;
*/


-- CREATE VIEW
CREATE VIEW penerbangan_disetujui AS
SELECT * FROM penerbangan 
WHERE status_penerbangan = 'AKTIF';
    -- SELECT: menampilkan prosedur tersebut
    SELECT * FROM penerbangan_disetujui;
