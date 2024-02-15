-- Tạo cơ sở dữ liệu QUANLYTHUVIEN
CREATE DATABASE QUANLYTHUVIEN
GO

USE QUANLYTHUVIEN
GO

-- Tạo bảng THELOAI
CREATE TABLE THELOAI (
    MaTheLoai varchar(10),
    TenTheLoai nvarchar(30),
	CONSTRAINT PK_TL PRIMARY KEY(MaTheLoai)
)

-- Tạo bảng NHAXUATBAN
CREATE TABLE NHAXUATBAN (
    MaNXB varchar(10),
    TenNXB nvarchar(50),
    DiaChi nvarchar(50),
    Email varchar(40),
    NguoiDaiDien nvarchar(40)
	CONSTRAINT PK_NXB PRIMARY KEY(MaNXB)
)

-- Tạo bảng TAILIEU
CREATE TABLE TAILIEU (
    MaTaiLieu varchar(13),
    TenTaiLieu nvarchar(100),
    NgayXuatBan smalldatetime,
	MaNXB varchar(10),
	MaTheLoai varchar(10),
	CONSTRAINT PK_TAILIEU PRIMARY KEY(MaTaiLieu), 
    CONSTRAINT FK01_TAILIEU FOREIGN KEY(MaNXB) REFERENCES NHAXUATBAN(MaNXB),
    CONSTRAINT FK02_TAILIEU FOREIGN KEY(MaTheLoai) REFERENCES THELOAI(MaTheLoai),
	HienCo tinyint not null,
	DangMuon tinyint not null
)

-- Tạo bảng TACGIA
CREATE TABLE TACGIA (
    MaTacGia varchar(10),
    TenTacGia nvarchar(50),
	CONSTRAINT PK_TG PRIMARY KEY(MaTacGia)
)

-- Tạo bảng THETHUVIEN
CREATE TABLE THETHUVIEN (
    SoThe varchar(10),
    NgayBatDau smalldatetime,
    NgayHetHan smalldatetime,
    CONSTRAINT PK_TTV PRIMARY KEY (SoThe)
)

-- Tạo bảng DOCGIA
CREATE TABLE DOCGIA (
    MaDocGia varchar(10),
    HoTen nvarchar(50),
	GioiTinh nvarchar(3),
	NgaySinh smalldatetime,
    DiaChi nvarchar(60),
    SoThe varchar(10),
	CONSTRAINT PK_DG PRIMARY KEY(MaDocGia),
	CONSTRAINT FK_DG FOREIGN KEY(SoThe) REFERENCES THETHUVIEN(SoThe)
)

-- Tạo bảng NHANVIEN
CREATE TABLE NHANVIEN (
    MaNV varchar(10),
    HoTen nvarchar(50),
	GioiTinh nvarchar(3),
    NgaySinh smalldatetime,
    SDT char(10),
	CONSTRAINT PK_NV PRIMARY KEY (MaNV)
)

-- Tạo bảng TAILIEU_TACGIA
CREATE TABLE TAILIEU_TACGIA (
    MaTaiLieu varchar(13),
    MaTacGia varchar(10),
    CONSTRAINT PK_TAILIEU_TG PRIMARY KEY (MaTaiLieu, MaTacGia),
    CONSTRAINT FK01_TAILIEU_TG FOREIGN KEY (MaTaiLieu) REFERENCES TAILIEU(MaTaiLieu),
    CONSTRAINT FK02_TAILIEU_TG FOREIGN KEY (MaTacGia) REFERENCES TACGIA(MaTacGia)
)

-- Tạo bảng CTMUONTRA
CREATE TABLE CTMUONTRA ( 
    MaMuonTra char(11),
    NgayMuon smalldatetime,
    DaTra bit,
	GiaHan bit not null,
    NgayTra smalldatetime,
    GhiChu nvarchar(50),
	SoThe varchar(10),
	MaTaiLieu varchar(13),
	MaNV varchar(10),
	CONSTRAINT PK_CTMT PRIMARY KEY (MaMuonTra),
    CONSTRAINT FK01_CTMT FOREIGN KEY (SoThe) REFERENCES THETHUVIEN(SoThe),
    CONSTRAINT FK02_CTMT FOREIGN KEY (MaTaiLieu) REFERENCES TAILIEU(MaTaiLieu),
    CONSTRAINT FK03_CTMT FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV)
)

SET DATEFORMAT DMY





-- Nhập dữ liệu cho bảng NHAXUATBAN




-- Nhập dữ liệu cho bảng THELOAI




SET DATEFORMAT DMY

-- Nhập dữ liệu cho bảng TAILIEU
--- 1


