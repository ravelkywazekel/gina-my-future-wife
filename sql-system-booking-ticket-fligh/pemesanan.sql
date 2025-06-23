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
-- AND
SELECT * FROM pemesanan
WHERE harga > 1500000 AND no_tiket LIKE 'SQ%';

-- OR
SELECT * FROM pemesanan
WHERE harga < 1000000 OR no_tiket = 'SQ003';

-- NOT 
SELECT * FROM pemesanan
WHERE NOT harga = 1800000;


-- 2# operator NULL (IS NULL, IS NOT NULL)
-- IS NULL
SELECT * FROM pemesanan
WHERE no_tiket IS NULL;

-- IS NOT NULL
SELECT * FROM pemesanan
WHERE no_tiket IS NOT NULL;


-- 3# operator pencocokan pola (LIKE)
-- LIKE
SELECT * FROM pemesanan
WHERE no_tiket LIKE '%001%';

-- IN
SELECT * FROM pemesanan
WHERE no_tiket IN ('SQ001', 'SQ003');

-- BETWEEN
SELECT * FROM pemesanan
WHERE harga BETWEEN 1500000 AND 1800000;


-- 5# operator query (UNION, UNION ALL, EXISTS, ANY, ALL)
-- UNION
SELECT * FROM pemesanan WHERE harga > 1600000
UNION
SELECT * FROM pemesanan WHERE no_tiket LIKE 'SQ0%';

-- UNION ALL
SELECT * FROM pemesanan WHERE harga > 1600000
UNION ALL
SELECT * FROM pemesanan WHERE no_tiket LIKE 'SQ0%';

-- EXISTS 
SELECT * FROM pemesanan
WHERE EXISTS (SELECT 1 FROM pemesanan WHERE harga > 1700000);

-- ANY
SELECT * FROM pemesanan
WHERE harga > ANY (SELECT harga FROM pemesanan WHERE no_tiket = 'SQ002');

-- ALL
SELECT * FROM pemesanan
WHERE harga > ALL (SELECT harga FROM pemesanan WHERE no_tiket = 'SQ001');


-- 6# operator pengurutan dan pengelompokan (ORDER BY, GROUP BY, HAVING)
-- ORDER BY
SELECT * FROM pemesanan
ORDER BY harga DESC;

-- GROUP BY
SELECT harga, COUNT(*) AS jumlah_penumpang
FROM pemesanan
GROUP BY harga;

-- HAVING
SELECT harga, COUNT(*) AS jumlah_penumpang
FROM pemesanan
GROUP BY harga
HAVING COUNT(*) > 1;


-- #7 operator lainnya (AS, CASE, DISTINCT, INTO, LIMIT)
-- AS 
SELECT harga AS price FROM pemesanan;

-- CASE
SELECT harga,
       CASE 
           WHEN harga > 1500000 THEN 'mahal'
           ELSE 'murah'
       END AS Harga_Kategori
FROM pemesanan;

-- DISTINCT
SELECT DISTINCT harga FROM pemesanan;

-- LIMIT
SELECT * FROM pemesanan
LIMIT 3;


-- 8# operator function (MIN(), MAX(), COUNT(), SUM(), AVG(), IF() IFNULL(), COALESCE ())
-- MIN()
SELECT MIN(harga) AS harga_min FROM pemesanan;

--  MAX()
SELECT MAX(harga) AS harga_max FROM pemesanan;

-- COUNT()
SELECT COUNT(*) AS total_penumpang FROM pemesanan;

-- SUM()
SELECT SUM(harga) AS total_pendapatan FROM pemesanan;

-- AVG()
SELECT AVG(harga) AS harga_rata_rata FROM pemesanan;

-- IF()
SELECT harga, IF(harga > 1500000, 'Diatas', 'Dibawah') AS harga_status
FROM pemesanan;

-- IFNULL()
SELECT IFNULL(no_tiket, 'Tidak Ada Tiket') AS nnomor_tiket FROM pemesanan;

-- COALESCE()
SELECT COALESCE(no_tiket, 'Tidak Ada Tiket') AS nomor_tiket FROM pemesanan;


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
SELECT p.nama AS 'Nama Penumpang', pem.no_tiket AS 'Nomor Tiket', pem.harga AS 'Harga'
FROM penumpang p
INNER JOIN pemesanan pem ON p.id_penumpang = pem.id_penumpang;

-- LEFT JOIN
SELECT p.nama AS 'Nama Penumpang', pem.no_tiket AS 'Nomor Tiket', pem.harga AS 'Harga'
FROM penumpang p
LEFT JOIN pemesanan pem ON p.id_penumpang = pem.id_penumpang;

-- RIGHT JOIN 
SELECT p.nama AS 'Nama Penumpang', pem.no_tiket AS 'Nomor Tiket', pem.harga AS 'Harga'
FROM penumpang p
RIGHT JOIN pemesanan pem ON p.id_penumpang = pem.id_penumpang;

-- FULL JOIN
SELECT p.nama AS 'Nama Penumpang', pem.no_tiket AS 'Nomor Tiket', pem.harga AS 'Harga'
FROM penumpang p
LEFT JOIN pemesanan pem ON p.id_penumpang = pem.id_penumpang

UNION

SELECT p.nama AS 'Nama Penumpang', pem.no_tiket AS 'Nomor Tiket', pem.harga AS 'Harga'
FROM penumpang p
RIGHT JOIN pemesanan pem ON p.id_penumpang = pem.id_penumpang;

-- SELF JOIN
SELECT a.nama AS 'Passenger 1', b.nama AS 'Passenger 2', a.jenis_kelamin AS 'Gender'
FROM penumpang a
JOIN penumpang b ON a.jenis_kelamin = b.jenis_kelamin AND a.id_penumpang < b.id_penumpang; 
