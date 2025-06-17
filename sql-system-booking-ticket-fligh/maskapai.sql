-- CREATE: table
CREATE TABLE maskapai (
    id_maskapai VARCHAR(10) PRIMARY KEY,
    nama_maskapai VARCHAR(100) NOT NULL,
    website VARCHAR(255) NOT NULL
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
