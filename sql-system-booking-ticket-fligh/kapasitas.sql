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
    id_pesawat VARCHAR(5) UNIQUE PRIMARY KEY,
    id_kursi VARCHAR(3) UNIQUE,
    kapasitas_kursi INTEGER NOT NULL
);


-- INSERT: data
INSERT INTO kapasitas (id_pesawat, id_kursi, kapasitas_kursi) VALUES
('PE001', '45A', 780),
('PE002', '07A', 8),
('PE003', '50A', 770),
('PE004', '53D', 780),
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


/*
-- CREATE PROCEDURE
CREATE PROCEDURE semua_kapasitas
AS
SELECT * FROM kapasitas
GO;
    -- EXEC: mengeksekusi prosedur tersebut 
    EXEC semua_kapasitas;


-- CREATE INDEX
CREATE INDEX idx_kapasitas_kursi
ON operator(nama_kapasitas_kursi);
    -- DROP INDEX: menghapus index tersebut
    ALTER TABLE kapasitas
    DROP INDEX idx_kapasitas_kursi;


-- CREATE VIEW
CREATE VIEW [kapasitas kursi] AS
SELECT * FROM kapasitas
WHERE kapasitas_kursi = 780;
    -- SELECT: menampilkan prosedur tersebut
    SELECT * FROM [kapasitas kursi];
*/



-- **CONTOH SEMUA PENGGUNAAN OPERATOR**

-- 1# operator logika (AND, OR, NOT)
SELECT * FROM kapasitas 
WHERE kapasitas_kursi > 100 AND id_kursi LIKE '5%';

SELECT * FROM kapasitas 
WHERE id_pesawat = 'PE001' OR id_pesawat = 'PE002';

SELECT * FROM kapasitas 
WHERE NOT kapasitas_kursi < 100;


-- 2# operator NULL (IS NULL, IS NOT NULL)
SELECT * FROM kapasitas 
WHERE id_kursi IS NULL;

SELECT * FROM kapasitas 
WHERE kapasitas_kursi IS NOT NULL;


-- 3# operator pencocokan pola (LIKE)
SELECT * FROM kapasitas 
WHERE id_kursi LIKE '4%';


-- 4# operator set (IN, BETWEEN)
SELECT * FROM kapasitas 
WHERE id_pesawat IN ('PE001', 'PE002'); 

SELECT * FROM kapasitas 
WHERE kapasitas_kursi BETWEEN 60 AND 800;


-- 5# operator query (UNION, UNION ALL, EXISTS, ANY, ALL)
CREATE TABLE kapasitas_backup (
    id_pesawat CHAR(5) PRIMARY KEY,
    id_kursi CHAR(3),
    kapasitas_kursi INTEGER
);

INSERT INTO kapasitas_backup (id_pesawat, id_kursi, kapasitas_kursi) VALUES
('PE006', '44A', 100),
('PE007', '45B', 200);

-- UNION
SELECT id_pesawat FROM kapasitas
UNION
SELECT id_pesawat FROM kapasitas_backup;

-- UNION ALL
SELECT id_pesawat FROM kapasitas
UNION ALL
SELECT id_pesawat FROM kapasitas_backup;

-- EXISTS
SELECT * 
FROM kapasitas k
WHERE EXISTS (
    SELECT 1 FROM kapasitas_backup b 
    WHERE b.id_pesawat = k.id_pesawat
);

-- ANY/ALL
SELECT * FROM kapasitas
WHERE kapasitas_kursi > ANY (SELECT kapasitas_kursi FROM kapasitas_backup);


-- 6# operator pengurutan dan pengelompokan (ORDER BY, GROUP BY, HAVING)
SELECT * FROM kapasitas
ORDER BY kapasitas_kursi DESC;

-- GROUP BY
SELECT kapasitas_kursi, COUNT(*) as total_pesawat
FROM kapasitas
GROUP BY kapasitas_kursi
HAVING total_pesawat > 1;


-- 7# operator lainnya (AS, CASE, DISTINCT, INTO, LIMIT)
-- AS
SELECT id_pesawat AS aircraft_id, kapasitas_kursi AS kapasitas_kursi FROM kapasitas;

-- CASE
SELECT id_pesawat, kapasitas_kursi,
    CASE 
        WHEN kapasitas_kursi > 700 THEN 'KAPASITAS TINGGI'
        WHEN kapasitas_kursi BETWEEN 100 AND 700 THEN 'KAPASITAS SEDANG'
        ELSE 'KAPASITAS KECIL'
    END AS kapasitas_kategori
