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
CREATE TABLE operator (
    id_operator CHAR(3) UNIQUE PRIMARY KEY,
    email VARCHAR(30) NOT NULL,
    nama_operator VARCHAR(30) NOT NULL
);


-- INSERT: data
INSERT INTO operator (id_operator, email, nama_operator) VALUES
('OP1', 'KONTAK@GARUDA-INDONESIA.COM', 'GARUDA INDONESIA'),
('OP2', 'KONTAK@LIONAIR.CO.ID', 'LION AIR'),
('OP3', 'KONTAK@CITILINK.CO.ID', 'CITILINK'),
('OP4', 'KONTAK@LIONAIR.CO.ID', 'LION AIR'),
('OP5', 'KONTAK@GARUDA-INDONESIA.COM', 'GARUDA INDONESIA');
    --  SELECT: awalnya data
    SELECT * FROM operator;


-- ALTER: menambah kolom tabel
ALTER TABLE operator
ADD medsos VARCHAR(20) default 'test';
    -- SELECT: menambah kolom
    SELECT * FROM operator;


-- ALTER: mengubah nama kolomtabel
ALTER TABLE operator
CHANGE medsos media_sosial VARCHAR(20) default 'test';
    -- SELECT: mengubah kolom
    SELECT * FROM operator;


--  ALTER: menghapus kolom tabel
ALTER TABLE operator
DROP COLUMN media_sosial;
    -- SELECT: menambah kolom
    SELECT * FROM operator;


-- DROP: menghapus tabel
-- DROP TABLE operator;


-- TRUNCATE: menghapus isi data tabel
-- TRUNCATE TABLE operator;


-- UPDATE: ubah email untuk operator OP2
UPDATE operator
SET email = 'KONTAK@LIONAIR-INDONESIA.CO.ID'
WHERE id_operator = 'OP2';
    --  SELECT: setelah di ubah
    SELECT * FROM operator;


-- DELETE: hapus operator dengan operator_id OP5
DELETE FROM operator
WHERE id_operator = 'OP5';
    --  SELECT: setelah di hapus
    SELECT * FROM operator;


/*
-- CREATE PROCEDURE
CREATE PROCEDURE semua_operator
AS
SELECT * FROM operator
GO;
    -- EXEC: mengeksekusi prosedur tersebut 
    EXEC semua_operator;


-- CREATE INDEX
CREATE INDEX idx_nama_operator
ON operator(nama_operator);
    -- DROP INDEX: menghapus index tersebut
    ALTER TABLE operator
    DROP INDEX idx_nama_operator;


-- CREATE VIEW
CREATE VIEW [garuda indonesia] AS
SELECT * FROM operator
WHERE nama_operator = 'GARUDA INDONESIA';
    -- SELECT: menampilkan prosedur tersebut
    SELECT * FROM [garuda indonesia];
*/





-- **CONTOH SEMUA PENGGUNAAN OPERATOR**

-- 1# operator logika (AND, OR, NOT)
SELECT * FROM operator 
WHERE nama_operator = 'GARUDA INDONESIA' AND email LIKE '%@GARUDA-INDONESIA.COM';

SELECT * FROM operator 
WHERE id_operator = 'OP1' OR id_operator = 'OP2';

SELECT * FROM operator 
WHERE NOT email LIKE '%@LIONAIR.CO.ID';



-- 2# operator NULL (IS NULL, IS NOT NULL)
SELECT * FROM operator 
WHERE email IS NULL;

SELECT * FROM operator 
WHERE email IS NOT NULL;



-- 3# operator pencocokan pola (LIKE)
SELECT * FROM operator 
WHERE email LIKE '%@GARUDA-INDONESIA.COM';



-- 4# operator set (IN, BETWEEN)
SELECT * FROM operator 
WHERE id_operator IN ('OP1', 'OP2');



-- 5# operator query (UNION, UNION ALL, EXISTS, ANY, ALL)
CREATE TABLE backup_operator (
    id_operator CHAR(3) PRIMARY KEY,
    email VARCHAR(30) NOT NULL,
    nama_operator VARCHAR(30) NOT NULL
);

