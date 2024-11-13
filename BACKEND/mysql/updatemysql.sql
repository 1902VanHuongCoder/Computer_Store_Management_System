-- NHÀ SẢN XUẤT 
DELIMITER //
CREATE FUNCTION IsValidTenNSX(p_TenNSX VARCHAR(255)) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_TenNSX IS NOT NULL AND p_TenNSX <> '');
END //
DELIMITER; 

DELIMITER //
CREATE FUNCTION IsValidQuocGia(p_QuocGia VARCHAR(255)) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_QuocGia IS NOT NULL AND p_QuocGia <> '');
END //
DELIMITER ;


-- 2. Tạo Trigger để kiểm tra dữ liệu trước khi thêm mới nhà sản xuất
DELIMITER //
CREATE TRIGGER BeforeInsertNhaSanXuat
BEFORE INSERT ON NhaSanXuat
FOR EACH ROW
BEGIN
    -- Kiểm tra tên nhà sản xuất không được để trống
    IF NOT IsValidTenNSX(NEW.TenNSX) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Tên nhà sản xuất không được để trống'; 
    END IF;

    -- Kiểm tra quốc gia không được để trống
    IF NOT IsValidQuocGia(NEW.QuocGia) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Quốc gia không được để trống'; 
    END IF;
END //
DELIMITER ;
DROP TRIGGER IF EXISTS BeforeInsertNhaSanXuat;




-- 3. Tạo Stored Procedure để lấy tất cả nhà sản xuất
DELIMITER //
CREATE PROCEDURE GetAllNhaSanXuat()
BEGIN
    -- Lấy toàn bộ thông tin từ bảng NhaSanXuat
    SELECT * FROM NhaSanXuat;
END //
DELIMITER ;



-- 4. Tạo Stored Procedure để lấy nhà sản xuất theo mã (MaNSX)
DELIMITER //
CREATE PROCEDURE GetNhaSanXuatById(IN p_MaNSX INT)
BEGIN
    -- Lấy thông tin nhà sản xuất dựa vào MaNSX
    SELECT * FROM NhaSanXuat WHERE MaNSX = p_MaNSX;
END //
DELIMITER ;

-- 5. Tạo Stored Procedure để thêm nhà sản xuất mới với kiểm tra dữ liệu đầu vào
DELIMITER //
CREATE PROCEDURE AddNhaSanXuat(
    IN p_TenNSX VARCHAR(255),
    IN p_QuocGia VARCHAR(255)
)
BEGIN
    -- Thêm nhà sản xuất mới vào bảng
    INSERT INTO NhaSanXuat (TenNSX, QuocGia) VALUES (p_TenNSX, p_QuocGia);
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS AddNhaSanXuat;
-- Kiểm tra khi xóa
DELIMITER //

CREATE TRIGGER BeforeDeleteNhaSanXuat
BEFORE DELETE ON NhaSanXuat
FOR EACH ROW
BEGIN
    -- Kiểm tra xem nhà sản xuất có tồn tại trong bảng ThietBi không
    IF EXISTS (SELECT 1 FROM ThietBi WHERE MaNSX = OLD.MaNSX) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không thể xóa nhà sản xuất này vì đã có thiết bị liên quan';
    END IF;
END //

DELIMITER ;

-- 6. Tạo Stored Procedure để xóa nhà sản xuất theo mã (MaNSX)
DELIMITER //
CREATE PROCEDURE DeleteNhaSanXuat(
    IN p_MaNSX INT
)
BEGIN
    -- Xóa nhà sản xuất dựa vào MaNSX
    DELETE FROM NhaSanXuat WHERE MaNSX = p_MaNSX;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS DeleteNhaSanXuat;
-- 7. Tạo Stored Procedure để cập nhật thông tin nhà sản xuất
DELIMITER //
CREATE PROCEDURE UpdateNhaSanXuat(
    IN p_MaNSX INT,
    IN p_TenNSX VARCHAR(255),
    IN p_QuocGia VARCHAR(255)
)
BEGIN
    -- Cập nhật thông tin nhà sản xuất dựa trên MaNSX
    UPDATE NhaSanXuat
    SET TenNSX = p_TenNSX, QuocGia = p_QuocGia
    WHERE MaNSX = p_MaNSX;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS UpdateNhaSanXuat;
-- 8. Tạo Trigger để kiểm tra khi cập nhật nhà sản xuất
DELIMITER //
CREATE TRIGGER BeforeUpdateNhaSanXuat
BEFORE UPDATE ON NhaSanXuat
FOR EACH ROW
BEGIN
    -- Kiểm tra tên nhà sản xuất không được để trống khi cập nhật
    IF NOT IsValidTenNSX(NEW.TenNSX) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Tên nhà sản xuất không được để trống'; 
    END IF;

    -- Kiểm tra quốc gia không được để trống khi cập nhật
    IF NOT IsValidQuocGia(NEW.QuocGia) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Quốc gia không được để trống'; 
    END IF;
END //
DELIMITER ;

DROP TRIGGER IF EXISTS BeforeUpdateNhaSanXuat;

-- NHÀ CUNG CẤP ------------------------------
DELIMITER //
CREATE FUNCTION IsValidTenNhaCungCap(p_TenNhaCungCap VARCHAR(255)) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_TenNhaCungCap IS NOT NULL AND p_TenNhaCungCap <> '');
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION IsValidSoDienThoai(p_SoDienThoai VARCHAR(20)) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_SoDienThoai IS NOT NULL AND 
            LENGTH(p_SoDienThoai) = 10 AND 
            p_SoDienThoai REGEXP '^[0-9]+$' AND 
            p_SoDienThoai LIKE '0%');
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION IsValidDiaChi(p_DiaChi TEXT) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_DiaChi IS NOT NULL AND p_DiaChi <> '');
END //
DELIMITER ;
-- 1. Tạo Trigger để kiểm tra dữ liệu trước khi thêm mới nhà cung cấp
DELIMITER //
CREATE TRIGGER BeforeInsertNhaCungCap
BEFORE INSERT ON NhaCungCap
FOR EACH ROW
BEGIN
    -- Kiểm tra tên nhà cung cấp không được để trống
    IF NOT IsValidTenNhaCungCap(NEW.TenNhaCungCap) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Tên nhà cung cấp không được để trống'; 
    END IF;

    -- Kiểm tra số điện thoại
    IF NOT IsValidSoDienThoai(NEW.SoDienThoai) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số điện thoại không hợp lệ'; 
    END IF;

    -- Kiểm tra địa chỉ không được để trống
    IF NOT IsValidDiaChi(NEW.DiaChi) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Địa chỉ không được để trống'; 
    END IF;
END //
DELIMITER ;

-- 2. Tạo Stored Procedure để lấy tất cả nhà cung cấp
DELIMITER //
CREATE PROCEDURE GetAllNhaCungCap()
BEGIN
    -- Lấy toàn bộ thông tin từ bảng NhaCungCap
    SELECT * FROM NhaCungCap;
END //
DELIMITER ;

-- 3. Tạo Stored Procedure để lấy nhà cung cấp theo mã (MaNhaCungCap)
DELIMITER //
CREATE PROCEDURE GetNhaCungCapById(IN p_MaNhaCungCap INT)
BEGIN
    -- Lấy thông tin nhà cung cấp dựa vào MaNhaCungCap
    SELECT * FROM NhaCungCap WHERE MaNhaCungCap = p_MaNhaCungCap;
END //
DELIMITER ;

-- 4. Tạo Stored Procedure để thêm nhà cung cấp mới với kiểm tra dữ liệu đầu vào
DELIMITER //
CREATE PROCEDURE AddNhaCungCap(
    IN p_TenNhaCungCap VARCHAR(255),
    IN p_DiaChi TEXT,
    IN p_SoDienThoai VARCHAR(20)
)
BEGIN
    -- Thêm nhà cung cấp mới vào bảng
    INSERT INTO NhaCungCap (TenNhaCungCap, DiaChi, SoDienThoai) 
    VALUES (p_TenNhaCungCap, p_DiaChi, p_SoDienThoai);
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS AddNhaCungCap;
-- Kiểm tra trước khi xóa
DELIMITER //

