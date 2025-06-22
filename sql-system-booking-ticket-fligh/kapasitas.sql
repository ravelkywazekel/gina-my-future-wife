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
CREATE TABLE kapasitas (
    id_pesawat CHAR(5) UNIQUE PRIMARY KEY,
    id_kursi CHAR(3) UNIQUE NOT NULL,
    kapasitas_kursi INTEGER NOT NULL
);


-- INSERT: data
INSERT INTO kapasitas (id_pesawat, id_kursi, kapasitas_kursi) VALUES
('PE001', '45A', 780),
('PE002', '07A', 8),
('PE003', '50A', 770),
('PE004', '53D', 750),
('PE005', '42E', 60);
  --  SELECT: awalnya data
SELECT * FROM kapasitas;


-- ALTER: menambah kolom tabel
ALTER TABLE kapasitas
ADD berat_bawaan VARCHAR(5) default '0kg';
    -- SELECT: menambah kolom
    SELECT * FROM kapasitas;


-- ALTER: mengubah nama kolomtabel
ALTER TABLE kapasitas
CHANGE berat_bawaan berat_bagasi VARCHAR(5) default '0kg';
    -- SELECT: mengubah kolom
    SELECT * FROM kapasitas;


--  ALTER: menghapus kolom tabel
ALTER TABLE kapasitas
DROP COLUMN berat_bagasi;
    -- SELECT: menambah kolom
    SELECT * FROM kapasitas;


/*
-- DROP: menghapus tabel
DROP TABLE kapasitas;


-- TRUNCATE: menghapus isi data tabel
TRUNCATE TABLE kapasitas;
*/


-- UPDATE: ubah kapasitas untuk penerbangan PE002
UPDATE kapasitas
SET kapasitas_kursi = 15
WHERE id_pesawat = 'PE002';
  --  SELECT: setelah di ubah
SELECT * FROM kapasitas;


-- DELETE: hapus catatan kapasitas untuk penerbangan PE005
DELETE FROM kapasitas
WHERE id_pesawat = 'PE005';
  --  SELECT: setelah di hapus
SELECT * FROM kapasitas;