INSERT INTO backup_operator VALUES 
('OP6', 'KONTAK@SRIWIJAYA.COM', 'SRIWIJAYA'),
('OP1', 'KONTAK@GARUDA-INDONESIA.COM', 'GARUDA INDONESIA');

-- UNION 
SELECT id_operator FROM operator
UNION
SELECT id_operator FROM backup_operator;

-- UNION ALL
SELECT id_operator FROM operator
UNION ALL
SELECT id_operator FROM backup_operator;

-- EXISTS
SELECT nama_operator 
FROM operator o
WHERE EXISTS (
    SELECT 1 FROM backup_operator b 
    WHERE b.id_operator = o.id_operator
);

-- ANY/ALL
SELECT * FROM operator
WHERE id_operator = ANY (SELECT id_operator FROM backup_operator);



-- 6# Sorting and grouping operators (ORDER BY, GROUP BY, HAVING)
-- ORDER BY
SELECT * FROM operator
ORDER BY nama_operator ASC;  

-- GROUP BY 
SELECT email, COUNT(*) as operator_count
FROM operator
GROUP BY email
HAVING operator_count > 1; 



-- 7# operator lainnya (AS, CASE, DISTINCT, INTO, LIMIT)
-- AS
SELECT id_operator AS operator_id, nama_operator AS name FROM operator;

-- CASE
SELECT id_operator, nama_operator,
    CASE 
        WHEN email LIKE '%@GARUDA-INDONESIA.COM' THEN 'GARUDA'
        WHEN email LIKE '%@LIONAIR.CO.ID' THEN 'LION AIR'
        ELSE 'Other'
    END AS airline
FROM operator;

-- DISTINCT
SELECT DISTINCT email FROM operator;

-- INTO 
CREATE TABLE operator_copy AS
SELECT * FROM operator;

-- LIMIT
SELECT * FROM operator LIMIT 2;



-- 8# operator function (MIN(), MAX(), COUNT(), IF() IFNULL(), COALESCE ())
-- MIN()
SELECT MIN(id_operator) AS min_operator_id FROM operator;

-- MAX()
SELECT MAX(id_operator) AS max_operator_id FROM operator;

-- COUNT()
SELECT COUNT(*) AS total_operators FROM operator;

-- IF()
SELECT id_operator, 
       IF(nama_operator = 'GARUDA INDONESIA', 'Yes', 'No') AS is_garuda 
FROM operator;

-- IFNULL()
SELECT id_operator, 
       IFNULL(email, 'No Email') AS email_address 
FROM operator;

-- COALESCE()
SELECT id_operator, 
       COALESCE(email, 'No Email', 'Unknown') AS email_address 
FROM operator;



-- 9# operator JOIN (INNER JOIN, RIGHT JOIN, LEFT JOIN, FULL JOIN)
CREATE TABLE department (
    id_department CHAR(2) UNIQUE PRIMARY KEY,
    ceo_name VARCHAR(30) NOT NULL,
    id_operator CHAR(3),
    FOREIGN KEY (id_operator) REFERENCES operator(id_operator)
);

INSERT INTO department (id_department, ceo_name, id_operator) VALUES
('D1', 'Tsani Panjaitan', 'OP1'),
('D2', 'Daniel Putut', 'OP2'),
('D3', 'Dewa Kadek Rai', 'OP3'),
('D4', 'Daniel Putut', 'OP4'),
('D5', 'Tsani Panjaitan', NULL);

-- INNER JOIN
SELECT o.id_operator, o.nama_operator, d.ceo_name
FROM operator o
INNER JOIN department d ON o.id_operator = d.id_operator;

-- LEFT JOIN
SELECT o.id_operator, o.nama_operator, d.ceo_name
FROM operator o
LEFT JOIN department d ON o.id_operator = d.id_operator;

-- RIGHT JOIN
SELECT o.id_operator, o.nama_operator, d.ceo_name
FROM operator o
RIGHT JOIN department d ON o.id_operator = d.id_operator;

-- FULL JOIN (LEFT + RIGHT JOIN)
SELECT o.id_operator, o.nama_operator, d.ceo_name
FROM operator o
LEFT JOIN department d ON o.id_operator = d.id_operator

UNION

SELECT o.id_operator, o.nama_operator, d.ceo_name
FROM operator o
RIGHT JOIN department d ON o.id_operator = d.id_operator;