CREATE TRIGGER BeforeDeleteNhaCungCap
BEFORE DELETE ON NhaCungCap
FOR EACH ROW
BEGIN
    -- Kiểm tra xem nhà cung cấp có đang được tham chiếu trong bảng ThietBi không
    IF EXISTS (SELECT 1 FROM ThietBi WHERE MaNhaCungCap = OLD.MaNhaCungCap) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không thể xóa nhà cung cấp này vì đã có thiết bị liên quan';
    END IF;

    -- Kiểm tra xem nhà cung cấp có tồn tại trong bảng PhieuNhap không
    IF EXISTS (SELECT 1 FROM PhieuNhap WHERE MaNhaCungCap = OLD.MaNhaCungCap) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không thể xóa nhà cung cấp này vì đã có phiếu nhập liên quan';
    END IF;
END //

DELIMITER ;

-- 5. Tạo Stored Procedure để xóa nhà cung cấp theo mã (MaNhaCungCap)
DELIMITER //
CREATE PROCEDURE DeleteNhaCungCap(
    IN p_MaNhaCungCap INT
)
BEGIN
    -- Xóa nhà cung cấp dựa vào MaNhaCungCap
    DELETE FROM NhaCungCap WHERE MaNhaCungCap = p_MaNhaCungCap;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS DeleteNhaCungCap;
-- 6. Tạo Stored Procedure để cập nhật thông tin nhà cung cấp
DELIMITER //
CREATE PROCEDURE UpdateNhaCungCap(
    IN p_MaNhaCungCap INT,
    IN p_TenNhaCungCap VARCHAR(255),
    IN p_DiaChi TEXT,
    IN p_SoDienThoai VARCHAR(20)
)
BEGIN
    -- Cập nhật thông tin nhà cung cấp dựa trên MaNhaCungCap
    UPDATE NhaCungCap
    SET TenNhaCungCap = p_TenNhaCungCap, DiaChi = p_DiaChi, SoDienThoai = p_SoDienThoai
    WHERE MaNhaCungCap = p_MaNhaCungCap;
END //
DELIMITER ;

-- kiểm tra khi cập nhật
DELIMITER //
CREATE TRIGGER BeforeUpdateNhaCungCap
BEFORE UPDATE ON NhaCungCap
FOR EACH ROW
BEGIN
    -- Kiểm tra tên nhà cung cấp không được để trống khi cập nhật
    IF NOT IsValidTenNhaCungCap(NEW.TenNhaCungCap) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên nhà cung cấp không được để trống khi cập nhật';
    END IF;

    -- Kiểm tra số điện thoại khi cập nhật
    IF NOT IsValidSoDienThoai(NEW.SoDienThoai) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số điện thoại không hợp lệ'; 
    END IF;

    -- Kiểm tra địa chỉ không được để trống
    IF NOT IsValidDiaChi(NEW.DiaChi) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Địa chỉ không được để trống'; 
    END IF;
END //
DELIMITER ;

-- LOẠI THIET BỊ ------------------------------
DELIMITER //
CREATE FUNCTION IsValidTenLoai(p_TenLoai VARCHAR(255)) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_TenLoai IS NOT NULL AND p_TenLoai <> '');
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION IsValidDonViTinh(p_DonViTinh VARCHAR(50)) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_DonViTinh IS NOT NULL AND p_DonViTinh <> '');
END //
DELIMITER ;
-- 1. Tạo Trigger để kiểm tra dữ liệu
DELIMITER //
CREATE TRIGGER BeforeInsertLoaiThietBi
BEFORE INSERT ON LoaiThietBi
FOR EACH ROW
BEGIN
    -- Kiểm tra tên loại thiết bị không được để trống
    IF NOT IsValidTenLoai(NEW.TenLoai) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Tên loại thiết bị không được để trống'; 
    END IF;

    -- Kiểm tra đơn vị tính không được để trống
    IF NOT IsValidDonViTinh(NEW.DonViTinh) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Đơn vị tính không được để trống'; 
    END IF;
END //
DELIMITER ;
DROP TRIGGER IF EXISTS BeforeInsertLoaiThietBi;
-- 2. Lấy tất cả
DELIMITER //
CREATE PROCEDURE GetAllLoaiThietBi()
BEGIN
    SELECT * FROM LoaiThietBi;
END //
DELIMITER ;

-- 3. Lấy theo id
DELIMITER //
CREATE PROCEDURE GetLoaiThietBiById(IN p_MaLoai INT)
BEGIN
    SELECT * FROM LoaiThietBi WHERE MaLoai = p_MaLoai;
END //
DELIMITER ;

-- 4. Thêm loại thiết bị
DELIMITER //
CREATE PROCEDURE AddLoaiThietBi(
    IN p_TenLoai VARCHAR(255),
    IN p_DonViTinh VARCHAR(50),
    IN p_GhiChu TEXT
)
BEGIN
    -- Thêm loại thiết bị mới vào bảng
    INSERT INTO LoaiThietBi (TenLoai, DonViTinh, GhiChu) 
    VALUES (p_TenLoai, p_DonViTinh, p_GhiChu);
END //
DELIMITER ;
-- Kiểm tra trước khi xóa
DELIMITER //

CREATE TRIGGER BeforeDeleteLoaiThietBi
BEFORE DELETE ON LoaiThietBi
FOR EACH ROW
BEGIN
    -- Kiểm tra xem loại thiết bị có tồn tại trong bảng ThietBi không
    IF EXISTS (SELECT 1 FROM ThietBi WHERE MaLoai = OLD.MaLoai) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không thể xóa loại thiết bị này vì đã có thiết bị liên quan';
    END IF;
END //

DELIMITER ;

-- 5. Xóa loại thiết bị
DELIMITER //
CREATE PROCEDURE DeleteLoaiThietBi(
    IN p_MaLoai INT
)
BEGIN
    -- Xóa loại thiết bị dựa vào MaLoai
    DELETE FROM LoaiThietBi WHERE MaLoai = p_MaLoai;
END //
DELIMITER ;

-- 6. Chỉnh sửa loại thiết bị
DELIMITER //
CREATE PROCEDURE UpdateLoaiThietBi(
    IN p_MaLoai INT,
    IN p_TenLoai VARCHAR(255),
    IN p_DonViTinh VARCHAR(50),
    IN p_GhiChu TEXT
)
BEGIN
    -- Cập nhật thông tin loại thiết bị dựa trên MaLoai
    UPDATE LoaiThietBi
    SET TenLoai = p_TenLoai, DonViTinh = p_DonViTinh, GhiChu = p_GhiChu
    WHERE MaLoai = p_MaLoai;
END //
DELIMITER ;

-- 7. Tạo Trigger để kiểm tra khi cập nhật loại thiết bị
DELIMITER //
CREATE TRIGGER BeforeUpdateLoaiThietBi
BEFORE UPDATE ON LoaiThietBi
FOR EACH ROW
BEGIN
    -- Kiểm tra tên loại thiết bị không được để trống khi cập nhật
    IF NOT IsValidTenLoai(NEW.TenLoai) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Tên loại thiết bị không được để trống'; 
    END IF;

    -- Kiểm tra đơn vị tính không được để trống khi cập nhật
    IF NOT IsValidDonViTinh(NEW.DonViTinh) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Đơn vị tính không được để trống'; 
    END IF;
END //
DELIMITER ;

