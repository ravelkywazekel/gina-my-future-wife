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
CREATE TABLE tujuan (
    antrian INT PRIMARY KEY AUTO_INCREMENT,
    id_pesawat VARCHAR(5) UNIQUE,
    id_penumpang VARCHAR(4) UNIQUE,
    tujuan_pesawat VARCHAR(15) NOT NULL
);


-- INSERT: data
INSERT INTO tujuan (id_pesawat, id_penumpang, tujuan_pesawat) VALUES
('PE001', 'P001', 'JAKARTA'),
('PE002', 'P002', 'BALI'),
('PE003', 'P003', 'SURABAYA'),
('PE004', 'P004', 'PADANG'),
('PE005', 'P005', 'PEKANBARU');
    --  SELECT: awalnya data
    SELECT * FROM tujuan;

        
-- ALTER: menambah kolom tabel
ALTER TABLE tujuan 
ADD transit VARCHAR(15) default 'test';
    -- SELECT: menambah kolom
    SELECT * FROM tujuan;


-- ALTER: mengubah nama kolomtabel
ALTER TABLE tujuan 
CHANGE transit tempat_transit VARCHAR(15) default 'test';
    -- SELECT: mengubah kolom
    SELECT * FROM tujuan;


--  ALTER: menghapus kolom tabel
ALTER TABLE tujuan 
DROP COLUMN tempat_transit;
    -- SELECT: menambah kolom
    SELECT * FROM tujuan;


/*
-- DROP: menghapus tabel
DROP TABLE tujuan;


-- TRUNCATE: menghapus isi data tabel
TRUNCATE TABLE tujuan;
*/


-- UPDATE: ubah tujuan untuk penumpang P003 pada penerbangan PE003
UPDATE tujuan
SET tujuan_pesawat = 'MALANG'
WHERE id_pesawat = 'PE003' AND id_penumpang = 'P003';
    --  SELECT: setelah di ubah
    SELECT * FROM tujuan;


/*
-- DELETE: hapus catatan tujuan untuk penumpang P005 pada penerbangan PE005
DELETE FROM tujuan
WHERE id_pesawat = 'PE005' AND id_penumpang = 'P005';
    --  SELECT: setelah di hapus
    SELECT * FROM tujuan;
*/


/*
-- CREATE PROCEDURE
CREATE PROCEDURE semua_tujuan
AS
SELECT * FROM tujuan
GO;
    -- EXEC: mengeksekusi prosedur tersebut 
    EXEC semua_tujuan;


-- CREATE INDEX
CREATE INDEX idx_id_penumpang
ON tujuan(id_penumpang);
    -- DROP INDEX: menghapus index tersebut
    ALTER TABLE tujuan
    DROP INDEX idx_id_penumpang;
*/


-- CREATE VIEW
CREATE VIEW tujuan_destinasi AS
SELECT * FROM tujuan
WHERE tujuan_pesawat = 'PADANG';
    -- SELECT: menampilkan prosedur tersebut
    SELECT * FROM tujuan_destinasi;





-- **CONTOH SEMUA PENGGUNAAN OPERATOR**

-- 1# operator logika (AND, OR, NOT)
-- AND
SELECT * FROM tujuan 
WHERE tujuan_pesawat = 'BALI' AND id_penumpang = 'P002';

-- OR
SELECT * FROM tujuan 
WHERE tujuan_pesawat = 'JAKARTA' OR tujuan_pesawat = 'BALI';

-- NOT
SELECT * FROM tujuan 
WHERE NOT tujuan_pesawat = 'SURABAYA';


-- 2# operator NULL (IS NULL, IS NOT NULL)
-- IS NULL
SELECT * FROM tujuan 
WHERE id_penumpang IS NULL;  

-- IS NOT NULL
SELECT * FROM tujuan 
WHERE id_penumpang IS NOT NULL;  


-- 3# operator pencocokan pola (LIKE)
-- LIKE
SELECT * FROM tujuan 
WHERE tujuan_pesawat LIKE 'JAK%';

        
-- 4# operator set (IN)
-- IN
SELECT * FROM tujuan 
WHERE tujuan_pesawat IN ('BALI', 'SURABAYA');


-- 5# operator query (UNION, UNION ALL, EXISTS, ANY, ALL)
-- UNION
CREATE TABLE tujuan_backup (
    antrian INT PRIMARY KEY AUTO_INCREMENT,
    id_pesawat VARCHAR(5) UNIQUE,
    id_penumpang VARCHAR(4) UNIQUE,
    tujuan_pesawat VARCHAR(15) NOT NULL
);

INSERT INTO tujuan_backup (id_pesawat, id_penumpang, tujuan_pesawat) VALUES
('PE006', 'P006', 'MEDAN'),
('PE007', 'P007', 'YOGYAKARTA');

SELECT id_penumpang FROM tujuan
UNION
SELECT id_penumpang FROM tujuan_backup;

-- UNION ALL
SELECT id_penumpang FROM tujuan
UNION ALL
SELECT id_penumpang FROM tujuan_backup;

