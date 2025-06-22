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
CREATE TABLE kursi (
    id_kursi CHAR(3) UNIQUE PRIMARY KEY,
    class ENUM('EKONOMI', 'FIRST CLASS', 'BISNIS'),
    availability ENUM('TERSEDIA', 'TERISI'),
    id_operator CHAR(3) UNIQUE,
    pembayaran ENUM('DEBIT', 'CREDIT', 'CASH')
);


-- INSERT: data
INSERT INTO kursi (id_kursi, class, availability, id_operator, pembayaran) VALUES
('45A', 'EKONOMI', 'TERSEDIA', 'OP1', 'DEBIT'),
('07A', 'FIRST CLASS', 'TERSEDIA', 'OP2', 'CASH'),
('50A', 'EKONOMI', 'TERSEDIA', 'OP3', 'CREDIT'),
('53D', 'EKONOMI', 'TERSEDIA', 'OP4', 'DEBIT'),
('42E', 'BISNIS', 'TERISI', 'OP5', 'CASH');
    --  SELECT: awalnya data
    SELECT * FROM kursi;  


-- ALTER: menambah kolom tabel
ALTER TABLE kursi
ADD posisi_kursi SET('DEPAN', 'TENGAH', 'BELAKANG') default 'TENGAH';
    -- SELECT: menambah kolom
    SELECT * FROM kursi;


-- ALTER: mengubah nama kolomtabel
ALTER TABLE kursi
CHANGE posisi_kursi tempat_kursi SET('DEPAN', 'TENGAH', 'BELAKANG') default 'TENGAH';
    -- SELECT: mengubah kolom
    SELECT * FROM kursi;


--  ALTER: menghapus kolom tabel
ALTER TABLE kursi
DROP COLUMN tempat_kursi;
    -- SELECT: menambah kolom
    SELECT * FROM kursi;


/*
-- DROP: menghapus tabel
DROP TABLE kursi;


-- TRUNCATE: menghapus isi data tabel
TRUNCATE TABLE kursi;
*/


-- UPDATE: tandai kursi 07A sebagai TERISI
UPDATE kursi
SET availability = 'TERISI'
WHERE id_kursi = '07A';
    --  SELECT: setelah di ubah
    SELECT * FROM kursi;


-- DELETE: hapus kursi 53D
DELETE FROM kursi
WHERE id_kursi = '53D';
    --  SELECT: setelah di hapus
    SELECT * FROM kursi;


/*
-- CREATE PROCEDURE
CREATE PROCEDURE semua_class
AS
SELECT * FROM kursi
GO;
    -- EXEC: mengeksekusi prosedur tersebut 
    EXEC semua_class;


-- CREATE INDEX
CREATE INDEX idx_class
ON kursi(class);
    -- DROP INDEX: menghapus index tersebut
    ALTER TABLE kursi
    DROP INDEX idx_class;
*/


-- CREATE VIEW
CREATE VIEW semua_kursi AS
SELECT * FROM kursi
WHERE class = 'EKONOMI';
    -- SELECT: menampilkan prosedur tersebut
    SELECT * FROM semua_kursi;




-- **CONTOH SEMUA PENGGUNAAN OPERATOR**

-- 1# operator logika (AND, OR, NOT)
-- AND
SELECT * FROM kursi 
WHERE class = 'EKONOMI' AND availability = 'TERSEDIA';

-- OR
SELECT * FROM kursi 
WHERE class = 'FIRST CLASS' OR class = 'BISNIS';

-- NOT
SELECT * FROM kursi 
WHERE NOT availability = 'TERSEDIA';


-- 2# operator NULL (IS NULL, IS NOT NULL)
-- IS NULL
SELECT * FROM kursi 
WHERE id_operator IS NULL;  -- This will return no results since all id_operator are NOT NULL

-- IS NOT NULL
SELECT * FROM kursi 
WHERE id_operator IS NOT NULL;  -- This will return all rows


-- 3# operator penyesuaian pola (LIKE)
-- LIKE
SELECT * FROM kursi 
WHERE id_kursi LIKE '5%';


-- 4# operator set (IN, BETWEEN)
-- IN
SELECT * FROM kursi 
WHERE class IN ('EKONOMI', 'BISNIS');  -- Select specific classes

-- BETWEEN
SELECT * FROM kursi 
WHERE id_kursi BETWEEN '45A' AND '50A';  -- Select id_kursi in a range


-- 5# operator query (UNION, UNION ALL, EXISTS, ANY, ALL)
-- UNION
CREATE TABLE kursi_backup (
    id_kursi CHAR(3) PRIMARY KEY,
    class ENUM('EKONOMI', 'FIRST CLASS', 'BISNIS'),
    availability SET('TERSEDIA', 'TERISI'),
    id_operator CHAR(3),
    pembayaran ENUM('DEBIT', 'CREDIT', 'CASH')
);