-- KHÁCH HÀNG -------------
DELIMITER //
CREATE FUNCTION IsValidTenKhachHang(p_TenKhachHang VARCHAR(255)) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_TenKhachHang IS NOT NULL AND p_TenKhachHang <> '');
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION IsValidSoDienThoaiKhachHang(p_SoDienThoai VARCHAR(20)) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_SoDienThoai IS NOT NULL AND 
            LENGTH(p_SoDienThoai) = 10 AND 
            p_SoDienThoai REGEXP '^[0-9]+$' AND 
            p_SoDienThoai LIKE '0%');
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION IsValidDiaChiKhachHang(p_DiaChi TEXT) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_DiaChi IS NOT NULL AND p_DiaChi <> '');
END //
DELIMITER ;
-- 1. Kiểm tra trước khi thêm
DELIMITER //
CREATE TRIGGER BeforeInsertKhachHang
BEFORE INSERT ON KhachHang
FOR EACH ROW
BEGIN
    -- Kiểm tra tên khách hàng không được để trống
    IF NOT IsValidTenKhachHang(NEW.TenKhachHang) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Tên khách hàng không được để trống'; 
    END IF;

    -- Kiểm tra số điện thoại
    IF NOT IsValidSoDienThoaiKhachHang(NEW.SoDienThoai) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Số điện thoại không hợp lệ'; 
    END IF;

    -- Kiểm tra địa chỉ không được để trống
    IF NOT IsValidDiaChiKhachHang(NEW.DiaChi) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Địa chỉ không được để trống'; 
    END IF;
END //
DELIMITER ;

DROP TRIGGER IF EXISTS BeforeInsertKhachHang;
-- 2. Lấy tất cả -------------
DELIMITER //
CREATE PROCEDURE GetAllKhachHang()
BEGIN
    -- Lấy toàn bộ thông tin từ bảng KhachHang
    SELECT * FROM KhachHang;
END //
DELIMITER ;

-- 3. Lấy theo mã -------------
DELIMITER //
CREATE PROCEDURE GetKhachHangById(IN p_MaKhachHang INT)
BEGIN
    -- Lấy thông tin khách hàng dựa vào MaKhachHang
    SELECT * FROM KhachHang WHERE MaKhachHang = p_MaKhachHang;
END //
DELIMITER ;

-- 4. Thêm khách hàng ------------
DELIMITER //
CREATE PROCEDURE AddKhachHang(
    IN p_TenKhachHang VARCHAR(255),
    IN p_DiaChi TEXT,
    IN p_SoDienThoai VARCHAR(20)
)
BEGIN
    -- Thêm khách hàng mới vào bảng KhachHang
    INSERT INTO KhachHang (TenKhachHang, DiaChi, SoDienThoai) 
    VALUES (p_TenKhachHang, p_DiaChi, p_SoDienThoai);
END //
DELIMITER ;
-- Kiểm tra trước khi xóa
DELIMITER //

-- Kiểm tra khi xóa
CREATE TRIGGER BeforeDeleteKhachHang
BEFORE DELETE ON KhachHang
FOR EACH ROW
BEGIN
    -- Kiểm tra xem khách hàng có tồn tại trong bảng PhieuXuat không
    IF EXISTS (SELECT 1 FROM PhieuXuat WHERE MaKhachHang = OLD.MaKhachHang) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không thể xóa khách hàng này vì đã có phiếu xuất liên quan';
    END IF;
END //

DELIMITER ;

-- 5. Xóa khách hàng ---------------
DELIMITER //
CREATE PROCEDURE DeleteKhachHang(
    IN p_MaKhachHang INT
)
BEGIN
    -- Xóa khách hàng dựa vào MaKhachHang
    DELETE FROM KhachHang WHERE MaKhachHang = p_MaKhachHang;
END //
DELIMITER ;

-- 6. Chỉnh sửa khách hàng ------------
DELIMITER //
CREATE PROCEDURE UpdateKhachHang(
    IN p_MaKhachHang INT,
    IN p_TenKhachHang VARCHAR(255),
    IN p_DiaChi TEXT,
    IN p_SoDienThoai VARCHAR(20)
)
BEGIN
    -- Cập nhật thông tin khách hàng dựa trên MaKhachHang
    UPDATE KhachHang
    SET TenKhachHang = p_TenKhachHang, DiaChi = p_DiaChi, SoDienThoai = p_SoDienThoai
    WHERE MaKhachHang = p_MaKhachHang;
END //
DELIMITER ;

-- 7. Kiểm tra khi sửa
DELIMITER //
CREATE TRIGGER BeforeUpdateKhachHang
BEFORE UPDATE ON KhachHang
FOR EACH ROW
BEGIN
    -- Kiểm tra tên khách hàng không được để trống khi cập nhật
    IF NOT IsValidTenKhachHang(NEW.TenKhachHang) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Tên khách hàng không được để trống'; 
    END IF;

    -- Kiểm tra số điện thoại khi cập nhật
    IF NOT IsValidSoDienThoaiKhachHang(NEW.SoDienThoai) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Số điện thoại không hợp lệ'; 
    END IF;

    -- Kiểm tra địa chỉ không được để trống
    IF NOT IsValidDiaChiKhachHang(NEW.DiaChi) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Địa chỉ không được để trống'; 
    END IF;
END //
DELIMITER ;
DROP TRIGGER IF EXISTS BeforeUpdateKhachHang;

ALTER TABLE chiTietPhieuNhap DROP FOREIGN KEY chiTietPhieuNhap_ibfk_2;  
ALTER TABLE chiTietPhieuXuat DROP FOREIGN KEY chiTietPhieuXuat_ibfk_2;  

ALTER TABLE PhieuXuat DROP FOREIGN KEY phieuxuat_ibfk_1;

ALTER TABLE NhanVien CHANGE COLUMN MaNhanVien MaNhanVien VARCHAR(255) NOT NULL;

ALTER TABLE NhanVien 
ADD COLUMN ChucVu VARCHAR(255),
ADD COLUMN MatKhau VARCHAR(255);

-- NHÂN VIÊN ------------
DELIMITER //
CREATE FUNCTION IsValidHoTen(p_HoTen VARCHAR(255)) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_HoTen IS NOT NULL AND p_HoTen <> '');
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION IsValidSoDienThoaiNhanVien(p_SoDienThoai VARCHAR(20)) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_SoDienThoai IS NOT NULL AND 
            LENGTH(p_SoDienThoai) = 10 AND 
            p_SoDienThoai REGEXP '^[0-9]+$' AND 
            p_SoDienThoai LIKE '0%');
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION IsValidNgaySinh(p_NgaySinh DATE) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_NgaySinh IS NOT NULL);
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION IsValidChucVu(p_ChucVu VARCHAR(100)) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_ChucVu IS NOT NULL AND p_ChucVu <> '');
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION IsValidMatKhau(p_MatKhau VARCHAR(255)) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_MatKhau IS NOT NULL AND LENGTH(p_MatKhau) >= 6);
END //
DELIMITER ;
-- 1. Kiểm tra
DELIMITER //
CREATE TRIGGER BeforeInsertNhanVien
BEFORE INSERT ON NhanVien
FOR EACH ROW
BEGIN
    -- Kiểm tra số điện thoại đã tồn tại trong bảng NhanVien
    IF EXISTS (SELECT 1 FROM NhanVien WHERE SoDienThoai = NEW.SoDienThoai) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số điện thoại này đã được đăng ký';
    END IF;

    -- Kiểm tra tên nhân viên không được để trống
    IF NOT IsValidHoTen(NEW.HoTen) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên nhân viên không được để trống';
    END IF;

    -- Kiểm tra số điện thoại
    IF NOT IsValidSoDienThoaiNhanVien(NEW.SoDienThoai) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số điện thoại không hợp lệ'; 
    END IF;

    -- Kiểm tra ngày sinh không được để trống
    IF NOT IsValidNgaySinh(NEW.NgaySinh) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ngày sinh không được để trống'; 
    END IF;

    -- Kiểm tra chức vụ không được để trống
    IF NOT IsValidChucVu(NEW.ChucVu) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Chức vụ không được để trống';
    END IF;

    -- Kiểm tra mật khẩu không được để trống và phải có ít nhất 6 ký tự
    IF NOT IsValidMatKhau(NEW.MatKhau) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mật khẩu phải có ít nhất 6 ký tự';
    END IF;
END //
DELIMITER ;

