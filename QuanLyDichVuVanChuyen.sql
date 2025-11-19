CREATE DATABASE QuanLyDatVeMayBay;
USE QuanLyDatVeMayBay;

CREATE TABLE KhachHang (
    MaKhachHang CHAR(10) PRIMARY KEY,
    TenKhachHang NVARCHAR(100),
    Email NVARCHAR(100),
    SoDienThoai VARCHAR(15)
);

CREATE TABLE SanBay (
    MaSanBay CHAR(10) PRIMARY KEY,
    TenSanBay NVARCHAR(100),
    DiaChi NVARCHAR(200)
);

CREATE TABLE MayBay (
    MaMayBay CHAR(10) PRIMARY KEY,
    TenMayBay NVARCHAR(100),
    HangSanXuat NVARCHAR(100),
    SoGhe INT
);

CREATE TABLE ChuyenBay (
    MaChuyenBay CHAR(10) PRIMARY KEY,
    TenChuyenBay NVARCHAR(100),
    MaSanBayDi CHAR(10),
    MaSanBayDen CHAR(10),
    MaMayBay CHAR(10),
    NgayGioKhoiHanh DATETIME,
    FOREIGN KEY (MaSanBayDi) REFERENCES SanBay(MaSanBay),
    FOREIGN KEY (MaSanBayDen) REFERENCES SanBay(MaSanBay),
    FOREIGN KEY (MaMayBay) REFERENCES MayBay(MaMayBay)
);

CREATE TABLE DatVe (
    MaDatVe CHAR(10) PRIMARY KEY,
    MaKhachHang CHAR(10),
    MaChuyenBay CHAR(10),
    SoGhe VARCHAR(10),
    NgayDatVe DATETIME,
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang),
    FOREIGN KEY (MaChuyenBay) REFERENCES ChuyenBay(MaChuyenBay)
);

CREATE TABLE PhuongThucThanhToan (
    MaPhuongThuc CHAR(10) PRIMARY KEY,
    TenPhuongThuc NVARCHAR(50),
    MoTa NVARCHAR(200)
);

CREATE TABLE HoaDon (
    MaHoaDon CHAR(10) PRIMARY KEY,
    MaDatVe CHAR(10),
    MaPhuongThuc CHAR(10),
    TongTien DECIMAL(15,2),
    NgayThanhToan DATETIME,
    FOREIGN KEY (MaDatVe) REFERENCES DatVe(MaDatVe),
    FOREIGN KEY (MaPhuongThuc) REFERENCES PhuongThucThanhToan(MaPhuongThuc)
);

CREATE TABLE HanhLy (
    MaHanhLy CHAR(10) PRIMARY KEY,
    MaVe CHAR(10),
    TrongLuong DECIMAL(5,2),
    LoaiHanhLy NVARCHAR(50),
    FOREIGN KEY (MaVe) REFERENCES DatVe(MaDatVe)
);

CREATE TABLE NhanVien (
    MaNhanVien CHAR(10) PRIMARY KEY,
    TenNhanVien NVARCHAR(100),
    ChucVu NVARCHAR(50),
    SoDienThoai VARCHAR(15)
);

CREATE TABLE PhanCong (
    MaChuyenBay CHAR(10),
    MaNhanVien CHAR(10),
    NhiemVu NVARCHAR(50),
    PRIMARY KEY (MaChuyenBay, MaNhanVien),
    FOREIGN KEY (MaChuyenBay) REFERENCES ChuyenBay(MaChuyenBay),
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
);



-- ===============================================
-- DỮ LIỆU MẪU CHO HỆ THỐNG QUẢN LÝ ĐẶT VÉ MÁY BAY
-- ===============================================

-- 1. Sân bay
INSERT INTO SanBay VALUES
('SB01', N'Tân Sơn Nhất', N'Hồ Chí Minh'),
('SB02', N'Nội Bài', N'Hà Nội'),
('SB03', N'Đà Nẵng', N'Đà Nẵng'),
('SB04', N'Cát Bi', N'Hải Phòng');

-- 2. Máy bay
INSERT INTO MayBay VALUES
('MB01', N'Airbus A320', N'Airbus', 180),
('MB02', N'Boeing 737', N'Boeing', 200),
('MB03', N'ATR 72', N'ATR', 70);

