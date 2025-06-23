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
CREATE TABLE penumpang (
    id_penumpang CHAR(4) UNIQUE PRIMARY KEY,
    nama VARCHAR(20) NOT NULL,
    jenis_kelamin ENUM('WANITA', 'PRIA') DEFAULT 'PRIA'
);


-- INSERT: data
INSERT INTO penumpang (id_penumpang, nama, jenis_kelamin) VALUES 
('P001', 'DINAR DANISH', 'WANITA'),
('P002', 'NILAM SARI', 'WANITA'),
('P003', 'ABI SYAHLI', 'PRIA'),
('P004', 'ZENDAYA', 'WANITA'),
('P005', 'ABU LAHAB', 'PRIA');
    --  SELECT: awalnya data
    SELECT * FROM penumpang;



-- ALTER: menambah kolom tabel
ALTER TABLE penumpang
ADD usia TINYINT default 28;
    -- SELECT: menambah kolom
    SELECT * FROM penumpang;


-- ALTER: mengubah nama kolomtabel
ALTER TABLE penumpang
CHANGE usia usia_penumpang TINYINT default 28;
    -- SELECT: mengubah kolom
    SELECT * FROM penumpang;


--  ALTER: menghapus kolom tabel
ALTER TABLE penumpang 
DROP COLUMN usia_penumpang;
    -- SELECT: menambah kolom
    SELECT * FROM penumpang;


/*
-- DROP: menghapus tabel
DROP TABLE penumpang;


-- TRUNCATE: menghapus isi data tabel
TRUNCATE TABLE penumpang;
*/


-- UPDATE: ubah jenis kelamin penumpang P004
UPDATE penumpang
SET jenis_kelamin = 'PRIA'
WHERE id_penumpang = 'P004';
    --  SELECT: setelah di ubah
    SELECT * FROM penumpang;


-- DELETE: hapus penumpang P005
DELETE FROM penumpang
WHERE id_penumpang = 'P005';
    --  SELECT: setelah di hapus
    SELECT * FROM penumpang;


/*
-- CREATE PROCEDURE
CREATE PROCEDURE semua_penumpang
AS
SELECT * FROM penumpang
GO;
    -- EXEC: mengeksekusi prosedur tersebut 
    EXEC semua_penumpang;


-- CREATE INDEX
CREATE INDEX idx_nama_penumpang
ON penumpang(nama_penumpang);
    -- DROP INDEX: menghapus index tersebut
    ALTER TABLE penumpang
    DROP INDEX idx_nama_penumpang;
*/


-- CREATE VIEW
CREATE VIEW penumpang_pesawat AS
SELECT * FROM penumpang
WHERE nama LIKE 'A%';
    -- SELECT: menampilkan prosedur tersebut
    SELECT * FROM penumpang_pesawat;



-- **CONTOH SEMUA PENGGUNAAN OPERATOR**

-- 1# operator logika (AND, OR, NOT)
-- AND
SELECT * FROM penumpang 
WHERE jenis_kelamin = 'WANITA' AND nama LIKE 'D%';

-- OR
SELECT * FROM penumpang 
WHERE jenis_kelamin = 'WANITA' OR nama = 'ABI SYAHLI';

-- NOT
SELECT * FROM penumpang 
WHERE NOT jenis_kelamin = 'PRIA';


-- 2# operator NULL (IS NULL, IS NOT NULL)
-- IS NULL
SELECT * FROM penumpang 
WHERE id_penumpang IS NULL;

-- IS NOT NULL
SELECT * FROM penumpang 
WHERE id_penumpang IS NOT NULL; 

-- 3# operator pencocokan pola (LIKE)
-- LIKE
SELECT * FROM penumpang 
WHERE nama LIKE '%A%';


-- 4# operator set (IN, BETWEEN)
-- IN
SELECT * FROM penumpang 
WHERE jenis_kelamin IN ('WANITA', 'PRIA');


-- 5# operator query (UNION, UNION ALL, EXISTS, ANY, ALL)
-- UNION
CREATE TABLE penumpang_backup (
    id_penumpang CHAR(4) UNIQUE PRIMARY KEY,
    nama VARCHAR(20) NOT NULL,
    jenis_kelamin ENUM('WANITA', 'PRIA') DEFAULT 'PRIA'
);

INSERT INTO penumpang_backup (id_penumpang, nama, jenis_kelamin) VALUES 
('P006', 'ALICE', 'WANITA'),
('P007', 'BOB', 'PRIA');

SELECT id_penumpang FROM penumpang
UNION
SELECT id_penumpang FROM penumpang_backup;

-- UNION ALL
SELECT id_penumpang FROM penumpang
UNION ALL
SELECT id_penumpang FROM penumpang_backup;

-- EXISTS
SELECT * 
FROM penumpang p
WHERE EXISTS (
    SELECT 1 FROM penumpang_backup b 
    WHERE b.id_penumpang = p.id_penumpang
);