-- 2. Lấy tất cả
DELIMITER //
CREATE PROCEDURE GetAllNhanVien()
BEGIN
    -- Lấy toàn bộ thông tin từ bảng NhanVien
    SELECT * FROM NhanVien;
END //
DELIMITER ;

-- 3. Lấy mã
DELIMITER //
CREATE PROCEDURE GetNhanVienById(IN p_MaNhanVien VARCHAR(255))
BEGIN
    SELECT * FROM NhanVien WHERE MaNhanVien = p_MaNhanVien;
END //
DELIMITER ;

-- 4. Thêm
DELIMITER //
CREATE PROCEDURE AddNhanVien(
    IN p_MaNhanVien VARCHAR(255),
    IN p_HoTen VARCHAR(255),
    IN p_NgaySinh DATE,
    IN p_SoDienThoai VARCHAR(20),
    IN p_ChucVu VARCHAR(100),
    IN p_MatKhau VARCHAR(255)
)
BEGIN
    INSERT INTO NhanVien (MaNhanVien, HoTen, NgaySinh, SoDienThoai, ChucVu, MatKhau) 
    VALUES (p_MaNhanVien, p_HoTen, p_NgaySinh, p_SoDienThoai, p_ChucVu, p_MatKhau);
END //
DELIMITER ;

-- 5. Chỉnh sửa
DELIMITER //
CREATE PROCEDURE UpdateNhanVien(
    IN p_MaNhanVien VARCHAR(255),
    IN p_HoTen VARCHAR(255),
    IN p_NgaySinh DATE,
    IN p_SoDienThoai VARCHAR(20),
    IN p_ChucVu VARCHAR(100),
    IN p_MatKhau VARCHAR(255)
)
BEGIN
    UPDATE NhanVien
    SET HoTen = p_HoTen, NgaySinh = p_NgaySinh, SoDienThoai = p_SoDienThoai, 
        ChucVu = p_ChucVu, MatKhau = p_MatKhau
    WHERE MaNhanVien = p_MaNhanVien;
END //
DELIMITER ;

-- 6. Kiểm tra trước khi xóa
DELIMITER //

CREATE TRIGGER BeforeDeleteNhanVien
BEFORE DELETE ON NhanVien
FOR EACH ROW
BEGIN
    -- Kiểm tra xem nhân viên có tồn tại trong bảng PhieuNhap không
    IF EXISTS (SELECT 1 FROM PhieuNhap WHERE MaNhanVien = OLD.MaNhanVien) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không thể xóa nhân viên này vì đã tồn tại trong Phiếu Nhập';
    END IF;

    -- Kiểm tra xem nhân viên có tồn tại trong bảng PhieuXuat không
    IF EXISTS (SELECT 1 FROM PhieuXuat WHERE MaNhanVien = OLD.MaNhanVien) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không thể xóa nhân viên này vì đã tồn tại trong Phiếu Xuất';
    END IF;

    -- Có thể thêm kiểm tra các bảng khác nếu cần
END //

DELIMITER ;

-- 7. Xóa
DELIMITER //
CREATE PROCEDURE DeleteNhanVien(
    IN p_MaNhanVien VARCHAR(255)
)
BEGIN
    DELETE FROM NhanVien WHERE MaNhanVien = p_MaNhanVien;
END //
DELIMITER ;

-- 8. Kiểm tra
DELIMITER //
CREATE TRIGGER BeforeUpdateNhanVien
BEFORE UPDATE ON NhanVien
FOR EACH ROW
BEGIN
    -- Kiểm tra tên nhân viên không được để trống khi cập nhật
    IF NOT IsValidHoTen(NEW.HoTen) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên nhân viên không được để trống';
    END IF;

    -- Kiểm tra chức vụ không được để trống khi cập nhật
    IF NOT IsValidChucVu(NEW.ChucVu) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Chức vụ không được để trống';
    END IF;

    -- Kiểm tra mật khẩu chỉ khi người dùng nhập mật khẩu mới
    IF NEW.MatKhau IS NOT NULL AND NEW.MatKhau != '' THEN
        IF NOT IsValidMatKhau(NEW.MatKhau) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Mật khẩu phải có ít nhất 6 ký tự';
        END IF;
    ELSE
        -- Nếu không nhập mật khẩu mới, giữ mật khẩu cũ
        SET NEW.MatKhau = OLD.MatKhau;
    END IF;
END //
DELIMITER ;

-- Đăng nhập ------------------------
DELIMITER //
CREATE PROCEDURE Login(
    IN p_SoDienThoai VARCHAR(20)
)
BEGIN
    DECLARE v_MatKhau VARCHAR(255);
    DECLARE v_MaNhanVien VARCHAR(255);
    DECLARE v_HoTen VARCHAR(255);
    DECLARE v_ChucVu VARCHAR(100);
    
    -- Lấy mật khẩu, mã nhân viên, tên nhân viên và chức vụ từ cơ sở dữ liệu
    SELECT MatKhau, MaNhanVien, HoTen, ChucVu INTO v_MatKhau, v_MaNhanVien, v_HoTen, v_ChucVu
    FROM NhanVien
    WHERE SoDienThoai = p_SoDienThoai;

    -- Kiểm tra xem nhân viên có tồn tại không
    IF v_MatKhau IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số điện thoại không đúng';
    END IF;

    -- Nếu đăng nhập thành công, trả về thông tin nhân viên
    SELECT v_MaNhanVien AS MaNhanVien, v_HoTen AS HoTen, v_ChucVu AS ChucVu, v_MatKhau AS MatKhau;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS Login;
-- THIẾT BỊ ------------------------------
DELIMITER //
CREATE FUNCTION IsValidTenThietBi(p_TenThietBi VARCHAR(255)) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_TenThietBi IS NOT NULL AND p_TenThietBi <> '');
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION IsValidThongSoKT(p_ThongSoKT TEXT) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_ThongSoKT IS NOT NULL AND p_ThongSoKT <> '');
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION IsValidMaNSX(p_MaNSX INT) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_MaNSX IS NOT NULL);
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION IsValidMaLoai(p_MaLoai INT) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_MaLoai IS NOT NULL);
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION IsValidMaNhaCungCap(p_MaNhaCungCap INT) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_MaNhaCungCap IS NOT NULL);
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION IsValidGiaThanhNotNull(p_GiaThanh INT) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_GiaThanh IS NOT NULL);
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION IsValidGiaThanhNotNegative(p_GiaThanh INT) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_GiaThanh >= 0);
END //
DELIMITER ;
-- 1. Kiểm tra trước khi thêm thiết bị
DELIMITER //
CREATE TRIGGER BeforeInsertThietBi
BEFORE INSERT ON ThietBi
FOR EACH ROW
BEGIN
    -- Kiểm tra tên thiết bị không được để trống
    IF NOT IsValidTenThietBi(NEW.TenThietBi) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên thiết bị không được để trống';
    END IF;

    -- Kiểm tra giá thành không được để trống
    IF NOT IsValidGiaThanhNotNull(NEW.GiaThanh) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Giá thành không được để trống';
    END IF;

    -- Kiểm tra giá thành không được âm
    IF NOT IsValidGiaThanhNotNegative(NEW.GiaThanh) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Giá thành không được âm';
    END IF;

    -- Kiểm tra thông số kỹ thuật không được để trống
    IF NOT IsValidThongSoKT(NEW.ThongSoKT) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Thông số kỹ thuật không được để trống';
    END IF;

    -- Kiểm tra mã nhà sản xuất không được để trống
    IF NOT IsValidMaNSX(NEW.MaNSX) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã nhà sản xuất không được để trống';
    END IF;

    -- Kiểm tra mã loại thiết bị không được để trống
    IF NOT IsValidMaLoai(NEW.MaLoai) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã loại thiết bị không được để trống';
    END IF;

    -- Kiểm tra mã nhà cung cấp không được để trống
    IF NOT IsValidMaNhaCungCap(NEW.MaNhaCungCap) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã nhà cung cấp không được để trống';
    END IF;

    -- Kiểm tra mã nhà sản xuất có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM NhaSanXuat WHERE MaNSX = NEW.MaNSX) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã nhà sản xuất không tồn tại';
    END IF;

    -- Kiểm tra mã loại thiết bị có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM LoaiThietBi WHERE MaLoai = NEW.MaLoai) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã loại thiết bị không tồn tại';
    END IF;

    -- Kiểm tra mã nhà cung cấp có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM NhaCungCap WHERE MaNhaCungCap = NEW.MaNhaCungCap) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã nhà cung cấp không tồn tại';
    END IF;