-- 3. Khách hàng
INSERT INTO KhachHang VALUES
('KH01', N'Nguyễn Văn A', 'vana@gmail.com', '0905123456'),
('KH02', N'Trần Thị B', 'thib@gmail.com', '0912345678'),
('KH03', N'Lê Văn C', 'vanc@gmail.com', '0987456321');

-- 4. Nhân viên
INSERT INTO NhanVien VALUES
('NV01', N'Phạm Văn Phi', N'Phi công', '0901112233'),
('NV02', N'Ngô Thị Mai', N'Tiếp viên', '0902223344'),
('NV03', N'Đỗ Minh Long', N'Phi công', '0903334455'),
('NV04', N'Lý Hương', N'Tiếp viên', '0904445566');

-- 5. Chuyến bay
INSERT INTO ChuyenBay VALUES
('CB01', N'VN101', 'SB01', 'SB02', 'MB01', '2025-12-20 08:00:00'),
('CB02', N'VN202', 'SB02', 'SB03', 'MB02', '2025-12-21 13:00:00'),
('CB03', N'VN303', 'SB03', 'SB01', 'MB03', '2025-12-22 17:30:00');

-- 6. Phân công nhân viên cho chuyến bay
INSERT INTO PhanCong VALUES
('CB01', 'NV01', N'Phi công trưởng'),
('CB01', 'NV02', N'Tiếp viên'),
('CB02', 'NV03', N'Phi công trưởng'),
('CB02', 'NV04', N'Tiếp viên');

-- 7. Phương thức thanh toán
INSERT INTO PhuongThucThanhToan VALUES
('TT01', N'Tiền mặt', N'Thanh toán trực tiếp tại quầy'),
('TT02', N'Thẻ tín dụng', N'Thanh toán bằng thẻ ngân hàng'),
('TT03', N'Chuyển khoản', N'Thanh toán qua Internet Banking');

-- 8. Đặt vé
INSERT INTO DatVe VALUES
('DV01', 'KH01', 'CB01', '12A', '2025-11-01'),
('DV02', 'KH02', 'CB02', '08B', '2025-11-02'),
('DV03', 'KH03', 'CB03', '05C', '2025-11-03');

-- 9. Hóa đơn thanh toán
INSERT INTO HoaDon VALUES
('HD01', 'DV01', 'TT02', 2500000, '2025-11-01'),
('HD02', 'DV02', 'TT03', 3200000, '2025-11-02'),
('HD03', 'DV03', 'TT01', 1800000, '2025-11-03');

-- 10. Hành lý
INSERT INTO HanhLy VALUES
('HL01', 'DV01', 15.5, N'Ký gửi'),
('HL02', 'DV02', 7.0, N'Xách tay'),
('HL03', 'DV03', 20.0, N'Ký gửi');




-- ===============================================
-- TRUY VẤN MẪU TEST HỆ THỐNG QUẢN LÝ ĐẶT VÉ MÁY BAY
-- ===============================================

USE QuanLyDatVeMayBay;

-- 1️ Liệt kê tất cả thông tin khách hàng và số lượng vé họ đã đặt
SELECT KH.MaKhachHang, KH.TenKhachHang, KH.Email, COUNT(DV.MaDatVe) AS SoLuongVe
FROM KhachHang KH
LEFT JOIN DatVe DV ON KH.MaKhachHang = DV.MaKhachHang
GROUP BY KH.MaKhachHang, KH.TenKhachHang, KH.Email;

-- 2️ Xem chi tiết các vé đã đặt, bao gồm tên khách, chuyến bay, điểm đi, điểm đến và số ghế
SELECT DV.MaDatVe, KH.TenKhachHang, CB.TenChuyenBay, SB1.TenSanBay AS DiemDi, SB2.TenSanBay AS DiemDen, DV.SoGhe, DV.NgayDatVe
FROM DatVe DV
JOIN KhachHang KH ON DV.MaKhachHang = KH.MaKhachHang
JOIN ChuyenBay CB ON DV.MaChuyenBay = CB.MaChuyenBay
JOIN SanBay SB1 ON CB.MaSanBayDi = SB1.MaSanBay
JOIN SanBay SB2 ON CB.MaSanBayDen = SB2.MaSanBay;

