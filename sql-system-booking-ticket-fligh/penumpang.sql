-- CREATE: table
CREATE TABLE penumpang (
    id_penumpang CHAR(4) UNIQUE PRIMARY KEY,
    nama VARCHAR(20) NOT NULL,
    jenis_kelamin ENUM('WANITA', 'PRIA') DEFAULT 'PRIA'
);








-- INSERT: data
INSERT INTO penumpang (id_penumpang, nama, jenis_kelamin) VALUES 
('P001', 'DINAR DANISH', 'WANITA'),
('P002', 'NILAM SARI', 'WANITA'),
('P003', 'ABI SYAHLI', 'PRIA'),
('P004', 'ZENDAYA', 'WANITA'),
('P005', 'ABU LAHAB', 'PRIA');

    --  SELECT: awalnya data
    SELECT * FROM penumpang;




  

-- UPDATE: ubah jenis kelamin penumpang P004
UPDATE penumpang
SET jenis_kelamin = 'PRIA'
WHERE id_penumpang = 'P004';

    --  SELECT: setelah di ubah
    SELECT * FROM penumpang;






-- DELETE: hapus penumpang P005
DELETE FROM penumpang
WHERE id_penumpang = 'P005';

    --  SELECT: setelah di hapus
    SELECT * FROM penumpang;





    
-- SELECT: menampilkan semua penumpang WANITA
SELECT * FROM penumpang
WHERE jenis_kelamin = 'WANITA';