END //
DELIMITER ;

-- 2. Lấy tất cả thiết bị
DELIMITER //
CREATE PROCEDURE GetAllThietBi()
BEGIN
    SELECT * FROM ThietBi;
END //
DELIMITER ;

-- 3. Lấy thiết bị theo mã
DELIMITER //
CREATE PROCEDURE GetThietBiById(IN p_MaThietBi VARCHAR(255))
BEGIN
    SELECT * FROM ThietBi WHERE MaThietBi = p_MaThietBi;
END //
DELIMITER ;

-- Kiểm tra trước khi cập nhật thiết bị
DELIMITER //
CREATE TRIGGER BeforeUpdateThietBi
BEFORE UPDATE ON ThietBi
FOR EACH ROW
BEGIN
    -- Kiểm tra tên thiết bị không được để trống
    IF NOT IsValidTenThietBi(NEW.TenThietBi) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên thiết bị không được để trống';
    END IF;

    -- Kiểm tra giá thành không được để trống
    IF NOT IsValidGiaThanhNotNull(NEW.GiaThanh) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Giá thành không được để trống';
    END IF;

    -- Kiểm tra giá thành không được âm
    IF NOT IsValidGiaThanhNotNegative(NEW.GiaThanh) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Giá thành không được âm';
    END IF;

    -- Kiểm tra thông số kỹ thuật không được để trống
    IF NOT IsValidThongSoKT(NEW.ThongSoKT) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Thông số kỹ thuật không được để trống';
    END IF;

    -- Kiểm tra mã nhà sản xuất không được để trống
    IF NOT IsValidMaNSX(NEW.MaNSX) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã nhà sản xuất không được để trống';
    END IF;

    -- Kiểm tra mã loại thiết bị không được để trống
    IF NOT IsValidMaLoai(NEW.MaLoai) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã loại thiết bị không được để trống';
    END IF;

    -- Kiểm tra mã nhà cung cấp không được để trống
    IF NOT IsValidMaNhaCungCap(NEW.MaNhaCungCap) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã nhà cung cấp không được để trống';
    END IF;

    -- Kiểm tra mã nhà sản xuất có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM NhaSanXuat WHERE MaNSX = NEW.MaNSX) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã nhà sản xuất không tồn tại';
    END IF;

    -- Kiểm tra mã loại thiết bị có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM LoaiThietBi WHERE MaLoai = NEW.MaLoai) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã loại thiết bị không tồn tại';
    END IF;

    -- Kiểm tra mã nhà cung cấp có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM NhaCungCap WHERE MaNhaCungCap = NEW.MaNhaCungCap) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã nhà cung cấp không tồn tại';
    END IF;
END //
DELIMITER ;

-- 4. Thêm thiết bị
DELIMITER //
CREATE PROCEDURE AddThietBi(
    IN p_MaThietBi VARCHAR(255),
    IN p_TenThietBi VARCHAR(255),
    IN p_MaNSX INT,
    IN p_ThongSoKT TEXT,
    IN p_MaLoai INT,
    IN p_GiaThanh INT,
    IN p_MaNhaCungCap INT
)
BEGIN
    INSERT INTO ThietBi (MaThietBi, TenThietBi, MaNSX, ThongSoKT, MaLoai, GiaThanh, MaNhaCungCap) 
    VALUES (p_MaThietBi, p_TenThietBi, p_MaNSX, p_ThongSoKT, p_MaLoai, p_GiaThanh, p_MaNhaCungCap);
END //
DELIMITER ;

-- 5. Cập nhật thiết bị
DELIMITER //
CREATE PROCEDURE UpdateThietBi(
    IN p_MaThietBi VARCHAR(255),
    IN p_TenThietBi VARCHAR(255),
    IN p_MaNSX INT,
    IN p_ThongSoKT TEXT,
    IN p_MaLoai INT,
    IN p_GiaThanh INT,
    IN p_MaNhaCungCap INT
)
BEGIN
    UPDATE ThietBi
    SET TenThietBi = p_TenThietBi, MaNSX = p_MaNSX, ThongSoKT = p_ThongSoKT, 
        MaLoai = p_MaLoai, GiaThanh = p_GiaThanh, MaNhaCungCap = p_MaNhaCungCap
    WHERE MaThietBi = p_MaThietBi;
END //
DELIMITER ;

-- 6. Kiểm tra trước khi xóa thiết bị
DELIMITER //
CREATE TRIGGER BeforeDeleteThietBi
BEFORE DELETE ON ThietBi
FOR EACH ROW
BEGIN
    -- Kiểm tra xem thiết bị có tồn tại trong bảng ChiTietPhieuNhap không
    IF EXISTS (SELECT 1 FROM ChiTietPhieuNhap WHERE MaThietBi = OLD.MaThietBi) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không thể xóa thiết bị này vì đã có chi tiết phiếu nhập liên quan';
    END IF;

    -- Kiểm tra xem thiết bị có tồn tại trong bảng ChiTietPhieuXuat không
    IF EXISTS (SELECT 1 FROM ChiTietPhieuXuat WHERE MaThietBi = OLD.MaThietBi) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không thể xóa thiết bị này vì đã có chi tiết phiếu xuất liên quan';
    END IF;
END //
DELIMITER ;

-- 7. Xóa thiết bị
DELIMITER //
CREATE PROCEDURE DeleteThietBi(
    IN p_MaThietBi VARCHAR(255)
)
BEGIN
    DELETE FROM ThietBi WHERE MaThietBi = p_MaThietBi;
END //
DELIMITER ;

-- THÔNG TIN PHIẾU NHẬP ------------
-- ALTER TABLE ChiTietPhieuNhap ADD CONSTRAINT fk_chitietphieunhap_mapn FOREIGN KEY (MaPN) REFERENCES PhieuNhap(MaPN); -- Thêm lại khóa ngoại
-- ALTER TABLE ChiTietPhieuXuat ADD CONSTRAINT fk_chitietphieuxuat_mapx FOREIGN KEY (MaPX) REFERENCES PhieuXuat(MaPX); -- Thêm lại khóa ngoại

-- ALTER TABLE PhieuNhap ADD CONSTRAINT fk_phieunhap_manhacungcap FOREIGN KEY (MaNhaCungCap) REFERENCES NhaCungCap(MaNhaCungCap); -- Thêm lại khóa ngoại
-- ALTER TABLE PhieuNhap ADD CONSTRAINT fk_phieunhap_manhanvien FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien); -- Thêm lại khóa ngoại

-- ALTER TABLE PhieuXuat ADD CONSTRAINT fk_phieuxuat_makhachhang FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang); -- Thêm lại khóa ngoại
-- ALTER TABLE PhieuXuat ADD CONSTRAINT fk_phieuxuat_manhanvien FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien); -- Thêm lại khóa ngoại