-- ANY
SELECT * FROM penumpang
WHERE id_penumpang > ANY (SELECT id_penumpang FROM penumpang_backup);

-- ALL
SELECT * FROM penumpang
WHERE id_penumpang > ALL (SELECT id_penumpang FROM penumpang_backup);


-- 6# operator pengurutan dan pengelompokan (ORDER BY, GROUP BY, HAVING)
-- ORDER BY
SELECT * FROM penumpang
ORDER BY nama ASC; 

-- GROUP BY
SELECT jenis_kelamin, COUNT(*) as total_penumpang
FROM penumpang
GROUP BY jenis_kelamin;

-- HAVING
SELECT jenis_kelamin, COUNT(*) as total_penumpang
FROM penumpang
GROUP BY jenis_kelamin
HAVING total_penumpang > 2;  


-- #7 operator lainnya (AS, CASE, DISTINCT, INTO, LIMIT)
-- AS
SELECT id_penumpang AS passenger_id, nama AS passenger_name FROM penumpang;

-- CASE
SELECT id_penumpang, nama,
    CASE 
        WHEN jenis_kelamin = 'WANITA' THEN 'Female'
        WHEN jenis_kelamin = 'PRIA' THEN 'Male'
    END AS deskripsi_jenis_kelamin
FROM penumpang;

-- DISTINCT
SELECT DISTINCT jenis_kelamin FROM penumpang;

-- INTO
CREATE TABLE penumpang_copy AS
SELECT * FROM penumpang;

-- LIMIT
SELECT * FROM penumpang LIMIT 3;


-- 8# operator function (MIN(), MAX(), COUNT(), IF() IFNULL(), COALESCE ())
-- MIN()
SELECT MIN(id_penumpang) AS min_penumpang FROM penumpang;

-- MAX()
SELECT MAX(id_penumpang) AS max_penumpang FROM penumpang;

-- COUNT()
SELECT COUNT(*) AS total_penumpang FROM penumpang;

-- IF()
SELECT id_penumpang, nama,
IF(jenis_kelamin, 'WANITA', 'PRIA') AS status_jenis_kelamin
FROM penumpang;

-- IFNULL() 
INSERT INTO penumpang (id_penumpang, nama, jenis_kelamin) VALUES ('P008', 'UNKNOWN', NULL);
SELECT id_penumpang,
IFNULL(jenis_kelamin, 'Unknown Gender') AS status_jenis_kelamin
FROM penumpang;

-- COALESCE()
SELECT id_penumpang,
COALESCE(jenis_kelamin, 'No Gender') AS gender_info
FROM penumpang;

DELETE FROM penumpang WHERE id_penumpang = 'P008';


-- 9# operator JOIN (INNER JOIN, RIGHT JOIN, LEFT JOIN, FULL JOIN)
CREATE TABLE kapasitas (
    id_pesawat VARCHAR(5) UNIQUE PRIMARY KEY,
    id_kursi VARCHAR(3) UNIQUE,
    kapasitas_kursi INTEGER NOT NULL
);

INSERT INTO kapasitas (id_pesawat, id_kursi, kapasitas_kursi) VALUES
('PE001', '45A', 780),
('PE002', '07A', 8),
('PE003', '50A', 770),
('PE004', '53D', 780),
('PE005', '42E', 60);

-- INNER JOIN
SELECT p.id_penumpang, p.nama, p.jenis_kelamin, k.id_pesawat, k.kapasitas_kursi
FROM penumpang p
INNER JOIN kapasitas k ON p.id_penumpang = k.id_kursi;

-- LEFT JOIN
SELECT p.id_penumpang, p.nama, p.jenis_kelamin, k.id_pesawat, k.kapasitas_kursi
FROM penumpang p
LEFT JOIN kapasitas k ON p.id_penumpang = k.id_kursi;

-- RIGHT JOIN
SELECT p.id_penumpang, p.nama, p.jenis_kelamin, k.id_pesawat, k.kapasitas_kursi
FROM penumpang p
RIGHT JOIN kapasitas k ON p.id_penumpang = k.id_kursi; 

-- FULL JOIN (LEFT + RIGHT JOIN)
SELECT p.id_penumpang, p.nama, p.jenis_kelamin, k.id_pesawat, k.kapasitas_kursi
FROM penumpang p
LEFT JOIN kapasitas k ON p.id_penumpang = k.id_kursi

UNION

SELECT p.id_penumpang, p.nama, p.jenis_kelamin, k.id_pesawat, k.kapasitas_kursi
FROM penumpang p
RIGHT JOIN kapasitas k ON p.id_penumpang = k.id_kursi; 

-- SELF JOIN
SELECT a.nama AS 'Passenger 1', b.nama AS 'Passenger 2', a.jenis_kelamin AS 'Gender'
FROM penumpang a
JOIN penumpang b ON a.jenis_kelamin = b.jenis_kelamin AND a.id_penumpang < b.id_penumpang; 