--- 2


--- 3


--- 4


--- 5


--- 6


--- 7
I

--- 8


--- 9



--- 10



-- Nhập dữ liệu cho bảng TACGIA
--- 1


--- 2


--- 3


--- 4


--- 5


--- 6


--- 7




-- Nhập dữ liệu cho bảng THETHUVIEN
--- 1

--- 2


--- 3



-- Nhập dữ liệu cho bảng DOCGIA
--- 1


--- 2


--- 3




-- Nhập dữ liệu cho bảng NHANVIEN




-- Nhập dữ liệu cho bảng TAILIEU_TACGIA
--- 1

--- 2


--- 3

--- 4

--- 5


--- 6

--- 7


--- 8

--- 9


--- 10


-- Nhập dữ liệu cho bảng CTMUONTRA
--- 1


--- 2


--- 3


--- 4


--- 5


-- A. STORED PROCEDURE
--	1. Tham số vào là MaTaiLieu, TenTaiLieu, NgayXuatBan, 
--		MaNXB, MaTheLoai, HienCo, DangMuon. 
--		Trước khi insert dữ liệu cần kiểm tra MaNXB và MaTheLoai 
--		đã tồn tại trong table NHAXUATBAN và THELOAI chưa.
-- (Chức năng nhập tài liệu mới của nhân viên)
SET DATEFORMAT DMY

CREATE PROCEDURE PROC_INSERT_TAILIEU_MaNXB_MaTheLoai
--DS THAM SỐ
	@MaTaiLieu varchar(13), @TenTaiLieu nvarchar(100), @NgayXuatBan smalldatetime, 
	@MaNXB varchar(10), @MaTheLoai varchar(10), @HienCo varchar(2), @DangMuon varchar(2)
AS
BEGIN	
	-- Kiểm tra sự tồn tại của MaNXB và MaTheLoai
	IF EXISTS (SELECT * FROM NHAXUATBAN WHERE MaNXB = @MaNXB) AND EXISTS (SELECT * FROM THELOAI WHERE MaTheLoai = @MaTheLoai)
	BEGIN
		-- Thực hiện INSERT vào bảng TAILIEU
		INSERT INTO TAILIEU (MaTaiLieu, TenTaiLieu, NgayXuatBan, MaNXB, MaTheLoai, HienCo, DangMuon)
		VALUES (@MaTaiLieu, @TenTaiLieu, @NgayXuatBan, @MaNXB, @MaTheLoai, @HienCo, @DangMuon)
		PRINT N'THÊM TÀI LIỆU THÀNH CÔNG'
	END
	ELSE
		BEGIN
			PRINT N'MaNXB HOẶC MaTheLoai KHÔNG TỒN TẠI'
			RETURN 0
		END
END

-- 1.2. THỰC THI
-- 1.2.1 ĐÚNG
EXEC PROC_INSERT_TAILIEU_MaNXB_MaTheLoai 'TAILIEU000001', N'Giới thiệu về ngành Kinh tế học', '17/05/2023', 'KTQD2495', 'SI7683', '5', '0'

-- 1.2.2. SAI (MaNXB KHÔNG TỒN TẠI)
EXEC PROC_INSERT_TAILIEU_MaNXB_MaTheLoai 'TAILIEU000002', N'Tài chính hành vi – Tâm lí quyết định thị trường', '07/09/2018', 'KTQD1234', 
										'SI7683', '7', '0'
-- 1.3. KIỂM TRA
SELECT * FROM TAILIEU

--1.4. KHÔI PHỤC DỮ LIỆU
DELETE FROM TAILIEU WHERE MaTaiLieu = 'TAILIEU000001'

--1.5. XÓA 
DROP PROC PROC_INSERT_TAILIEU_MaNXB_MaTheLoai

-- 2. Dựa vào từ khóa hiển thị:
--	Thông tin các tài liệu có từ khóa đó:  mã tài liệu, tên tài liệu, 
--	tên tác giả, tên nhà xuất bản, ngày xuất bản
CREATE PROC PROC_TaiLieu_BY_TuKhoa
	@TuKhoa NVARCHAR(100)
