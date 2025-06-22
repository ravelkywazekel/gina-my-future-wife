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
CREATE TABLE maskapai (
    id_maskapai CHAR(4) UNIQUE PRIMARY KEY,
    nama_maskapai ENUM('GARUDA INDONESIA', 'LION AIR', 'CITILINK'),
    website VARCHAR(30) NOT NULL
);


-- INSERT: data
INSERT INTO maskapai (id_maskapai, nama_maskapai, website) VALUES
('M001', 'GARUDA INDONESIA', 'GARUDA-INDONESIA.COM'),
('M002', 'LION AIR', 'LIONAIR.CO.ID'),
('M003', 'CITILINK', 'CITILINK.CO.ID'),
('M004', 'LION AIR', 'LIONAIR.CO.ID'),
('M005', 'GARUDA INDONESIA', 'GARUDA-INDONESIA.COM');
    --  SELECT: awalnya data
    SELECT * FROM maskapai;


-- ALTER: menambah kolom tabel
ALTER TABLE maskapai
ADD hq_operator VARCHAR(20) default 'test';
    -- SELECT: menambah kolom
    SELECT * FROM maskapai;


-- ALTER: mengubah nama kolomtabel
ALTER TABLE maskapai
CHANGE hq_operator kantor_operator VARCHAR(20) default 'test';
    -- SELECT: mengubah kolom
    SELECT * FROM maskapai;


--  ALTER: menghapus kolom tabel
ALTER TABLE maskapai
DROP COLUMN kantor_operator;
    -- SELECT: menambah kolom
    SELECT * FROM maskapai;


/*
-- DROP: menghapus tabel
DROP TABLE maskapai;


-- TRUNCATE: menghapus isi data tabel
TRUNCATE TABLE maskapai;
*/


-- UPDATE: ubah situs web untuk maskapai M002
UPDATE maskapai
SET website = 'LIONAIR-INDONESIA.CO.ID'
WHERE id_maskapai = 'M002';
    --  SELECT: setelah di ubah
    SELECT * FROM maskapai;


-- DELETE: hapus maskapai dengan airline_id M004
DELETE FROM maskapai
WHERE id_maskapai = 'M004';
    --  SELECT: setelah di hapus
    SELECT * FROM maskapai;


/*
-- CREATE PROCEDURE
CREATE PROCEDURE semua_website
AS
SELECT * FROM maskapai 
GO;
    -- EXEC: mengeksekusi prosedur tersebut 
    EXEC semua_maskapai;


-- CREATE INDEX
CREATE INDEX idx_website
ON maskapai(website);
    -- DROP INDEX: menghapus index tersebut
    ALTER TABLE maskapai
    DROP INDEX idx_website;
*/

-- CREATE VIEW
CREATE VIEW website maskapai AS
SELECT * FROM maskapai
WHERE nama_operator = 'GARUDA-INDONESIA.COM';
    -- SELECT: menampilkan prosedur tersebut
    SELECT * FROM website maskapai;




-- **CONTOH SEMUA PENGGUNAAN OPERATOR**

-- 1# operator logika (AND, OR, NOT)
-- AND
SELECT * FROM maskapai 
WHERE nama_maskapai = 'GARUDA INDONESIA' AND website LIKE '%GARUDA%';

-- OR
SELECT * FROM maskapai 
WHERE nama_maskapai = 'LION AIR' OR website LIKE '%CITILINK%';

-- NOT
SELECT * FROM maskapai 
WHERE NOT nama_maskapai = 'CITILINK';

-- 2# operator NULL (IS NULL, IS NOT NULL)
-- IS NULL
SELECT * FROM maskapai 
WHERE website IS NULL;  

-- IS NOT NULL
SELECT * FROM maskapai 
WHERE website IS NOT NULL; 


-- 3# operator pencocokan pola (LIKE)
-- LIKE
SELECT * FROM maskapai 
WHERE website LIKE 'GARUDA%';  -- websites starting with 'GARUDA'


-- 4# operator set (IN)
-- IN
SELECT * FROM maskapai 
WHERE nama_maskapai IN ('GARUDA INDONESIA', 'CITILINK'); 


-- 5# operator query (UNION, UNION ALL, EXISTS, ANY, ALL)
-- UNION
CREATE TABLE maskapai_backup (
    id_maskapai CHAR(4) PRIMARY KEY,
    nama_maskapai ENUM('GARUDA INDONESIA', 'LION AIR', 'CITILINK'),
    website VARCHAR(30) NOT NULL
);

INSERT INTO maskapai_backup (id_maskapai, nama_maskapai, website) VALUES
('M006', 'GARUDA INDONESIA', 'GARUDA-INDONESIA.COM'),
('M007', 'LION AIR', 'LIONAIR.CO.ID');

SELECT id_maskapai FROM maskapai
UNION
SELECT id_maskapai FROM maskapai_backup;

-- UNION ALL
SELECT id_maskapai FROM maskapai
UNION ALL
SELECT id_maskapai FROM maskapai_backup;

-- EXISTS
SELECT * 
FROM maskapai m
WHERE EXISTS (
    SELECT 1 FROM maskapai_backup b 
    WHERE b.id_maskapai = m.id_maskapai
);

-- ANY
SELECT * FROM maskapai
WHERE id_maskapai > ANY (SELECT id_maskapai FROM maskapai_backup);

-- ALL
SELECT * FROM maskapai
WHERE id_maskapai > ALL (SELECT id_maskapai FROM maskapai_backup);


-- 6# operator pengurutan dan pengelompokan (ORDER BY, GROUP BY, HAVING)
-- ORDER BY
SELECT * FROM maskapai
ORDER BY nama_maskapai ASC;  


-- GROUP BY
SELECT nama_maskapai, COUNT(*) as total_entries
FROM maskapai
GROUP BY nama_maskapai;

-- HAVING
SELECT nama_maskapai, COUNT(*) as total_entri
FROM maskapai
GROUP BY nama_maskapai
HAVING total_entri > 1;  


-- #7 operator lainnya (AS, CASE, DISTINCT, INTO, LIMIT)
-- AS
SELECT id_maskapai AS airline_id, nama_maskapai AS airline_name FROM maskapai;

-- CASE
SELECT 
    id_maskapai,
    nama_maskapai,
    CASE 
        WHEN nama_maskapai = 'GARUDA INDONESIA' THEN 'BIRU'
        WHEN nama_maskapai = 'LION AIR' THEN 'MERAH'
        ELSE 'HIJAU'
    END AS warna_maskapai
FROM maskapai;

-- DISTINCT
SELECT DISTINCT nama_maskapai FROM maskapai;

-- INTO
CREATE TABLE maskapai_copy AS
SELECT * FROM maskapai;

-- LIMIT
SELECT * FROM maskapai LIMIT 3;