DELIMITER //
CREATE FUNCTION IsValidMaNhanVien(p_MaNhanVien VARCHAR(255)) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_MaNhanVien IS NOT NULL);
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION IsValidNhaCungCapID(p_MaNhaCungCap INT) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_MaNhaCungCap IS NOT NULL);
END //
DELIMITER ;
-- 1. Kiểm tra trước khi thêm
DELIMITER //
CREATE TRIGGER BeforeInsertPhieuNhap
BEFORE INSERT ON PhieuNhap
FOR EACH ROW
BEGIN
    -- Kiểm tra mã nhân viên không được để trống
    IF NOT IsValidMaNhanVien(NEW.MaNhanVien) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã nhân viên không được để trống';
    END IF;

    -- Kiểm tra mã nhà cung cấp không được để trống
    IF NOT IsValidNhaCungCapID(NEW.MaNhaCungCap) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã nhà cung cấp không được để trống';
    END IF;

    -- Kiểm tra mã nhân viên có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM NhanVien WHERE MaNhanVien = NEW.MaNhanVien) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã nhân viên không tồn tại';
    END IF;

    -- Kiểm tra mã nhà cung cấp có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM NhaCungCap WHERE MaNhaCungCap = NEW.MaNhaCungCap) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã nhà cung cấp không tồn tại';
    END IF;
END //
DELIMITER ;

-- 2. Thêm
DELIMITER //
CREATE PROCEDURE AddPhieuNhap(
    IN p_MaNhanVien VARCHAR(255),
    IN p_MaNhaCungCap INT
)
BEGIN
    DECLARE v_NgayNhap DATE;

    -- Lấy ngày hiện tại
    SET v_NgayNhap = CURDATE();

    INSERT INTO PhieuNhap (MaNhanVien, MaNhaCungCap, NgayNhap) 
    VALUES (p_MaNhanVien, p_MaNhaCungCap, v_NgayNhap);
END //
DELIMITER ;

-- 3. Kiểm tra khi sửa
DELIMITER //
CREATE TRIGGER BeforeUpdatePhieuNhap
BEFORE UPDATE ON PhieuNhap
FOR EACH ROW
BEGIN
    -- Kiểm tra mã nhân viên không được để trống
    IF NOT IsValidMaNhanVien(NEW.MaNhanVien) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã nhân viên không được để trống';
    END IF;

    -- Kiểm tra mã nhà cung cấp không được để trống
    IF NOT IsValidNhaCungCapID(NEW.MaNhaCungCap) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã nhà cung cấp không được để trống';
    END IF;

    -- Kiểm tra mã nhân viên có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM NhanVien WHERE MaNhanVien = NEW.MaNhanVien) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã nhân viên không tồn tại';
    END IF;

    -- Kiểm tra mã nhà cung cấp có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM NhaCungCap WHERE MaNhaCungCap = NEW.MaNhaCungCap) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã nhà cung cấp không tồn tại';
    END IF;
END //
DELIMITER ;

-- 4. Sửa
DELIMITER //
CREATE PROCEDURE UpdatePhieuNhap(
    IN p_MaPN INT,
    IN p_MaNhanVien VARCHAR(255),
    IN p_MaNhaCungCap INT
)
BEGIN
    UPDATE PhieuNhap
    SET MaNhanVien = p_MaNhanVien, MaNhaCungCap = p_MaNhaCungCap
    WHERE MaPN = p_MaPN;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS UpdatePhieuNhap;
-- 5. Kiểm tra khi xóa
DELIMITER //
CREATE TRIGGER BeforeDeletePhieuNhap
BEFORE DELETE ON PhieuNhap
FOR EACH ROW
BEGIN
    -- Kiểm tra xem phiếu nhập có tồn tại trong bảng ChiTietPhieuNhap không
    IF EXISTS (SELECT 1 FROM ChiTietPhieuNhap WHERE MaPN = OLD.MaPN) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không thể xóa phiếu nhập này vì đã có chi tiết phiếu nhập liên quan';
    END IF;
END //
DELIMITER ;

-- 6. Xóa
DELIMITER //
CREATE PROCEDURE DeletePhieuNhap(
    IN p_MaPN INT
)
BEGIN
    DELETE FROM PhieuNhap WHERE MaPN = p_MaPN;
END //
DELIMITER ;

-- 7. Lấy all
DELIMITER //
CREATE PROCEDURE GetAllPhieuNhap()
BEGIN
    SELECT * FROM PhieuNhap;
END //
DELIMITER ;

-- 8. Lấy theo mã
DELIMITER //
CREATE PROCEDURE GetPhieuNhapById(IN p_MaPN INT)
BEGIN
    SELECT * FROM PhieuNhap WHERE MaPN = p_MaPN;
END //
DELIMITER ;

-- CHI TIẾT PHIẾU NHẬP --------------
DELIMITER //
CREATE FUNCTION IsValidMaPN(p_MaPN INT) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_MaPN IS NOT NULL);
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION IsValidMaThietBi(p_MaThietBi VARCHAR(255)) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_MaThietBi IS NOT NULL);
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION IsValidSoLuong(p_SoLuong INT) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_SoLuong IS NOT NULL AND p_SoLuong >= 0);
END //
DELIMITER ;
-- 1. Kiểm tra thêm
DELIMITER //
CREATE TRIGGER BeforeInsertChiTietPhieuNhap
BEFORE INSERT ON ChiTietPhieuNhap
FOR EACH ROW
BEGIN
    -- Kiểm tra mã phiếu nhập không được để trống
    IF NOT IsValidMaPN(NEW.MaPN) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã phiếu nhập không được để trống';
    END IF;

    -- Kiểm tra mã thiết bị không được để trống
    IF NOT IsValidMaThietBi(NEW.MaThietBi) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã thiết bị không được để trống';
    END IF;

    -- Kiểm tra số lượng không được trống và không âm
    IF NOT IsValidSoLuong(NEW.SoLuong) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số lượng không được trống và không âm';
    END IF;

    -- Kiểm tra đơn giá không được âm
    IF NEW.DonGia < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Đơn giá không được âm';
    END IF;

    -- Kiểm tra mã phiếu nhập có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM PhieuNhap WHERE MaPN = NEW.MaPN) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã phiếu nhập không tồn tại';
    END IF;

    -- Kiểm tra mã thiết bị có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM ThietBi WHERE MaThietBi = NEW.MaThietBi) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã thiết bị không tồn tại';
    END IF;
END //
DELIMITER ;

-- 2. Thêm
DELIMITER //

CREATE PROCEDURE AddChiTietPhieuNhap(
    IN p_MaPN INT,
    IN p_MaThietBi VARCHAR(255),
    IN p_SoLuong INT
)
BEGIN
    DECLARE v_GiaThanh DECIMAL(10, 2);

    -- Lấy đơn giá của thiết bị từ bảng ThietBi
    SELECT GiaThanh INTO v_GiaThanh
    FROM ThietBi
    WHERE MaThietBi = p_MaThietBi;

	-- Thêm chi tiết phiếu nhập mới và tính tổng đơn giá
	INSERT INTO ChiTietPhieuNhap (MaPN, MaThietBi, SoLuong, DonGia)
	VALUES (p_MaPN, p_MaThietBi, p_SoLuong, p_SoLuong * v_GiaThanh);

	-- Cập nhật số lượng thiết bị trong bảng ThietBi
	UPDATE ThietBi
	SET SoLuong = SoLuong + p_SoLuong
	WHERE MaThietBi = p_MaThietBi;
END //

DELIMITER ;

-- 3. Kiểm tra sửa
DELIMITER //
CREATE TRIGGER BeforeUpdateChiTietPhieuNhap
BEFORE UPDATE ON ChiTietPhieuNhap
FOR EACH ROW
BEGIN
    -- Kiểm tra mã phiếu nhập không được để trống
    IF NEW.MaPN IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã phiếu nhập không được để trống';
    END IF;

    -- Kiểm tra mã thiết bị không được để trống
    IF NEW.MaThietBi IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã thiết bị không được để trống';
    END IF;
    
     -- Kiểm tra số lượng không được âm
    IF NEW.SoLuong < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số lượng không được âm';
    END IF;

    -- Kiểm tra đơn giá không được âm
    IF NEW.DonGia < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Đơn giá không được âm';
    END IF;

    -- Kiểm tra mã phiếu nhập có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM PhieuNhap WHERE MaPN = NEW.MaPN) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã phiếu nhập không tồn tại';
    END IF;

    -- Kiểm tra mã thiết bị có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM ThietBi WHERE MaThietBi = NEW.MaThietBi) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã thiết bị không tồn tại';
    END IF;
