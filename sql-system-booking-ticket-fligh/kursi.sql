-- CREATE: table
CREATE TABLE kursi (
    id_kursi VARCHAR(10) PRIMARY KEY,
    class VARCHAR(20) NOT NULL CHECK (class IN ('EKONOMI', 'FIRST CLASS', 'BISNIS')),
    availability VARCHAR(20) NOT NULL CHECK (availability IN ('TERSEDIA', 'TERISI')),
    id_operator VARCHAR(10) NOT NULL,
    pembayaran VARCHAR(20) NOT NULL CHECK (pembayaran IN ('DEBIT', 'CREDIT', 'CASH'))
);






-- INSERT: data
INSERT INTO kursi (id_kursi, class, availability, id_operator, pembayaran) VALUES
('45A', 'EKONOMI', 'TERSEDIA', 'OP1', 'DEBIT'),
('07A', 'FIRST CLASS', 'TERSEDIA', 'OP2', 'CASH'),
('50A', 'EKONOMI', 'TERSEDIA', 'OP3', 'CREDIT'),
('53D', 'EKONOMI', 'TERSEDIA', 'OP4', 'DEBIT'),
('42E', 'BISNIS', 'TERISI', 'OP4', 'CASH');

  --  SELECT: awalnya data
SELECT * FROM kursi;




  

-- UPDATE: tandai kursi 07A sebagai TERISI
UPDATE kursi
SET availability = 'TERISI'
WHERE id_kursi = '07A';

  --  SELECT: setelah di ubah
SELECT * FROM kursi;






-- DELETE: hapus kursi 53D
DELETE FROM kursi
WHERE id_kursi = '53D';

  --  SELECT: setelah di hapus
SELECT * FROM kursi;





    
-- SELECT: menampilkan semua kursi dengan kelas BISNIS atau FIRST CLASS
SELECT * FROM kursi
WHERE class IN ('BISNIS', 'FIRST CLASS');