AS
BEGIN
	-- LOGIC
	IF EXISTS (SELECT * FROM TAILIEU WHERE TAILIEU.TenTaiLieu LIKE '%' + @TuKhoa + '%')
		BEGIN
			SELECT tl.MaTaiLieu as 'Mã tài liệu', tl.TenTaiLieu as 'Tên tài liệu',
			TACGIA.TenTacGia as 'Tên tác giả', 
				nxb.TenNXB as 'Tên nhà xuất bản', 
				tl.NgayXuatBan as 'Ngày xuất bản'
			FROM THELOAI JOIN TAILIEU tl ON THELOAI.MaTheLoai = tl.MaTheLoai
			JOIN NHAXUATBAN nxb ON nxb.MaNXB = tl.MaNXB 
			JOIN TAILIEU_TACGIA ON TAILIEU_TACGIA.MaTaiLieu = tl.MaTaiLieu
			JOIN TACGIA ON TAILIEU_TACGIA.MaTacGia = TACGIA.MaTacGia
			WHERE tl.TenTaiLieu LIKE '%' + @TuKhoa + '%'
		END
	ELSE
		PRINT N'KHÔNG TÌM THẤY TÀI LIỆU CÓ TÊN PHÙ HỢP'
END
GO

-- 2.2. THỰC THI VÀ KIỂM TRA
DECLARE @TuKhoa NVARCHAR(100)
SET @TuKhoa = 'kế'

EXEC PROC_TaiLieu_BY_TuKhoa @TuKhoa

-- 2.3. XÓA
DROP PROC PROC_TaiLieu_BY_TuKhoa
GO

-- 3. Dựa vào số thẻ của thẻ thư viện có thể xem được: 
--		Thông tin các tài liệu đã mượn: mã mượn trả, 
--		tên tài liệu, ngày mượn, tình trạng trả
CREATE PROC PROC_TTMUONTRA_BY_SoThe
	@SoThe VARCHAR(10)
AS
BEGIN
	-- LOGIC
	IF EXISTS (SELECT * FROM THETHUVIEN WHERE SoThe = @SoThe)
		BEGIN
			SELECT ct.MaMuonTra as 'Mã mượn trả', tl.TenTaiLieu as 'Tên tài liệu', 
			ct.NgayMuon as 'Ngày mượn', ct.DaTra as 'Tình trạng trả'
			FROM CTMUONTRA ct JOIN THETHUVIEN ON ct.SoThe = THETHUVIEN.SoThe 
							JOIN TAILIEU tl ON ct.MaTaiLieu = tl.MaTaiLieu
			WHERE THETHUVIEN.SoThe = @SoThe
		END
	ELSE
		PRINT N'SỐ THẺ KHÔNG TỒN TẠI'
END
GO
-- 3.2. THỰC THI VÀ KIỂM TRA
DECLARE @SoThe VARCHAR(10)
SET @SoThe = N'TV00000001'

EXEC PROC_TTMUONTRA_BY_SoThe @SoThe

-- 3.3. XÓA
DROP PROC PROC_TTMUONTRA_BY_SoThe
GO



-- 4. Dựa vào mã mượn trả hiển thị:
--	Số tiền phạt trả trễ hạn (nếu có)

SET DATEFORMAT DMY

CREATE PROC PROC_TienPhat_BY_MaMuonTra
	@MaMuonTra CHAR(11)
AS
BEGIN
	DECLARE @TienPhat money,
			@NgayMuon smalldatetime,
			@GiaHan bit, 
			@MaTheLoai varchar(10)
	SET @NgayMuon = NULL
	SET @GiaHan = NULL
	-- LOGIC
	IF EXISTS (SELECT * FROM CTMUONTRA WHERE CTMUONTRA.MaMuonTra = @MaMuonTra)
		BEGIN
			SELECT @NgayMuon = NgayMuon, @GiaHan = GiaHan, @MaTheLoai = tl.MaTheLoai
			FROM CTMUONTRA ct JOIN TAILIEU tl ON ct.MaTaiLieu = tl.MaTaiLieu JOIN THELOAI ON tl.MaTheLoai = THELOAI.MaTheLoai
			WHERE (GETDATE() - NgayMuon > 45 and THELOAI.MaTheLoai = 'SI7683' and DaTra = 0 and MaMuonTra = @MaMuonTra and GiaHan = 0)
			or (GETDATE() - NgayMuon > 45+7 and THELOAI.MaTheLoai = 'SI7683' and DaTra = 0 and MaMuonTra = @MaMuonTra and GiaHan = 1)
			or (GETDATE() - NgayMuon > 90 and THELOAI.MaTheLoai = 'GT8334' and DaTra = 0 and MaMuonTra = @MaMuonTra and GiaHan = 0)
			or (GETDATE() - NgayMuon > 90+14 and THELOAI.MaTheLoai = 'GT8334' and DaTra = 0 and MaMuonTra = @MaMuonTra and GiaHan = 1)

			IF @NgayMuon IS NULL PRINT N'Mượn chưa quá hạn'
			ELSE 
				BEGIN
					IF @MaTheLoai = 'SI7683' and @GiaHan = 0
						SET @TienPhat = 2000 * (CAST(( GETDATE() - @NgayMuon ) AS int) - 45) 
					ELSE
						IF @MaTheLoai = 'SI7683' and @GiaHan = 1
							SET @TienPhat = 2000 * (CAST(( GETDATE() - @NgayMuon ) AS int) - 45 - 7) 
						ELSE
							IF @MaTheLoai = 'GT8334' and @GiaHan = 0
								SET @TienPhat = 2000 * (CAST(( GETDATE() - @NgayMuon ) AS int) - 90) 
							ELSE
									SET @TienPhat = 2000 * (CAST(( GETDATE() - @NgayMuon ) AS int) - 90 - 7) 
					PRINT N'Số ngày quá hạn là: ' + CAST(CAST((@TienPhat / 2000) AS INT) AS NVARCHAR) 
					PRINT N'Số tiền phạt quá hạn là: ' + CAST(CAST((@TienPhat) AS INT) AS NVARCHAR) + N'VND'
				END
		END
	ELSE
		PRINT N'MÃ MƯỢN TRẢ KHÔNG TỒN TẠI'
