-- CREATE: table
CREATE TABLE tiket (
    no_tiket VARCHAR(10) PRIMARY KEY,
    id_pemesanan VARCHAR(10) NOT NULL,
    tanggal_penerbangan DATE NOT NULL,
    seat_id VARCHAR(10) NOT NULL,
    jadwal TIME NOT NULL
);



-- INSERT: data
INSERT INTO tiket (no_tiket, id_pemesanan, tanggal_penerbangan, seat_id, jadwal) VALUES
('SQ001', 'PM001', '2025-04-05', '45A', '13:15:00'),
('SQ002', 'PM002', '2025-04-05', '07A', '07:42:00'),
('SQ003', 'PM003', '2025-04-06', '50A', '21:15:00'),
('SQ004', 'PM004', '2025-04-08', '53D', '16:00:00'),
('SQ005', 'PM005', '2025-04-10', '42E', '04:30:00');

  --  SELECT: awalnya data
SELECT * FROM tiket




  

-- UPDATE: ganti kursi untuk tiket SQ004
UPDATE tiket
SET seat_id = '54D'
WHERE no_tiket = 'SQ004';

  --  SELECT: setelah di ubah
SELECT * FROM tiket






-- DELETE: hapus tiket SQ005
DELETE FROM tiket
WHERE no_tiket = 'SQ005';

  --  SELECT: setelah di hapus
SELECT * FROM tiket





    
-- SELECT: tiket dijadwalkan pada atau setelah 6 April 2025
SELECT * FROM tiket
WHERE tanggal_penerbangan >= '2025-04-06';
