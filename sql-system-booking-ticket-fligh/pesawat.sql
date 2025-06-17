-- CREATE: table
CREATE TABLE pesawat (
    id_pesawat VARCHAR(10) PRIMARY KEY,
    jenis_pesawat VARCHAR(50) NOT NULL,
    merek_pesawat VARCHAR(50) NOT NULL,
    id_maskapai VARCHAR(10) NOT NULL,
    rute_penerbangan VARCHAR(100) NOT NULL
);






-- INSERT: data
INSERT INTO pesawat (id_pesawat, jenis_pesawat, merek_pesawat, id_maskapai, rute_penerbangan) VALUES
('PE001', 'MINI PASSENGER JETS', 'A220', 'M001', 'PADANG - JAKARTA'),
('PE002', 'JUMBO PASSENGER JETS', 'A350', 'M002', 'JAKARTA - BALI'),
('PE003', 'NORMAL PASSENGER JETS', 'A330', 'M003', 'BANDUNG - BALI'),
('PE004', 'NORMAL PASSENGER JETS', 'A320', 'M003', 'JAKARTA - PADANG'),
('PE005', 'JUMBO PASSENGER JETS', 'A350', 'M005', 'PADANG - PEKANBARU');

  --  SELECT: awalnya data
SELECT * FROM pesawat;




  

-- UPDATE: ubah merek pesawat untuk penerbangan PE004
UPDATE pesawat
SET merek_pesawat = 'A321'
WHERE id_pesawat = 'PE004';

  --  SELECT: setelah di ubah
SELECT * FROM pesawat;






-- DELETE: hapus catatan pesawat untuk penerbangan PE002
DELETE FROM pesawat
WHERE id_pesawat = 'PE002';

  --  SELECT: setelah di hapus
SELECT * FROM pesawat;





    
-- SELECT: menampilkan pesawat jenis 'JUMBO PASSENGER JETS'
SELECT * FROM pesawat
WHERE jenis_pesawat = 'JUMBO PASSENGER JETS';


