CREATE DATABASE BanNoiThat
GO
USE BanNoiThat
GO

CREATE TABLE Account
(
AccountID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
TaiKhoan VARCHAR(100) NOT NULL,
MatKhau VARCHAR(30) NOT NULL,
Phone INT NOT NULL,
Email VARCHAR(24) NOT NULL,
FullName NVARCHAR(100) NOT NULL,
CreateDate DATE NOT NULL
)
GO

CREATE TABLE DanhMucSP
(
MaDM INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
TenDM NVARCHAR(200) NOT NULL,
AnhDM NVARCHAR(MAX),
MoTaDM NVARCHAR(500),
TrangThai BIT
)
GO

CREATE TABLE SanPham
(
MaSP INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
MaDM INT,
TenSP NVARCHAR(200) NOT NULL,
AnhSP NVARCHAR(MAX) NOT NULL,
VideoSP NVARCHAR(MAX),
GiaSP INT NOT NULL,
TrangThai BIT NOT NULL,
BestSeller BIT NOT NULL,
CreateDate DATE NOT NULL,
NgaySua DATE NOT NULL,
LinkDownGame Nvarchar(Max),
MotaSP NVARCHAR(MAX) NOT NULL

FOREIGN KEY (MaDM) REFERENCES DanhMucSP(MaDM)
)
GO

Create Table NhanVien
(
	MaNV  INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	HoNV nvarchar(30) not null,
	TenNV nvarchar(20) not null,
	NgaySinh Datetime,
	GioiTinh nvarchar(10) 
		Constraint CH_GioiTinh_NhanVien check (GioiTinh in('Nam',N'Nữ',N'Khác')),
	DiaChi nvarchar(100) 
		Constraint DF_DiaChi_NhanVien default 'Chua co',
	DienThoai nvarchar(11) 
		Constraint DF_DienThoai_NhanVien default 'Chua co',
	CMND nvarchar(12) not null,
	NoiSinh nvarchar(30),
	NgayVaoLam datetime,
)
GO

CREATE TABLE KhachHang
(
MaKH INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
TenKH NVARCHAR(200) NOT NULL,
Diachi NVARCHAR(500) NOT NULL,
Ngaysinh DATE NOT NULL,
Phone INT NOT NULL,
Email NVARCHAR(200) NOT NULL,
CreateDate DATE NOT NULL
)
GO

CREATE TABLE DonHang
(
MaDH INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
MaKH INT NOT NULL,
NgayTao DATE NOT NULL,
TrangThaiHuyDon BIT NOT NULL,
ThanhToan BIT NOT NULL,
NgayThanhToan DATE NOT NULL,
Note NVARCHAR(MAX)

FOREIGN KEY (MaKH) REFERENCES dbo.KhachHang(MaKH)
)
GO
 
 Create Table NhaCungCap
(
MaNCC INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
TenNCC nvarchar(100) not null,
DiaChi nvarchar(100) not null,
DienThoai nvarchar(11) not null,
Email nvarchar(50) not null,
Website nvarchar(30)
Constraint DF_Website_NhaCungCap default 'Chua co'
)
GO 
Create Table NguyenLieu
(
MNL INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
TenNL nvarchar(30) not null,
DonViTinh nvarchar(30) not null,
TonKho int not null,
GhiChu ntext
)
GO

Create Table ChiTietPhieuNhap
(
	SoPN INT not null,
	MaNL INT not null,
	SoLuong smallint not null,
	DonGiaNhap real not null,
		Primary Key (SoPN, MaNL)
)
GO

Create Table PhieuNhap
(
SoPN  INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
MaNV INT not null,
MaNCC INT  not null,
NgayNhap datetime not null,
TongTriGia real not null,
GhiChu ntext
)
Alter Table PhieuNhap
	Add constraint FK_MaNV_PhieuNhap Foreign Key (MaNV) references NhanVien(MaNV),
		constraint FK_MaNCC_PhieuNhap Foreign Key (MaNCC) references NhaCungCap(MaNCC)
GO

CREATE TABLE ChiTietDonHang
(
MaCTDH INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
MaDH INT NOT NULL,
MaSP INT NOT NULL,
TongTien INT NOT NULL,
Ngaygiao INT NOT NULL

FOREIGN KEY (MaDH) REFERENCES dbo.DonHang(MaDH),
FOREIGN KEY (MaSP) REFERENCES dbo.SanPham(MaSP)
)
GO

SET IDENTITY_INSERT [dbo].[DanhMucSP] ON 

INSERT [dbo].[DanhMucSP] ([MaDM], [TenDM], [AnhDM], [MoTaDM], [TrangThai]) VALUES (1, N'Bàn Nội Thất', NULL, N'Các loại bàn nội thất', 1)
INSERT [dbo].[DanhMucSP] ([MaDM], [TenDM], [AnhDM], [MoTaDM], [TrangThai]) VALUES (2, N'Ghế Nội Thất', NULL, N'Các loại ghế nội thất', 1)
INSERT [dbo].[DanhMucSP] ([MaDM], [TenDM], [AnhDM], [MoTaDM], [TrangThai]) VALUES (3, N'Bóng Đèn', NULL, N'Các bóng đèn nội thất', 1)
SET IDENTITY_INSERT [dbo].[DanhMucSP] OFF
GO