-- EXISTS
SELECT * 
FROM tujuan t
WHERE EXISTS (
    SELECT 1 FROM tujuan_backup b 
    WHERE b.id_penumpang = t.id_penumpang
);

-- ANY
SELECT * FROM tujuan
WHERE antrian > ANY (SELECT antrian FROM tujuan_backup);

-- ALL
SELECT * FROM tujuan
WHERE antrian > ALL (SELECT antrian FROM tujuan_backup);


-- 6# operator pengurutan dan pengelompokan (ORDER BY, GROUP BY, HAVING)
-- ORDER BY
SELECT * FROM tujuan
ORDER BY tujuan_pesawat DESC;

-- GROUP BY
SELECT tujuan_pesawat, COUNT(*) as total_penerbangan
FROM tujuan
GROUP BY tujuan_pesawat;

-- HAVING
SELECT tujuan_pesawat, COUNT(*) as total_penerbangan
FROM tujuan
GROUP BY tujuan_pesawat
HAVING total_penerbangan > 1; 


-- #7 operator lainnya (AS, CASE, DISTINCT, INTO, LIMIT)
-- AS
SELECT id_penumpang AS passenger_id, tujuan_pesawat AS destinasi_pesawat FROM tujuan;

-- CASE
SELECT 
    id_penumpang,
    tujuan_pesawat,
    CASE 
        WHEN tujuan_pesawat = 'BALI' THEN 'Tujuan Populer'
        ELSE 'Tujuan Lainnya'
    END AS deskripsi_tujuan
FROM tujuan;

-- DISTINCT
SELECT DISTINCT tujuan_pesawat FROM tujuan;

-- INTO
CREATE TABLE tujuan_copy AS
SELECT * FROM tujuan;

-- LIMIT
SELECT * FROM tujuan LIMIT 3;


-- 8# operator function (MIN(), MAX(), COUNT(), IF() IFNULL(), COALESCE ())
-- MIN()
SELECT MIN(antrian) AS min_antrian FROM tujuan;

-- MAX()
SELECT MAX(antrian) AS max_antrian FROM tujuan;

-- COUNT()
SELECT COUNT(*) AS total_entries FROM tujuan;

-- IF()
SELECT id_penumpang, tujuan_pesawat, IF(tujuan_pesawat = 'BALI', 'PADANG', 'PEKANBARU') AS tujuan_jenis
FROM tujuan;

-- IFNULL() 
INSERT INTO tujuan (id_pesawat, id_penumpang, tujuan_pesawat) VALUES ('PE008', NULL, 'UNKNOWN');
SELECT id_penumpang, 
IFNULL(tujuan_pesawat, 'Destinasi tidak diketahui') AS status_destinasi
FROM tujuan;

-- COALESCE()
SELECT id_penumpang, 
COALESCE(tujuan_pesawat, 'Tidak ada destinasi') AS info_destinasi
FROM tujuan;

DELETE FROM tujuan WHERE id_pesawat = 'PE008';


-- 9# operator JOIN (INNER JOIN, RIGHT JOIN, LEFT JOIN, FULL JOIN)
CREATE TABLE penumpang (
    id_penumpang CHAR(4) PRIMARY KEY,
    nama VARCHAR(20) NOT NULL,
    jenis_kelamin ENUM('WANITA', 'PRIA') DEFAULT 'PRIA',
    antrian INT,
    FOREIGN KEY (antrian) REFERENCES tujuan(antrian)
);

-- Insert sample data into the penumpang table
INSERT INTO penumpang (id_penumpang, nama, jenis_kelamin, antrian) VALUES 
('P001', 'DINAR DANISH', 'WANITA', 1),
('P002', 'NILAM SARI', 'WANITA', 2),
('P003', 'ABI SYAHLI', 'PRIA', 3),
('P004', 'ZENDAYA', 'WANITA', 4),
('P005', 'ABU LAHAB', 'PRIA', 5);

-- INNER JOIN
SELECT p.id_penumpang, p.nama, p.jenis_kelamin, t.tujuan_pesawat
FROM penumpang p
INNER JOIN tujuan t ON p.antrian = t.antrian;

-- LEFT JOIN
SELECT p.id_penumpang, p.nama, p.jenis_kelamin, t.tujuan_pesawat
FROM penumpang p
LEFT JOIN tujuan t ON p.antrian = t.antrian;

-- FIGHT JOIN
SELECT p.id_penumpang, p.nama, p.jenis_kelamin, t.tujuan_pesawat
FROM penumpang p
RIGHT JOIN tujuan t ON p.antrian = t.antrian;

-- FULL JOIN (LEFT + RIGHT JOIN)
SELECT p.id_penumpang, p.nama, p.jenis_kelamin, t.tujuan_pesawat
FROM penumpang p
LEFT JOIN tujuan t ON p.antrian = t.antrian

UNION

SELECT p.id_penumpang, p.nama, p.jenis_kelamin, t.tujuan_pesawat
FROM penumpang p
RIGHT JOIN tujuan t ON p.antrian = t.antrian;
