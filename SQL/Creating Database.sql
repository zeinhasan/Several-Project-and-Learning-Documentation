-- Active: 1675764721588@@127.0.0.1@3306
CREATE DATABASE  academic; 
USE academic;
CREATE TABLE mahasiswa (
    NIM INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nama_mhsw varchar(250),
    jenis_kelamin ENUM ('L','P'),
    tempat_lahir varchar(250),
    tanggal_lahir DATE,
    alamat TEXT,
    telepon varchar(14)
);
CREATE TABLE dosen(
    NIP INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nama_dosen varchar(250),
    jenis_kelamin ENUM ('L','P'),
    laboratorium varchar(250),
    minat_riset TEXT,
    alamat TEXT,
    telepon varchar(14)
);

CREATE TABLE mata_kuliah (
    kode_mk INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nama_mk varchar(250),
    NIP INT,
    sks INT(3),
    hari varchar(20),
    jam TIME,
    kelas varchar(30),
    deskripsi TEXT,
    FOREIGN KEY (NIP) REFERENCES dosen(NIP)
);

CREATE TABLE KRS(
    ID_KRS INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    kode_mk INT,
    NIM INT,
    year INT,
    semester INT,
    FOREIGN KEY (kode_mk) REFERENCES mata_kuliah(kode_mk),
    FOREIGN KEY (NIM) REFERENCES mahasiswa(NIM)
);

DESCRIBE dosen;

USE academic;
RENAME TABLE dosen TO profesor;

DESCRIBE profesor;


