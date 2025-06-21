-- CREATE: table
CREATE TABLE kapasitas (
    id_pesawat CHAR(5) UNIQUE PRIMARY KEY,
    id_kursi CHAR(3) UNIQUE NOT NULL,
    kapasitas_kursi INTEGER NOT NULL
);






-- INSERT: data
INSERT INTO kapasitas (id_pesawat, id_kursi, kapasitas_kursi) VALUES
('PE001', '45A', 780),
('PE002', '07A', 8),
('PE003', '50A', 770),
('PE004', '53D', 750),
('PE005', '42E', 60);

  --  SELECT: awalnya data
SELECT * FROM kapasitas;




  

-- UPDATE: ubah kapasitas untuk penerbangan PE002
UPDATE kapasitas
SET kapasitas_kursi = 15
WHERE id_pesawat = 'PE002';

  --  SELECT: setelah di ubah
SELECT * FROM kapasitas;






-- DELETE: hapus catatan kapasitas untuk penerbangan PE005
DELETE FROM kapasitas
WHERE id_pesawat = 'PE005';

  --  SELECT: setelah di hapus
SELECT * FROM kapasitas;





    
-- SELECT: menampilkan kapasitas kursi jika kapasitasnya lebih besar dari 100
SELECT * FROM kapasitas
WHERE kapasitas_kursi > 100;