END
GO

-- 4.2. THỰC THI VÀ KIỂM TRA
DECLARE @MaMuonTra CHAR(11)
SET @MaMuonTra = 'MT00000006'

EXEC PROC_TienPhat_BY_MaMuonTra @MaMuonTra

-- 4.3. XÓA
DROP PROC PROC_TienPhat_BY_MaMuonTra
GO






-- B. TRIGGER
-- 1. Ngày hết hạn của thẻ thư viện phải sau ngày bắt đầu.
-- (Ràng buộc logic thời gian)
CREATE TRIGGER TRIG_INSERT_UPDATE_NBD_NHH
ON THETHUVIEN FOR INSERT,UPDATE
AS
BEGIN
	IF (SELECT COUNT(*) 
		FROM INSERTED 
		WHERE INSERTED.NgayBatDau > INSERTED.NgayHetHan) > 0
	BEGIN
	ROLLBACK TRANSACTION
	RAISERROR (N'NGÀY HẾT HẠN CỦA THẺ THƯ VIỆN PHẢI SAU NGÀY BẮT ĐẦU', 16, 1)
	RETURN
	END
END

SET DATEFORMAT DMY

-- 1.2. THỰC THI
-- 1.2.1. KIỂM TRA VỚI INSERT
INSERT INTO THETHUVIEN VALUES ('TV00000026', '07/09/2022', '07/09/2021') -- DỮ LIỆU SAI --> BÁO LỖI --> TRIGGER ĐÚNG
INSERT INTO THETHUVIEN VALUES ('TV00000026', '07/09/2022', '07/09/2026') -- DỮ LIỆU ĐÚNG --> KHÔNG BÁO LỖI --> TRIGGER ĐÚNG

-- 1.2.2. KIỂM TRA VỚI UPDATE
UPDATE THETHUVIEN
SET NgayHetHan = '07/09/2021'
WHERE SoThe = 'TV00000026'  -- BÁO LỖI -> TRIGGER đúng

-- 1.3. KIỂM TRA DỮ LIỆU TRONG BẢNG
SELECT * FROM THETHUVIEN

-- 1.4. KHÔI PHỤC DỮ LIỆU
DELETE FROM THETHUVIEN WHERE SoThe = 'TV00000026'

-- 1.5. XÓA
DROP TRIGGER TRIG_INSERT_UPDATE_NBD_NHH
GO

-- 2.2. Mỗi thẻ thư viện không được mượn quá 3 cuốn sách..
CREATE TRIGGER TRIG_INSERT_UPDATE_ST
ON CTMUONTRA FOR INSERT, UPDATE
AS
BEGIN
	IF (SELECT COUNT(*) 
		FROM INSERTED, CTMUONTRA ct
		WHERE INSERTED.SoThe = ct.SoThe AND INSERTED.MaMuonTra 
							<> ct.MaMuonTra AND ct.DaTra = 0) > 2
	BEGIN
	ROLLBACK TRANSACTION
	RAISERROR (N'MỖI THẺ THƯ VIỆN KHÔNG ĐƯỢC MƯỢN QUÁ 3 QUYỂN TÀI LIỆU', 16, 1)
	RETURN
	END
END

SET DATEFORMAT DMY

-- 2.2. THỰC THI
-- 2.2.1. KIỂM TRA VỚI INSERT
INSERT INTO CTMUONTRA VALUES ('MT00000046', '09/09/2022', 1, 0, '08/10/2022', '', 
								'TV00000002', 'QATTMXC059874', 'NV002') -- BÁO LỖI -> TRIGGER ĐÚNG