INSERT INTO kursi_backup (id_kursi, class, availability, id_operator, pembayaran) VALUES
('99Z', 'EKONOMI', 'TERSEDIA', 'OP6', 'CASH'),
('88Y', 'FIRST CLASS', 'TERISI', 'OP7', 'DEBIT');

SELECT id_kursi FROM kursi
UNION
SELECT id_kursi FROM kursi_backup;

-- UNION ALL
SELECT id_kursi FROM kursi
UNION ALL
SELECT id_kursi FROM kursi_backup;

-- EXISTS
SELECT * 
FROM kursi k
WHERE EXISTS (
    SELECT 1 FROM kursi_backup b 
    WHERE b.id_kursi = k.id_kursi
);

-- ANY
SELECT * FROM kursi
WHERE id_kursi > ANY (SELECT id_kursi FROM kursi_backup);

-- ALL
SELECT * FROM kursi
WHERE id_kursi > ALL (SELECT id_kursi FROM kursi_backup);


-- 6# operator pengurutan dan pengelompokan (ORDER BY, GROUP BY, HAVING)
-- ORDER BY
SELECT * FROM kursi
ORDER BY class ASC;

-- GROUP BY
SELECT class, COUNT(*) as total_class
FROM kursi
GROUP BY class;

-- HAVING
SELECT pembayaran, COUNT(*) as total_pembayaran
FROM kursi
GROUP BY pembayaran 
HAVING total_pembayaran > 1;


-- #7 operator lainnya (AS, CASE, DISTINCT, INTO, LIMIT)
-- AS
SELECT id_kursi AS seat_id, class AS seat_class FROM kursi;

-- DISTINCT
SELECT DISTINCT class FROM kursi;

-- INTO
CREATE TABLE kursi_copy AS
SELECT * FROM kursi;

-- LIMIT
SELECT * FROM kursi LIMIT 3;

-- CASE
SELECT 
    id_kursi,
    class,
    CASE 
        WHEN class = 'EKONOMI' THEN 'Class Biasa'
        WHEN class = 'FIRST CLASS' THEN 'Class Deluxe'
        ELSE 'Premium Premium'
    END AS deskripsi_class
FROM kursi;


-- 8# operator function (MIN(), MAX(), COUNT(), IF() IFNULL(), COALESCE ())
-- MIN()
SELECT MIN(id_kursi) AS min_kursi FROM kursi;

-- MAX() 
SELECT MAX(id_kursi) AS max_kursi FROM kursi;

-- COUNT()
SELECT COUNT(*) AS total_kursi FROM kursi;

-- IF()
SELECT 
    id_kursi,
    IF(availability, 'TERSEDIA', 'TERISI') AS availability_status
FROM kursi;

-- IFNULL() 
INSERT INTO kursi (id_kursi, class, availability, id_operator, pembayaran) VALUES ('99Z', NULL, 'TERSEDIA', 'OP6', 'CASH');
SELECT 
    id_kursi,
    IFNULL(class, 'Tidak ada class') AS seat_class
FROM kursi;

-- 8. COALESCE()
SELECT id_kursi,
    COALESCE(class, id_operator, 'Tidak Ada Informasi') AS seat_info
FROM kursi;


-- 9# operator JOIN (INNER JOIN, RIGHT JOIN, LEFT JOIN, FULL JOIN)
CREATE TABLE operator (
    id_operator CHAR(3) UNIQUE PRIMARY KEY,
    email VARCHAR(30) NOT NULL,
    nama_operator VARCHAR(30) NOT NULL
);

INSERT INTO operator (id_operator, email, nama_operator) VALUES
('OP1', 'KONTAK@GARUDA-INDONESIA.COM', 'GARUDA INDONESIA'),
('OP2', 'KONTAK@LIONAIR.CO.ID', 'LION AIR'),
('OP3', 'KONTAK@CITILINK.CO.ID', 'CITILINK'),
('OP4', 'KONTAK@LIONAIR.CO.ID', 'LION AIR'),
('OP5', 'KONTAK@GARUDA-INDONESIA.COM', 'GARUDA INDONESIA');

-- INNER JOIN
SELECT k.id_kursi, k.class, k.availability, o.nama_operator
FROM kursi k
INNER JOIN operator o ON k.id_operator = o.id_operator;

-- LEFT JOIN
SELECT k.id_kursi, k.class, k.availability, o.nama_operator
FROM kursi k
LEFT JOIN operator o ON k.id_operator = o.id_operator;

-- RIGHT JOIN
SELECT k.id_kursi, k.class, k.availability, o.nama_operator
FROM kursi k
RIGHT JOIN operator o ON k.id_operator = o.id_operator;

-- FULL JOIN (LEFT + RIGHT JOIN)
SELECT k.id_kursi, k.class, k.availability, o.nama_operator
FROM kursi k
LEFT JOIN operator o ON k.id_operator = o.id_operator

UNION

SELECT k.id_kursi, k.class, k.availability, o.nama_operator
FROM kursi k
RIGHT JOIN operator o ON k.id_operator = o.id_operator;
