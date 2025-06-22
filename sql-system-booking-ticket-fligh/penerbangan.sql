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




-- **CONTOH SEMUA PENGGUNAAN OPERATOR**

-- 1# operator logika (AND, OR, NOT)
-- AND
SELECT * FROM penerbangan 
WHERE status_penerbangan = 'AKTIF' AND id_operator = 'OP1';

-- OR
SELECT * FROM penerbangan 
WHERE status_penerbangan = 'DITUNDA' OR status_penerbangan = 'DIBATALKAN';

-- NOT
SELECT * FROM penerbangan 
WHERE NOT status_penerbangan = 'AKTIF';


-- 2# operator NULL (IS NULL, IS NOT NULL)
-- IS NULL
SELECT * FROM penerbangan 
WHERE id_operator IS NULL; 

-- IS NOT NULL
SELECT * FROM penerbangan 
WHERE id_operator IS NOT NULL;


-- 3# operator pencocokan pola (LIKE)
-- LIKE
SELECT * FROM penerbangan 
WHERE id_operator LIKE 'OP%';


-- 4# operator set (IN)
-- IN
SELECT * FROM penerbangan 
WHERE status_penerbangan IN ('AKTIF', 'DITUNDA');  


-- 5# operator query (UNION, UNION ALL, EXISTS, ANY, ALL)
-- 9. UNION
CREATE TABLE penerbangan_backup (
    id_maskapai VARCHAR(10) PRIMARY KEY,
    id_operator VARCHAR(10),
    status_penerbangan ENUM('AKTIF', 'DITUNDA', 'DIBATALKAN')
);

INSERT INTO penerbangan_backup (id_maskapai, id_operator, status_penerbangan) VALUES
('M006', 'OP6', 'AKTIF'),
('M007', 'OP7', 'DITUNDA');

SELECT id_maskapai FROM penerbangan
UNION
SELECT id_maskapai FROM penerbangan_backup;

-- 10. UNION ALL
SELECT id_maskapai FROM penerbangan
UNION ALL
SELECT id_maskapai FROM penerbangan_backup;

-- 11. EXISTS
SELECT * 
FROM penerbangan p
WHERE EXISTS (
    SELECT 1 FROM penerbangan_backup b 
    WHERE b.id_maskapai = p.id_maskapai
);

-- 12. ANY
SELECT * FROM penerbangan
WHERE id_maskapai > ANY (SELECT id_maskapai FROM penerbangan_backup);

-- 13. ALL
SELECT * FROM penerbangan
WHERE id_maskapai > ALL (SELECT id_maskapai FROM penerbangan_backup);


-- 6# operator pengurutan dan pengelompokan (ORDER BY, GROUP BY, HAVING)
-- ORDER BY
SELECT * FROM penerbangan
ORDER BY status_penerbangan ASC;

-- GROUP BY
SELECT status_penerbangan, COUNT(*) as total_penerbangan
FROM penerbangan
GROUP BY status_penerbangan;

-- HAVING
SELECT status_penerbangan, COUNT(*) as total_penerbangan
FROM penerbangan
GROUP BY status_penerbangan
HAVING total_penerbangan > 1; 


-- #7 operator lainnya (AS, CASE, DISTINCT, INTO, LIMIT)
-- AS
SELECT id_maskapai AS flight_id, status_penerbangan AS flight_status FROM penerbangan;

-- CASE
SELECT 
    id_maskapai,
    status_penerbangan,
    CASE 
        WHEN status_penerbangan = 'AKTIF' THEN 'Penerbangan Aktif'
        WHEN status_penerbangan = 'DITUNDA' THEN 'Penerbangan tertunda'
        ELSE 'Penerbangan dibatalkan'
    END AS deskripsi_status_penerbangan
FROM penerbangan;

-- DISTINCT
SELECT DISTINCT status_penerbangan FROM penerbangan;

-- INTO
CREATE TABLE penerbangan_copy AS
SELECT * FROM penerbangan;

-- LIMIT
SELECT * FROM penerbangan LIMIT 3;


-- 8# operator function (MIN(), MAX(), COUNT(), IF() IFNULL(), COALESCE ())
-- MIN() - Find the minimum id_maskapai
SELECT MIN(id_maskapai) AS min_maskapai FROM penerbangan;

-- MAX() - Find the maximum id_maskapai
SELECT MAX(id_maskapai) AS max_maskapai FROM penerbangan;

-- COUNT() - Count total number of flights
SELECT COUNT(*) AS total_penerbangan FROM penerbangan;

-- IF()
SELECT id_maskapai, status_penerbangan,
IF(status_penerbangan = 'AKTIF', 'DITUNDA', 'DIBATALKAN') AS kondisi_penerbangan
FROM penerbangan;

-- IFNULL()
INSERT INTO penerbangan (id_maskapai, id_operator, status_penerbangan) VALUES ('M006', 'OP6', NULL);
SELECT id_maskapai,
IFNULL(status_penerbangan, 'Status tidak diketahui') AS kondisi_penerbangan
FROM penerbangan;

-- COALESCE()
SELECT id_maskapai,
COALESCE(status_penerbangan, id_operator, 'Status tidak diketahui') AS info_penerbangan
FROM penerbangan;

DELETE FROM penerbangan WHERE id_maskapai = 'M006';


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
SELECT p.id_maskapai, p.id_operator, p.status_penerbangan, k.id_pesawat, k.kapasitas_kursi
FROM penerbangan p
INNER JOIN kapasitas k ON p.id_operator = k.id_kursi; 

-- LEFT JOIN
SELECT p.id_maskapai, p.id_operator, p.status_penerbangan, k.id_pesawat, k.kapasitas_kursi
FROM penerbangan p
LEFT JOIN kapasitas k ON p.id_operator = k.id_kursi; 

-- RIGHT JOIN
SELECT p.id_maskapai, p.id_operator, p.status_penerbangan, k.id_pesawat, k.kapasitas_kursi
FROM penerbangan p
RIGHT JOIN kapasitas k ON p.id_operator = k.id_kursi;

-- FULL JOIN (LEFT + RIGHT JOIN)
SELECT p.id_maskapai, p.id_operator, p.status_penerbangan, k.id_pesawat, k.kapasitas_kursi
FROM penerbangan p
LEFT JOIN kapasitas k ON p.id_operator = k.id_kursi

UNION

SELECT p.id_maskapai, p.id_operator, p.status_penerbangan, k.id_pesawat, k.kapasitas_kursi
FROM penerbangan p
RIGHT JOIN kapasitas k ON p.id_operator = k.id_kursi;
