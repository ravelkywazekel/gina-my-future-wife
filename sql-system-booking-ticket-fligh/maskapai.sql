-- CREATE: table
CREATE TABLE maskapai (
    id_maskapai CHAR(4) UNIQUE PRIMARY KEY,
    nama_maskapai ENUM('GARUDA INDONESIA', 'LION AIR', 'CITILINK'),
    website VARCHAR(30) UNIQUE
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





    
-- SELECT: menampolkan maskapai dengan nama 'GARUDA INDONESIA'
SELECT * FROM maskapai
WHERE nama_maskapai = 'GARUDA INDONESIA';
