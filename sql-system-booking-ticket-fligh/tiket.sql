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
    jadwal TIME,
    CONSTRAINT chk_jadwal CHECK (jadwal BETWEEN '04:00:00' AND '23:00:00')
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
-- AND
SELECT * FROM tiket
WHERE tanggal_penerbangan = '2025-04-05' AND jadwal = '13:15:00';

-- OR
SELECT * FROM tiket
WHERE tanggal_penerbangan = '2025-04-05' OR tanggal_penerbangan = '2025-04-10';

-- NOT
SELECT * FROM tiket
WHERE NOT tanggal_penerbangan = '2025-04-05';


-- 2# operator NULL (IS NULL, IS NOT NULL)
-- IS NULL
SELECT * FROM tiket
WHERE id_kursi IS NULL;

-- IS NOT NULL
SELECT * FROM tiket
WHERE id_kursi IS NOT NULL;


-- 3# operator pencocokan pola (LIKE)
SELECT * FROM tiket
WHERE no_tiket LIKE 'SQ%';


-- 4# operator set (IN, BETWEEN)
-- IN
SELECT * FROM tiket
WHERE no_tiket IN ('SQ001', 'SQ003');

-- BETWEEN
SELECT * FROM tiket
WHERE tanggal_penerbangan BETWEEN '2025-04-05' AND '2025-04-08';


-- 5# operator query (UNION, UNION ALL, EXISTS, ANY, ALL)
-- UNION
SELECT no_tiket FROM tiket WHERE id_kursi = '45A'
UNION
SELECT no_tiket FROM tiket WHERE id_kursi = '07A';

-- UNION ALL
SELECT no_tiket FROM tiket WHERE id_kursi = '45A'
UNION ALL
SELECT no_tiket FROM tiket WHERE id_kursi = '07A';

-- EXISTS
SELECT * FROM tiket
WHERE EXISTS (SELECT 1 FROM tiket WHERE id_pemesanan = 'PM001');

-- ANY
SELECT * FROM tiket
WHERE tanggal_penerbangan > ANY (SELECT tanggal_penerbangan FROM tiket WHERE id_pemesanan = 'PM001');

-- ALL
SELECT * FROM tiket
WHERE tanggal_penerbangan > ALL (SELECT tanggal_penerbangan FROM tiket WHERE id_pemesanan = 'PM001');


-- 6# operator pengurutan dan pengelompokan (ORDER BY, GROUP BY, HAVING)
-- ORDER BY
SELECT * FROM tiket
ORDER BY tanggal_penerbangan;

-- GROUP BY
SELECT tanggal_penerbangan, COUNT(*) AS jumlah_tiket
FROM tiket
GROUP BY tanggal_penerbangan;

-- HAVING
SELECT tanggal_penerbangan, COUNT(*) AS jumlah_tiket
FROM tiket
GROUP BY tanggal_penerbangan
HAVING COUNT(*) > 1;


-- #7 operator lainnya (AS, CASE, DISTINCT, INTO, LIMIT)
-- AS
SELECT no_tiket AS 'Nomor Tiket', tanggal_penerbangan AS 'Tanggal Penerbangan' FROM tiket;

-- CASE
SELECT no_tiket,
       CASE 
           WHEN jadwal < '12:00:00' THEN 'Pagi'
           WHEN jadwal < '18:00:00' THEN 'Siang'
           ELSE 'Malam'
       END AS 'Waktu Penerbangan'
FROM tiket;

-- DISTINCT
SELECT DISTINCT tanggal_penerbangan FROM tiket;

-- INTO
CREATE TABLE IF NOT EXISTS tiket_summary AS
SELECT tanggal_penerbangan, COUNT(*) AS jumlah_tiket
FROM tiket
GROUP BY tanggal_penerbangan;

-- LIMIT
SELECT * FROM tiket
LIMIT 3;


-- 8# operator function (MIN(), MAX(), COUNT(), IF() IFNULL(), COALESCE ())
-- MIN()
SELECT MIN(tanggal_penerbangan) AS 'Tanggal Penerbangan Terawal' FROM tiket;

-- MAX()
SELECT MAX(tanggal_penerbangan) AS 'Tanggal Penerbangan Terakhir' FROM tiket;

-- COUNT()
SELECT COUNT(*) AS 'Total Tiket' FROM tiket;

-- IF()
SELECT no_tiket, 
       IF(jadwal < '12:00:00', 'Pagi', 'Siang/Malam') AS 'Waktu'
FROM tiket;

-- IFNULL()
SELECT no_tiket, IFNULL(id_kursi, 'Tidak Ada Kursi') AS 'Kursi'
FROM tiket;

-- COALESCE()
SELECT no_tiket, COALESCE(id_kursi, 'Tidak Ada Kursi') AS 'Kursi'
FROM tiket;


-- 9# operator JOIN (INNER JOIN, RIGHT JOIN, LEFT JOIN, FULL JOIN)
CREATE TABLE kursi (
    id_kursi CHAR(3) UNIQUE PRIMARY KEY,
    class ENUM('EKONOMI', 'FIRST CLASS', 'BISNIS'),
    availability ENUM('TERSEDIA', 'TERISI'),
    id_operator CHAR(3) UNIQUE,
    pembayaran ENUM('DEBIT', 'CREDIT', 'CASH')
);


INSERT INTO kursi (id_kursi, class, availability, id_operator, pembayaran) VALUES
('45A', 'EKONOMI', 'TERSEDIA', 'OP1', 'DEBIT'),
('07A', 'FIRST CLASS', 'TERSEDIA', 'OP2', 'CASH'),
('50A', 'EKONOMI', 'TERSEDIA', 'OP3', 'CREDIT'),
('53D', 'EKONOMI', 'TERSEDIA', 'OP4', 'DEBIT'),
('42E', 'BISNIS', 'TERISI', 'OP5', 'CASH');
-- INNER JOIN
SELECT t.no_tiket AS 'Nomor Tiket', t.tanggal_penerbangan AS 'Tanggal Penerbangan', k.class AS 'Kelas', k.availability AS 'Ketersediaan'
FROM tiket t
INNER JOIN kursi k ON t.id_kursi = k.id_kursi;

-- LEFT JOIN
SELECT t.no_tiket AS 'Nomor Tiket', t.tanggal_penerbangan AS 'Tanggal Penerbangan', k.class AS 'Kelas', k.availability AS 'Ketersediaan'
FROM tiket t
LEFT JOIN kursi k ON t.id_kursi = k.id_kursi;

-- RIGHT JOIN 
SELECT t.no_tiket AS 'Nomor Tiket', t.tanggal_penerbangan AS 'Tanggal Penerbangan', k.class AS 'Kelas', k.availability AS 'Ketersediaan'
FROM tiket t
RIGHT JOIN kursi k ON t.id_kursi = k.id_kursi;

-- FULL JOIN 
SELECT t.no_tiket AS 'Nomor Tiket', t.tanggal_penerbangan AS 'Tanggal Penerbangan', k.class AS 'Kelas', k.availability AS 'Ketersediaan'
FROM tiket t
LEFT JOIN kursi k ON t.id_kursi = k.id_kursi

UNION

SELECT t.no_tiket AS 'Nomor Tiket', t.tanggal_penerbangan AS 'Tanggal Penerbangan', k.class AS 'Kelas', k.availability AS 'Ketersediaan'
FROM tiket t
RIGHT JOIN kursi k ON t.id_kursi = k.id_kursi;
