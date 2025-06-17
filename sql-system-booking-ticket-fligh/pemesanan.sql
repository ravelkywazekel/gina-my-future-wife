-- CREATE: table
CREATE TABLE pemesanan (
    id_penumpang VARCHAR(100) PRIMARY KEY,
    no_tiket VARCHAR(100) PRIMARY KEY,
    harga NUMERIC(15) NOT NULL,
    CONSTRAINT fk_penumpang FOREIGN KEY (id_penumpang)
        REFERENCES penumpang(id_penumpang)
        ON DELETE CASCADE
);






-- INSERT: data
INSERT INTO pemesanan (id_penumpang, no_tiket, harga) VALUES
('P001', 'SQ001', 1500000),
('P002', 'SQ002', 1800000),
('P003', 'SQ003', 1550000),
('P004', 'SQ004', 1600000),
('P005', 'SQ005', 600000);

--  SELECT: awalnya data
SELECT * FROM pemesanan






-- UPDATE: ubah harga tiket SQ005
UPDATE pemesanan
SET harga = 650000
WHERE no_tiket = 'SQ005';

--  SELECT: setelah di ubah
SELECT * FROM pemesanan






-- DELETE: hapus pemesanan SQ003
DELETE FROM pemesanan
WHERE no_tiket = 'SQ003';

--  SELECT: setelah di hapus
SELECT * FROM pemesanan






-- SELECT: menampilkan pemesanan dengan harga lebih dari 1.000.000
SELECT * FROM pemesanan
WHERE harga > 1000000;