-- 3️ Thống kê doanh thu theo từng chuyến bay
SELECT CB.MaChuyenBay, CB.TenChuyenBay, SUM(HD.TongTien) AS TongDoanhThu
FROM HoaDon HD
JOIN DatVe DV ON HD.MaDatVe = DV.MaDatVe
JOIN ChuyenBay CB ON DV.MaChuyenBay = CB.MaChuyenBay
GROUP BY CB.MaChuyenBay, CB.TenChuyenBay;

-- 4️ Liệt kê hành lý của từng vé (kèm tên khách hàng)
SELECT DV.MaDatVe, KH.TenKhachHang, HL.TrongLuong, HL.LoaiHanhLy
FROM HanhLy HL
JOIN DatVe DV ON HL.MaVe = DV.MaDatVe
JOIN KhachHang KH ON DV.MaKhachHang = KH.MaKhachHang;

-- 5️ Xem danh sách nhân viên được phân công trên từng chuyến bay
SELECT CB.TenChuyenBay, NV.TenNhanVien, NV.ChucVu, PC.NhiemVu
FROM PhanCong PC
JOIN ChuyenBay CB ON PC.MaChuyenBay = CB.MaChuyenBay
JOIN NhanVien NV ON PC.MaNhanVien = NV.MaNhanVien
ORDER BY CB.TenChuyenBay;

-- 6️ Tìm các chuyến bay có điểm đến là 'Hà Nội'
SELECT CB.MaChuyenBay, CB.TenChuyenBay, SB2.TenSanBay AS DiemDen, CB.NgayGioKhoiHanh
FROM ChuyenBay CB
JOIN SanBay SB2 ON CB.MaSanBayDen = SB2.MaSanBay
WHERE SB2.TenSanBay = N'Hà Nội';

-- 7️ Liệt kê các hóa đơn và phương thức thanh toán tương ứng
SELECT HD.MaHoaDon, KH.TenKhachHang, PT.TenPhuongThuc, HD.TongTien, HD.NgayThanhToan
FROM HoaDon HD
JOIN DatVe DV ON HD.MaDatVe = DV.MaDatVe
JOIN KhachHang KH ON DV.MaKhachHang = KH.MaKhachHang
JOIN PhuongThucThanhToan PT ON HD.MaPhuongThuc = PT.MaPhuongThuc;

-- 8️ Thống kê tổng trọng lượng hành lý ký gửi theo chuyến bay
SELECT CB.TenChuyenBay, SUM(HL.TrongLuong) AS TongTrongLuongHanhLy
FROM HanhLy HL
JOIN DatVe DV ON HL.MaVe = DV.MaDatVe
JOIN ChuyenBay CB ON DV.MaChuyenBay = CB.MaChuyenBay
WHERE HL.LoaiHanhLy = N'Ký gửi'
GROUP BY CB.TenChuyenBay;

-- 9️ Liệt kê các khách hàng đã sử dụng phương thức thanh toán 'Thẻ tín dụng'
SELECT DISTINCT KH.TenKhachHang, KH.Email, PT.TenPhuongThuc
FROM KhachHang KH
JOIN DatVe DV ON KH.MaKhachHang = DV.MaKhachHang
JOIN HoaDon HD ON DV.MaDatVe = HD.MaDatVe
JOIN PhuongThucThanhToan PT ON HD.MaPhuongThuc = PT.MaPhuongThuc
WHERE PT.TenPhuongThuc = N'Thẻ tín dụng';

-- 10 Xem tổng số vé đã đặt cho từng ngày
SELECT CONVERT(DATE, NgayDatVe) AS Ngay, COUNT(MaDatVe) AS TongVe
FROM DatVe
GROUP BY CONVERT(DATE, NgayDatVe)
ORDER BY Ngay;


-- ===== STORED PROCEDURE =====
-- Stored procedure for revenue statistics
CREATE PROCEDURE sp_ThongKeDoanhThuChuyenBay
AS
BEGIN
    SELECT CB.MaChuyenBay, CB.TenChuyenBay, SUM(HD.TongTien) AS TongDoanhThu
    FROM HoaDon HD
    JOIN DatVe DV ON HD.MaDatVe = DV.MaDatVe
    JOIN ChuyenBay CB ON DV.MaChuyenBay = CB.MaChuyenBay
    GROUP BY CB.MaChuyenBay, CB.TenChuyenBay;
