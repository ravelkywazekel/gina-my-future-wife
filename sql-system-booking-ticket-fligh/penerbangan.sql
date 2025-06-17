-- CREATE: table
CREATE TABLE penerbangan (
    id_maskapai VARCHAR(10) NOT NULL,
    id_operator VARCHAR(10) NOT NULL,
    status_penerbangan VARCHAR(20) NOT NULL CHECK (status IN ('AKTIF', 'DITUNDA', 'DIBATALKAN')),
    PRIMARY KEY (id_maskapai, id_operator)
);







-- INSERT: data
INSERT INTO penerbangan (id_maskapai, id_operator, status_penerbangan) VALUES
('M001', 'OP1', 'AKTIF'),
('M002', 'OP2', 'DITUNDA'),
('M003', 'OP3', 'AKTIF'),
('M004', 'OP4', 'DIBATALKAN'),
('M005', 'OP5', 'AKTIF');

  --  SELECT: awalnya data
SELECT * FROM penerbangan;




  

-- UPDATE: ubah status untuk maskapai M002 dan operator OP2
UPDATE penerbangan
SET status_penerbangan = 'AKTIF'
WHERE id_maskapai = 'M002' AND id_operator = 'OP2';

  --  SELECT: setelah di ubah
SELECT * FROM penerbangan;






-- DELETE: hapus catatan penerbangan untuk maskapai M004 dan operator OP4
DELETE FROM penerbangan
WHERE id_maskapai = 'M004' AND id_operator = 'OP4';

  --  SELECT: setelah di hapus
SELECT * FROM penerbangan;





    
-- SELECT: menampilkan semua rekaman status penerbangan dengan status AKTIF
SELECT * FROM penerbangan
WHERE status_penerbangan = 'ACTIVE';
