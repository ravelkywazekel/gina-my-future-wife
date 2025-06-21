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





