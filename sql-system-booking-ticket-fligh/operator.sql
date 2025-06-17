-- CREATE: table
CREATE TABLE operator (
    id_operator VARCHAR(10) PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    nama_operator VARCHAR(100) NOT NULL
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





    
-- SELECT: menampilkan operator bernama 'LION AIR'
SELECT * FROM operator
WHERE nama_operator = 'LION AIR';