END //
DELIMITER ;

-- 4. Sửa
DELIMITER //

CREATE PROCEDURE UpdateChiTietPhieuNhap(
    IN p_MaPN INT,
    IN p_MaThietBi VARCHAR(255),
    IN p_SoLuong INT
)
BEGIN
    DECLARE v_GiaThanh DECIMAL(10, 2);

    -- Lấy đơn giá của thiết bị từ bảng ThietBi
    SELECT GiaThanh INTO v_GiaThanh
    FROM ThietBi
    WHERE MaThietBi = p_MaThietBi;

    -- Cập nhật số lượng và đơn giá trong bảng ChiTietPhieuNhap
    UPDATE ChiTietPhieuNhap
    SET SoLuong = p_SoLuong,
        DonGia = p_SoLuong * v_GiaThanh
    WHERE MaPN = p_MaPN AND MaThietBi = p_MaThietBi;

    -- Cập nhật số lượng trong bảng ThietBi
    UPDATE ThietBi
    SET SoLuong = SoLuong + p_SoLuong
    WHERE MaThietBi = p_MaThietBi;
END //

DELIMITER ;

-- 5. Kiểm tra xóa
DELIMITER //
CREATE TRIGGER BeforeDeleteChiTietPhieuNhap
BEFORE DELETE ON ChiTietPhieuNhap
FOR EACH ROW
BEGIN
    -- Kiểm tra xem chi tiết phiếu nhập có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM ChiTietPhieuNhap WHERE MaPN = OLD.MaPN AND MaThietBi = OLD.MaThietBi) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Chi tiết phiếu nhập không tồn tại';
    END IF;
END //
DELIMITER ;

-- 6. Xóa
DELIMITER //
CREATE PROCEDURE DeleteChiTietPhieuNhap(
    IN p_MaPN INT,
    IN p_MaThietBi VARCHAR(255)
)
BEGIN
    DELETE FROM ChiTietPhieuNhap WHERE MaPN = p_MaPN AND MaThietBi = p_MaThietBi;
END //
DELIMITER ;

-- 7. Lấy all
DELIMITER //
CREATE PROCEDURE GetAllChiTietPhieuNhap()
BEGIN
    SELECT * FROM ChiTietPhieuNhap;
END //
DELIMITER ;

-- 8. Lấy mã
DELIMITER //
CREATE PROCEDURE GetChiTietPhieuNhapByMaPN(IN p_MaPN INT)
BEGIN
    SELECT * FROM ChiTietPhieuNhap WHERE MaPN = p_MaPN;
END //
DELIMITER ;

-- PHIẾU XUẤT ----------------
DELIMITER //
CREATE FUNCTION IsValidNhanVienID(p_MaNhanVien VARCHAR(255)) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_MaNhanVien IS NOT NULL);
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION IsValidKhachHangID(p_MaKhachHang INT) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_MaKhachHang IS NOT NULL);
END //
DELIMITER ;
-- 1. Kiểm tra trước khi thêm
DELIMITER //
CREATE TRIGGER BeforeInsertPhieuXuat
BEFORE INSERT ON PhieuXuat
FOR EACH ROW
BEGIN
    -- Kiểm tra mã nhân viên không được để trống
    IF NOT IsValidNhanVienID(NEW.MaNhanVien) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã nhân viên không được để trống';
    END IF;

    -- Kiểm tra mã khách hàng không được để trống
    IF NOT IsValidKhachHangID(NEW.MaKhachHang) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã khách hàng không được để trống';
    END IF;

    -- Kiểm tra mã nhân viên có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM NhanVien WHERE MaNhanVien = NEW.MaNhanVien) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã nhân viên không tồn tại';
    END IF;

    -- Kiểm tra mã khách hàng có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM KhachHang WHERE MaKhachHang = NEW.MaKhachHang) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã khách hàng không tồn tại';
    END IF;
END //
DELIMITER ;

-- 2. Thêm
DELIMITER //
CREATE PROCEDURE AddPhieuXuat(
    IN p_MaNhanVien VARCHAR(255),
    IN p_MaKhachHang INT
)
BEGIN
    DECLARE v_NgayXuat DATE;

    -- Lấy ngày hiện tại
    SET v_NgayXuat = CURDATE();

    INSERT INTO PhieuXuat (MaNhanVien, MaKhachHang, NgayXuat) 
    VALUES (p_MaNhanVien, p_MaKhachHang, v_NgayXuat);
END //
DELIMITER ;

-- 3. Kiểm tra khi sửa
DELIMITER //
CREATE TRIGGER BeforeUpdatePhieuXuat
BEFORE UPDATE ON PhieuXuat
FOR EACH ROW
BEGIN
    -- Kiểm tra mã nhân viên không được để trống
    IF NOT IsValidNhanVienID(NEW.MaNhanVien) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã nhân viên không được để trống';
    END IF;

    -- Kiểm tra mã khách hàng không được để trống
    IF NOT IsValidKhachHangID(NEW.MaKhachHang) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã khách hàng không được để trống';
    END IF;

    -- Kiểm tra mã nhân viên có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM NhanVien WHERE MaNhanVien = NEW.MaNhanVien) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã nhân viên không tồn tại';
    END IF;

    -- Kiểm tra mã khách hàng có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM KhachHang WHERE MaKhachHang = NEW.MaKhachHang) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã khách hàng không tồn tại';
    END IF;
END //
DELIMITER ;

-- 4. Sửa
DELIMITER //
CREATE PROCEDURE UpdatePhieuXuat(
    IN p_MaPX INT,
    IN p_MaNhanVien VARCHAR(255),
    IN p_MaKhachHang INT
)
BEGIN
    UPDATE PhieuXuat
    SET MaNhanVien = p_MaNhanVien, MaKhachHang = p_MaKhachHang
    WHERE MaPX = p_MaPX;
END //
DELIMITER ;

-- 5. Kiểm tra khi xóa
DELIMITER //
CREATE TRIGGER BeforeDeletePhieuXuat
BEFORE DELETE ON PhieuXuat
FOR EACH ROW
BEGIN
    -- Kiểm tra xem phiếu xuất có tồn tại trong bảng ChiTietPhieuXuat không
    IF EXISTS (SELECT 1 FROM ChiTietPhieuXuat WHERE MaPX = OLD.MaPX) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không thể xóa hóa đơn này vì đã có chi tiết phiếu xuất liên quan';
    END IF;
END //
DELIMITER ;

-- 6. Xóa
DELIMITER //
CREATE PROCEDURE DeletePhieuXuat(
    IN p_MaPX INT
)
BEGIN
    DELETE FROM PhieuXuat WHERE MaPX = p_MaPX;
END //
DELIMITER ;

-- 7. Lấy all
DELIMITER //
CREATE PROCEDURE GetAllPhieuXuat()
BEGIN
    SELECT * FROM PhieuXuat;
END //
DELIMITER ;

-- 8. Lấy theo mã
DELIMITER //
CREATE PROCEDURE GetPhieuXuatById(IN p_MaPX INT)
BEGIN
    SELECT * FROM PhieuXuat WHERE MaPX = p_MaPX;
END //
DELIMITER ;