FROM kapasitas;

-- DISTINCT
SELECT DISTINCT kapasitas_kursi FROM kapasitas;

-- INTO
CREATE TABLE kapasitas_copy AS
SELECT * FROM kapasitas;

-- LIMIT
SELECT * FROM kapasitas LIMIT 3;

-- CASE
SELECT id_pesawat, kapasitas_kursi,
    CASE 
        WHEN kapasitas_kursi > 700 THEN 'JUMBO PASSENGER JETS'
        WHEN kapasitas_kursi > 100 THEN 'MEDIUM PASSENGER JETS'
        ELSE 'MINI PASSENGER JETS'
    END AS kelas_pesawat
FROM kapasitas;


-- 8# operator function (MIN(), MAX(), COUNT(), SUM(), AVG(), IF() IFNULL(), COALESCE ())
-- MIN()
SELECT MIN(kapasitas_kursi) AS kapasitas_terkecil FROM kapasitas;

-- MAX()
SELECT MAX(kapasitas_kursi) AS kapasitas_terbesar FROM kapasitas;

-- COUNT()
SELECT COUNT(*) AS total_pesawat FROM kapasitas;

-- SUM() 
SELECT SUM(kapasitas_kursi) AS total_kursi FROM kapasitas;

-- AVG()
SELECT AVG(kapasitas_kursi) AS kapasitas_average FROM kapasitas;

-- IF()
SELECT id_pesawat, kapasitas_kursi,
IF(kapasitas_kursi > 100, 'BESAR', 'KECIL') AS jumlah_kursi
FROM kapasitas;

-- IFNULL()
INSERT INTO kapasitas VALUES ('PE006', NULL, 200);

SELECT id_kursi, IFNULL(id_kursi, 'Tidak dikenal') AS id_kursi_fallback
FROM kapasitas;

DELETE FROM kapasitas WHERE id_pesawat = 'PE006';

-- COALESCE()
INSERT INTO kapasitas VALUES
('PE006', NULL, 200),
('PE007', NULL, 444);

SELECT id_pesawat,
COALESCE(id_kursi, id_pesawat, 'Tidak Ada ID yang Tersedia') AS id_pengenal
FROM kapasitas;

DELETE FROM kapasitas WHERE id_pesawat IN ('PE006', 'PE007');


-- 9# operator JOIN (INNER JOIN, RIGHT JOIN, LEFT JOIN, FULL JOIN)
CREATE TABLE penerbangan (
    id_penerbangan VARCHAR(6) PRIMARY KEY,
    id_pesawat VARCHAR(5),
    bandara_asal VARCHAR(30),
    bandara_tujuan VARCHAR(30)
);

INSERT INTO penerbangan (id_penerbangan, id_pesawat, bandara_asal, bandara_tujuan) VALUES
('PGA001', 'PE001', 'Soekarno-Hatta', 'Changi'),
('PGA002', 'PE002', 'Juanda', 'Ngurah Rai'),
('PGA003', 'PE003', 'Changi', 'Soekarno-Hatta'),
('PGA004', 'PE004', 'Ngurah Rai', 'Juanda'),
('PGA005', 'PE005', 'Soekarno-Hatta', 'Kuala Lumpur');

-- INNER JOIN
SELECT k.id_pesawat, k.kapasitas_kursi, p.id_penerbangan, p.bandara_asal
FROM kapasitas k
INNER JOIN penerbangan p ON k.id_pesawat = p.id_pesawat;

-- LEFT JOIN
SELECT k.id_pesawat, k.kapasitas_kursi, p.id_penerbangan, p.bandara_tujuan
FROM kapasitas k
LEFT JOIN penerbangan p ON k.id_pesawat = p.id_pesawat;

-- RIGHT JOIN
SELECT k.id_pesawat, k.id_kursi, p.id_penerbangan, p.bandara_asal
FROM kapasitas k
RIGHT JOIN penerbangan p ON k.id_pesawat = p.id_pesawat;

-- FULL JOIN (LEFT + RIGHT JOIN)
SELECT k.id_pesawat, k.id_kursi, p.id_penerbangan, p.bandara_tujuan
FROM kapasitas k
LEFT JOIN penerbangan p ON k.id_pesawat = p.id_pesawat

UNION

SELECT k.id_pesawat, k.id_kursi, p.id_penerbangan, p.bandara_tujuan
FROM kapasitas k
RIGHT JOIN penerbangan p ON k.id_pesawat = p.id_pesawat;