END;
-- EXEC sp_ThongKeDoanhThuChuyenBay;


-- ===== USER DEFINED FUNCTION =====
-- Function to calculate total payment by customer
CREATE FUNCTION fn_TinhTongTienTheoKhachHang (@MaKhachHang CHAR(10))
RETURNS DECIMAL(15,2)
AS
BEGIN
    DECLARE @TongTien DECIMAL(15,2);
    SELECT @TongTien = SUM(HD.TongTien)
    FROM HoaDon HD
    JOIN DatVe DV ON HD.MaDatVe = DV.MaDatVe
    WHERE DV.MaKhachHang = @MaKhachHang;
    RETURN ISNULL(@TongTien, 0);
END;
-- SELECT dbo.fn_TinhTongTienTheoKhachHang('KH01') AS TongTien;


-- ===== VIEW =====
-- View for booking details
CREATE VIEW vw_ThongTinVeDat AS
SELECT DV.MaDatVe, KH.TenKhachHang, CB.TenChuyenBay, SB1.TenSanBay AS DiemDi, SB2.TenSanBay AS DiemDen, DV.SoGhe, DV.NgayDatVe
FROM DatVe DV
JOIN KhachHang KH ON DV.MaKhachHang = KH.MaKhachHang
JOIN ChuyenBay CB ON DV.MaChuyenBay = CB.MaChuyenBay
JOIN SanBay SB1 ON CB.MaSanBayDi = SB1.MaSanBay
JOIN SanBay SB2 ON CB.MaSanBayDen = SB2.MaSanBay;
-- SELECT * FROM vw_ThongTinVeDat;


-- ===== TRIGGER =====
-- Trigger to auto-create invoice after new booking
CREATE TRIGGER trg_CapNhatHoaDonSauKhiDatVe
ON DatVe
AFTER INSERT
AS
BEGIN
    INSERT INTO HoaDon(MaHoaDon, MaDatVe, MaPhuongThuc, TongTien, NgayThanhToan)
    SELECT CONCAT('HD', RIGHT('00' + CAST((SELECT COUNT(*)+1 FROM HoaDon) AS VARCHAR(3)), 2)), 
           i.MaDatVe, NULL, 0, GETDATE()
    FROM inserted i;
END;
-- Test trigger:
-- INSERT INTO DatVe VALUES ('DV04', 'KH01', 'CB01', '13C', GETDATE());


-- ===== INDEXES & SECURITY =====
-- Index for Email column
CREATE INDEX idx_KhachHang_Email ON KhachHang(Email);
-- Index for flight departure time
CREATE INDEX idx_ChuyenBay_NgayGioKhoiHanh ON ChuyenBay(NgayGioKhoiHanh);
-- Index for payment date
CREATE INDEX idx_HoaDon_NgayThanhToan ON HoaDon(NgayThanhToan);
-- Index for booking date
CREATE INDEX idx_DatVe_NgayDatVe ON DatVe(NgayDatVe);


-- ===== USER & ROLE MANAGEMENT =====
-- Create user and grant privileges
CREATE LOGIN user_BanVe WITH PASSWORD = '123456';
CREATE USER user_BanVe FOR LOGIN user_BanVe;
GRANT SELECT, INSERT, UPDATE ON DatVe TO user_BanVe;
REVOKE DELETE ON DatVe FROM user_BanVe;

-- Create role for ticket management
CREATE ROLE role_QuanLyVe;
GRANT SELECT, INSERT, UPDATE, DELETE ON DatVe TO role_QuanLyVe;


-- ===== BACKUP & RESTORE =====
-- Backup and restore database
-- BACKUP DATABASE QuanLyDatVeMayBay TO DISK = 'C:\Backup\QuanLyDatVeMayBay.bak';
-- RESTORE DATABASE QuanLyDatVeMayBay FROM DISK = 'C:\Backup\QuanLyDatVeMayBay.bak';


-- ===== OPTIMIZATION =====
-- Query optimization and performance tips
-- Ensure appropriate indexing, avoid SELECT * in production queries.