-- CHI TIẾT PHIẾU XUẤT --------------
DELIMITER //
CREATE FUNCTION IsValidMaPX(p_MaPX INT) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_MaPX IS NOT NULL);
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION IsValidSoLuongInput(p_SoLuong INT) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_SoLuong IS NOT NULL AND p_SoLuong >= 0);
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION IsValidThietBiID(p_MaThietBi VARCHAR(255)) 
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    RETURN (p_MaThietBi IS NOT NULL);
END //
DELIMITER ;
-- 1. Kiểm tra thêm
DELIMITER //
CREATE TRIGGER BeforeInsertChiTietPhieuXuat
BEFORE INSERT ON ChiTietPhieuXuat
FOR EACH ROW
BEGIN
    -- Kiểm tra mã phiếu xuất không được để trống
    IF NOT IsValidMaPX(NEW.MaPX) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã hóa đơn không được để trống';
    END IF;

    -- Kiểm tra mã thiết bị không được để trống
    IF NOT IsValidThietBiID(NEW.MaThietBi) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã thiết bị không được để trống';
    END IF;

    -- Kiểm tra số lượng không được âm
    IF NOT IsValidSoLuongInput(NEW.SoLuong) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số lượng không được âm';
    END IF;

    -- Kiểm tra mã phiếu xuất có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM PhieuXuat WHERE MaPX = NEW.MaPX) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã hóa đơn không tồn tại';
    END IF;

    -- Kiểm tra mã thiết bị có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM ThietBi WHERE MaThietBi = NEW.MaThietBi) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã thiết bị không tồn tại';
    END IF;
END //
DELIMITER ;

-- 2. Thêm
DELIMITER //

CREATE PROCEDURE AddChiTietPhieuXuat(
    IN p_MaPX INT,
    IN p_MaThietBi VARCHAR(255),
    IN p_SoLuong INT
)
BEGIN
    DECLARE v_GiaThanh DECIMAL(10, 2);

    -- Kiểm tra số lượng có đủ trong bảng ThietBi không
    IF (SELECT SoLuong FROM ThietBi WHERE MaThietBi = p_MaThietBi) < p_SoLuong THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số lượng thiết bị không đủ để xuất';
    ELSE
        -- Lấy đơn giá của thiết bị từ bảng ThietBi
        SELECT GiaThanh INTO v_GiaThanh
        FROM ThietBi
        WHERE MaThietBi = p_MaThietBi;

        -- Thêm chi tiết phiếu xuất mới và tính tổng đơn giá
        INSERT INTO ChiTietPhieuXuat (MaPX, MaThietBi, SoLuong, DonGia)
        VALUES (p_MaPX, p_MaThietBi, p_SoLuong, p_SoLuong * v_GiaThanh);

        -- Cập nhật số lượng thiết bị trong bảng ThietBi
        UPDATE ThietBi
        SET SoLuong = SoLuong - p_SoLuong
        WHERE MaThietBi = p_MaThietBi;
    END IF;
END //

DELIMITER ;

DROP PROCEDURE IF EXISTS AddChiTietPhieuXuat;

-- 3. Kiểm tra sửa
DELIMITER //
CREATE TRIGGER BeforeUpdateChiTietPhieuXuat
BEFORE UPDATE ON ChiTietPhieuXuat
FOR EACH ROW
BEGIN
    -- Kiểm tra mã phiếu xuất không được để trống
    IF NOT IsValidMaPX(NEW.MaPX) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã hóa đơn không được để trống';
    END IF;

    -- Kiểm tra mã thiết bị không được để trống
    IF NOT IsValidThietBiID(NEW.MaThietBi) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã thiết bị không được để trống';
    END IF;

    -- Kiểm tra số lượng không được âm
    IF NOT IsValidSoLuongInput(NEW.SoLuong) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số lượng không được âm';
    END IF;

    -- Kiểm tra mã phiếu xuất có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM PhieuXuat WHERE MaPX = NEW.MaPX) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã hóa đơn không tồn tại';
    END IF;

    -- Kiểm tra mã thiết bị có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM ThietBi WHERE MaThietBi = NEW.MaThietBi) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Mã thiết bị không tồn tại';
    END IF;
END //
DELIMITER ;

-- 4. Sửa
DELIMITER //

CREATE PROCEDURE UpdateChiTietPhieuXuat(  
    IN p_MaPX INT,  
    IN p_MaThietBi VARCHAR(255),  
    IN p_SoLuong INT  
)  
BEGIN  
    DECLARE v_OLD_SoLuong INT;  
    DECLARE v_GiaThanh INT;  
    DECLARE v_CungCapSoLuong INT;  -- Biến chứa số lượng thiết bị hiện có  

    -- Kiểm tra mã phiếu xuất và mã thiết bị có tồn tại hay không  
    IF NOT EXISTS (SELECT 1 FROM ChiTietPhieuXuat WHERE MaPX = p_MaPX AND MaThietBi = p_MaThietBi) THEN  
        SIGNAL SQLSTATE '45000'  
        SET MESSAGE_TEXT = 'Chi tiết phiếu xuất không tồn tại';  
    END IF;  

    -- Lấy đơn giá của thiết bị từ bảng ThietBi  
    SELECT GiaThanh INTO v_GiaThanh  
    FROM ThietBi  
    WHERE MaThietBi = p_MaThietBi;  

    -- Lấy số lượng cũ trước khi cập nhật  
    SELECT SoLuong INTO v_OLD_SoLuong  
    FROM ChiTietPhieuXuat  
    WHERE MaPX = p_MaPX AND MaThietBi = p_MaThietBi;  

    -- Lấy số lượng thiết bị hiện có  
    SELECT SoLuong INTO v_CungCapSoLuong  
    FROM ThietBi  
    WHERE MaThietBi = p_MaThietBi;  

    -- Kiểm tra xem số lượng yêu cầu có vượt quá số lượng thiết bị hiện có không  
    IF p_SoLuong > (v_CungCapSoLuong + v_OLD_SoLuong) THEN  
        SIGNAL SQLSTATE '45000'  
        SET MESSAGE_TEXT = 'Số lượng yêu cầu vượt quá số lượng thiết bị hiện có.';  
    END IF;  

    -- Cập nhật lại số lượng và đơn giá trong bảng ChiTietPhieuXuat  
    UPDATE ChiTietPhieuXuat  
    SET SoLuong = p_SoLuong,  
        DonGia = p_SoLuong * v_GiaThanh  
    WHERE MaPX = p_MaPX AND MaThietBi = p_MaThietBi;  

    -- Cập nhật lại số lượng trong bảng ThietBi
    -- Tính toán số lượng mới: cộng lại số lượng cũ và trừ đi số lượng mới
    UPDATE ThietBi  
    SET SoLuong = SoLuong + (v_OLD_SoLuong - p_SoLuong)  
    WHERE MaThietBi = p_MaThietBi;  
END //  

DELIMITER ;

DROP PROCEDURE IF EXISTS UpdateChiTietPhieuXuat;  

-- 5. Kiểm tra xóa
DELIMITER //
CREATE TRIGGER BeforeDeleteChiTietPhieuXuat
BEFORE DELETE ON ChiTietPhieuXuat
FOR EACH ROW
BEGIN
    -- Kiểm tra xem chi tiết phiếu xuất có tồn tại không
    IF NOT EXISTS (SELECT 1 FROM ChiTietPhieuXuat WHERE MaPX = OLD.MaPX AND MaThietBi = OLD.MaThietBi) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Chi tiết hóa đơn không tồn tại';
    END IF;
END //
DELIMITER ;

DROP TRIGGER IF EXISTS BeforeDeleteChiTietPhieuXuat;
-- 6. Xóa
DELIMITER //
CREATE PROCEDURE DeleteChiTietPhieuXuat(
    IN p_MaPX INT,
    IN p_MaThietBi VARCHAR(255)
)
BEGIN
    DELETE FROM ChiTietPhieuXuat WHERE MaPX = p_MaPX AND MaThietBi = p_MaThietBi;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS DeleteChiTietPhieuXuat;

-- 7. Lấy all
DELIMITER //
CREATE PROCEDURE GetAllChiTietPhieuXuat()
BEGIN
    SELECT * FROM ChiTietPhieuXuat;
END //
DELIMITER ;

-- 8. Lấy mã
DELIMITER //
CREATE PROCEDURE GetChiTietPhieuXuatByMaPX(IN p_MaPX INT)
BEGIN
    SELECT * FROM ChiTietPhieuXuat WHERE MaPX = p_MaPX;
END //
DELIMITER ;

-- ALTER TABLE ThietBi
-- ADD COLUMN SoLuong INT DEFAULT 0;