/*
-- CREATE DATABASE
CREATE DATABASE pemesanan_tiket_pesawat;

-- BACKUP DATABASE 
BACKUP DATABASE pemesanan_tiket_pesawat
TO DISK = 'D:\backups\pemesanan_tiket_pesawat.bak'
WITH DIFFERENTIAL; -- menyimpan semua perubahan data yang dibuat sejak pencadangan penuh terakhir

-- DROP DATABASE
DROP DATABASE pemesanan_tiket_pesawat;
*/




-- CREATE: table
CREATE TABLE kursi (
    id_kursi CHAR(3) UNIQUE PRIMARY KEY,
    class ENUM('EKONOMI', 'FIRST CLASS', 'BISNIS'),
    availability SET('TERSEDIA', 'TERISI'),
    id_operator CHAR(3) UNIQUE,
    pembayaran ENUM('DEBIT', 'CREDIT', 'CASH')
);


-- INSERT: data
INSERT INTO kursi (id_kursi, class, availability, id_operator, pembayaran) VALUES
('45A', 'EKONOMI', 'TERSEDIA', 'OP1', 'DEBIT'),
('07A', 'FIRST CLASS', 'TERSEDIA', 'OP2', 'CASH'),
('50A', 'EKONOMI', 'TERSEDIA', 'OP3', 'CREDIT'),
('53D', 'EKONOMI', 'TERSEDIA', 'OP4', 'DEBIT'),
('42E', 'BISNIS', 'TERISI', 'OP5', 'CASH');
    --  SELECT: awalnya data
    SELECT * FROM kursi;  


-- ALTER: menambah kolom tabel
ALTER TABLE kursi
ADD posisi_kursi SET('DEPAN', 'TENGAH', 'BELAKANG') default 'TENGAH';
    -- SELECT: menambah kolom
    SELECT * FROM kursi;


-- ALTER: mengubah nama kolomtabel
ALTER TABLE kursi
CHANGE posisi_kursi tempat_kursi SET('DEPAN', 'TENGAH', 'BELAKANG') default 'TENGAH';
    -- SELECT: mengubah kolom
    SELECT * FROM kursi;


--  ALTER: menghapus kolom tabel
ALTER TABLE kursi
DROP COLUMN tempat_kursi;
    -- SELECT: menambah kolom
    SELECT * FROM kursi;


/*
-- DROP: menghapus tabel
DROP TABLE kursi;


-- TRUNCATE: menghapus isi data tabel
TRUNCATE TABLE kursi;
*/


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
