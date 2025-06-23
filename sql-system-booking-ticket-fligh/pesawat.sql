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




-- **CONTOH SEMUA PENGGUNAAN OPERATOR**

-- 1# operator logika (AND, OR, NOT)
-- AND
SELECT * FROM pesawat
WHERE (merek_pesawat = 'A350' OR merek_pesawat = 'A220') AND id_maskapai != 'M003';

-- OR
SELECT * FROM pesawat
WHERE merek_pesawat = 'A350' OR merek_pesawat = 'A220';

-- NOT
SELECT * FROM pesawat
WHERE NOT merek_pesawat = 'A350';


-- 2# operator NULL (IS NULL, IS NOT NULL)
-- IS NULL
SELECT * FROM pesawat
WHERE id_maskapai IS NULL;

-- IS NOT NULL
SELECT * FROM pesawat
WHERE id_maskapai IS NOT NULL;


-- 3# operator pencocokan pola (LIKE)
SELECT * FROM pesawat
WHERE jenis_pesawat LIKE '%PASSENGER%';


-- 4# operator set (IN, BETWEEN)
-- IN
SELECT * FROM pesawat
WHERE id_maskapai IN ('M001', 'M002');

-- BETWEEN
SELECT * FROM pesawat
WHERE id_pesawat BETWEEN 'PE001' AND 'PE003';


-- 5# operator query (UNION, UNION ALL, EXISTS, ANY, ALL)
-- UNION
SELECT id_pesawat FROM pesawat WHERE merek_pesawat = 'A350'
UNION
SELECT id_pesawat FROM pesawat WHERE id_maskapai = 'M001';

-- UNION ALL
SELECT id_pesawat FROM pesawat WHERE merek_pesawat = 'A350'
UNION ALL
SELECT id_pesawat FROM pesawat WHERE id_maskapai = 'M001';

-- EXISTS
SELECT * FROM pesawat
WHERE EXISTS (SELECT 1 FROM pesawat WHERE id_maskapai = 'M002');

-- ANY
SELECT * FROM pesawat
WHERE id_maskapai > ANY (SELECT id_maskapai FROM pesawat WHERE merek_pesawat = 'A220');

-- ALL
SELECT * FROM pesawat
WHERE id_maskapai > ALL (SELECT id_maskapai FROM pesawat WHERE merek_pesawat = 'A220');


-- 6# operator pengurutan dan pengelompokan (ORDER BY, GROUP BY, HAVING)
-- ORDER BY
SELECT * FROM pesawat
ORDER BY jenis_pesawat;

-- GROUP BY
SELECT jenis_pesawat, COUNT(*) AS jumlah_pesawat
FROM pesawat
GROUP BY jenis_pesawat;

-- HAVING
SELECT jenis_pesawat, COUNT(*) AS jumlah_pesawat
FROM pesawat
GROUP BY jenis_pesawat
HAVING COUNT(*) > 1;


-- #7 operator lainnya (AS, CASE, DISTINCT, INTO, LIMIT)
-- AS
SELECT id_pesawat AS 'ID Pesawat', jenis_pesawat AS 'Jenis Pesawat' FROM pesawat;

-- CASE
SELECT id_pesawat,
       CASE 
           WHEN jenis_pesawat LIKE '%JUMBO%' THEN 'Jumbo'
           WHEN jenis_pesawat LIKE '%MINI%' THEN 'Mini'
           ELSE 'Normal'
       END AS 'Kategori'
FROM pesawat;

-- DISTINCT
SELECT DISTINCT jenis_pesawat FROM pesawat;

-- INTO
CREATE TABLE IF NOT EXISTS pesawat_summary AS
SELECT jenis_pesawat, COUNT(*) AS jumlah_pesawat
FROM pesawat
GROUP BY jenis_pesawat;

-- LIMIT
SELECT * FROM pesawat
LIMIT 3;


-- 8# operator function (MIN(), MAX(), COUNT(), SUM(), AVG(), IF() IFNULL(), COALESCE ())
-- MIN()
SELECT MIN(id_pesawat) AS 'Minimum ID Pesawat' FROM pesawat;

-- MAX()
SELECT MAX(id_pesawat) AS 'Maximum ID Pesawat' FROM pesawat;

-- COUNT()
SELECT COUNT(*) AS 'Total Pesawat' FROM pesawat;

-- IF()
SELECT id_pesawat, 
       IF(jenis_pesawat LIKE '%JUMBO%', 'Ya', 'Tidak') AS 'Ini Jenis Jumbo'
FROM pesawat;

-- IFNULL()
SELECT id_pesawat, IFNULL(id_maskapai, 'Tidak ada maskapai') AS 'Maskapai'
FROM pesawat;

-- COALESCE() 
SELECT id_pesawat, COALESCE(id_maskapai, 'Tidak ada maskapai') AS 'Maskapai'
FROM pesawat;


-- 9# operator JOIN (INNER JOIN, RIGHT JOIN, LEFT JOIN, FULL JOIN)
CREATE TABLE penumpang (
    id_penumpang CHAR(4) UNIQUE PRIMARY KEY,
    nama VARCHAR(20) NOT NULL,
    jenis_kelamin ENUM('WANITA', 'PRIA') DEFAULT 'PRIA'
);

INSERT INTO penumpang (id_penumpang, nama, jenis_kelamin) VALUES 
('P001', 'DINAR DANISH', 'WANITA'),
('P002', 'NILAM SARI', 'WANITA'),
('P003', 'ABI SYAHLI', 'PRIA'),
('P004', 'ZENDAYA', 'WANITA'),
('P005', 'ABU LAHAB', 'PRIA');

-- INNER JOIN
SELECT 
    p.nama AS 'Nama Penumpang',
    pes.id_pesawat AS 'ID Pesawat',
    pes.jenis_pesawat AS 'Jenis Pesawat'
FROM penumpang p
INNER JOIN pesawat pes ON p.id_penumpang = SUBSTRING(pes.id_pesawat, 3, 4);  -- Assuming id_penumpang matches part of id_pesawat

-- LEFT JOIN 
SELECT 
    p.nama AS 'Nama Penumpang',
    pes.id_pesawat AS 'ID Pesawat',
    pes.jenis_pesawat AS 'Jenis Pesawat'
FROM penumpang p
LEFT JOIN pesawat pes ON p.id_penumpang = SUBSTRING(pes.id_pesawat, 3, 4);  

-- RIGHT JOIN 
SELECT 
    p.nama AS 'Nama Penumpang',
    pes.id_pesawat AS 'ID Pesawat',
    pes.jenis_pesawat AS 'Jenis Pesawat'
FROM penumpang p
RIGHT JOIN pesawat pes ON p.id_penumpang = SUBSTRING(pes.id_pesawat, 3, 4);  -- Assuming id_penumpang matches part of id_pesawat

-- FULL JOIN
SELECT 
    p.nama AS 'Nama Penumpang',
    pes.id_pesawat AS 'ID Pesawat',
    pes.jenis_pesawat AS 'Jenis Pesawat'
FROM penumpang p
LEFT JOIN pesawat pes ON p.id_penumpang = SUBSTRING(pes.id_pesawat, 3, 4)  
    
UNION

SELECT 
    p.nama AS 'Nama Penumpang',
    pes.id_pesawat AS 'ID Pesawat',
    pes.jenis_pesawat AS 'Jenis Pesawat'
FROM penumpang p
RIGHT JOIN pesawat pes ON p.id_penumpang = SUBSTRING(pes.id_pesawat, 3, 4);
