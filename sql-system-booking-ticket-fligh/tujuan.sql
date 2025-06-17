-- CREATE: table
CREATE TABLE tujuan (
    id_pesawat VARCHAR(10) NOT NULL,
    id_penumpang VARCHAR(10) NOT NULL,
    tujuan_pesawat VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_pesawat, id_penumpang)
);







-- INSERT: data
INSERT INTO tujuan (id_pesawat, id_penumpang, tujuan_pesawat) VALUES
('PE001', 'P001', 'JAKARTA'),
('PE002', 'P002', 'BALI'),
('PE003', 'P003', 'SURABAYA'),
('PE004', 'P004', 'PADANG'),
('PE005', 'P005', 'PEKANBARU');

  --  SELECT: awalnya data
SELECT * FROM tujuan




  

-- UPDATE: ubah tujuan untuk penumpang P003 pada penerbangan PE003
UPDATE tujuan
SET tujuan_pesawat = 'MALANG'
WHERE id_pesawat = 'PE003' AND id_penumpang = 'P003';

  --  SELECT: setelah di ubah
SELECT * FROM tujuan






-- DELETE: hapus catatan tujuan untuk penumpang P005 pada penerbangan PE005
DELETE FROM tujuan
WHERE id_pesawat = 'PE005' AND id_penumpang = 'P005';


  --  SELECT: setelah di hapus
SELECT * FROM tujuan





    
-- SELECT: menampilkan semua penumpang yang menuju BALI
SELECT * FROM tujuan
WHERE tujuan_pesawat = 'BALI';