INSERT INTO CTMUONTRA VALUES ('MT00000046', '09/09/2022', 1, 0, '08/10/2022', '', 
								'TV00000017', 'QATTMXC059874', 'NV002') -- KO BÁO LỖI -> TRIGGER ĐÚNG
-- 2.2.2. KIỂM TRA VỚI UPDATE
UPDATE CTMUONTRA
SET SoThe = 'TV00000002'
WHERE MaMuonTra = 'MT00000046'  -- BÁO LỖI -> TRIGGER ĐÚNG

-- 2.3. KIỂM TRA
SELECT * FROM CTMUONTRA

-- 2.4. KHÔI PHỤC DỮ LIỆU
DELETE FROM CTMUONTRA WHERE MaMuonTra = 'MT00000046'

-- 2.5. XÓA
DROP TRIGGER TRIG_INSERT_UPDATE_ST
GO

-- 3. Nhân viên tối thiểu phải 15 tuổi trở lên.
CREATE TRIGGER TRIG_INSERT_UPDATE_NS
ON NHANVIEN FOR INSERT, UPDATE
AS
BEGIN
	IF (SELECT COUNT(*) 
		FROM INSERTED, NHANVIEN NV
		WHERE NV.MaNV = INSERTED.MaNV AND YEAR(INSERTED.NgaySinh)>=2008) > 0
	BEGIN
	ROLLBACK TRANSACTION
	RAISERROR (N'NHÂN VIÊN TỐI THIỂU PHẢI TỪ 15 TUỔI TRỞ LÊN', 16, 1)
	RETURN
	END
END

SET DATEFORMAT DMY

-- 3.2. KIỂM TRA
-- 3.2.1. KIỂM TRA VỚI INSERT
INSERT INTO NHANVIEN VALUES ('NV006', N'Lâm Vũ', N'Nữ', '09/03/2008', '0783336224') -- BÁO LỖI -> TRIGGER đúng
INSERT INTO NHANVIEN VALUES ('NV006', N'Lâm Vũ', N'Nữ', '09/03/1990', '0783336224') -- KO BÁO LỖI -> TRIGGER đúng

-- 3.2.2. KIỂM TRA VỚI UPDATE
UPDATE NHANVIEN
SET NgaySinh = '09/03/2008'
WHERE MaNV = 'NV005'  -- BÁO LỖI -> TRIGGER đúng

---- 3.3. KIỂM TRA DỮ LIỆU TRONG BẢNG
SELECT * FROM NHANVIEN

---- 3.4. KHÔI PHỤC DỮ LIỆU
DELETE FROM NHANVIEN WHERE MaNV = 'NV006'

---- 3s.5. XÓA
DROP TRIGGER TRIG_INSERT_UPDATE_NS

-- 4. Ngày bắt đầu của thẻ thư viện phải trước hoặc bằng ngày hiện tại.
CREATE TRIGGER TRIG_INSERT_UPDATE_NBD
ON THETHUVIEN FOR INSERT,UPDATE
AS
BEGIN
	IF (SELECT COUNT(*) 
		FROM INSERTED 
		WHERE INSERTED.NgayBatDau > GETDATE()) > 0
	BEGIN
	ROLLBACK TRANSACTION
	RAISERROR (N'NGÀY BẮT ĐẦU CỦA THẺ THƯ VIỆN PHẢI TRƯỚC HOẶC BẰNG NGÀY HIỆN TẠI', 16, 1)
	RETURN
	END
END

SET DATEFORMAT DMY

-- 4.2. KIỂM TRA
-- 4.2.1. KIỂM TRA VỚI INSERT
INSERT INTO THETHUVIEN VALUES ('TV00000026', '07/09/2023', '07/09/2026') -- BÁO LỖI -> TRIGGER ĐÚNG
INSERT INTO THETHUVIEN VALUES ('TV00000026', '07/09/2022', '07/09/2026') -- KO BÁO LỖI -> TRIGGER ĐÚNG

-- 4.2.2. KIỂM TRA VỚI UPDATE
UPDATE THETHUVIEN
SET NgayBatDau = '07/09/2023'
WHERE SoThe = 'TV00000026'  -- BÁO LỖI -> TRIGGER ĐÚNG

---- 4.3.. KIỂM TRA DỮ LIỆU TRONG BẢNG
SELECT * FROM THETHUVIEN

---- 4.4. KHÔI PHỤC DỮ LIỆU
DELETE FROM THETHUVIEN WHERE SoThe = 'TV00000026'

---- 4.5. XÓA
DROP TRIGGER TRIG_INSERT_UPDATE_NBD

GO


