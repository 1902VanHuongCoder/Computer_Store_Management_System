--- SQL CODE ---


	CREATE DATABASE ComputerStore;

	USE ComputerStore;

	CREATE TABLE ThietBi (
		MaThietBi INT PRIMARY KEY, -- Mã thiết bị
		TenThietBi VARCHAR(255), -- Tên thiết bị
		MaNSX INT, -- Khóa ngoại đến bảng NhaSanXuat
		ThongSoKT TEXT, -- Thông số kỹ thuật
		MaLoai INT, -- Khóa ngoại đến bảng LoaiThietBi
		GiaThanh DECIMAL(10, 2),  -- Giá thành
		MaNhaCungCap INT, -- Khóa ngoại đến bảng NhaCungCap
		FOREIGN KEY (MaNSX) REFERENCES NhaSanXuat(MaNSX), -- Khóa ngoại đến bảng NhaSanXuat
		FOREIGN KEY (MaLoai) REFERENCES LoaiThietBi(MaLoai), -- Khóa ngoại đến bảng LoaiThietBi
		FOREIGN KEY (MaNhaCungCap) REFERENCES NhaCungCap(MaNhaCungCap)
	);

	CREATE TABLE NhaSanXuat (
		MaNSX INT PRIMARY KEY, -- Mã nhà sản xuất
		TenNSX VARCHAR(255), -- Tên nhà sản xuất
		QuocGia VARCHAR(255) -- Quốc gia
	);

	CREATE TABLE NhaCungCap (
		MaNhaCungCap INT PRIMARY KEY, -- Mã nhà cung cấp
		TenNhaCungCap VARCHAR(255), -- Tên nhà cung cấp
		DiaChi TEXT, -- Địa chỉ
		SoDienThoai VARCHAR(20) -- Số điện thoại
	);

	CREATE TABLE LoaiThietBi (
		MaLoai INT PRIMARY KEY, -- Mã loại thiết bị
		TenLoai VARCHAR(255), -- Tên loại thiết bị
		DonViTinh VARCHAR(50), -- Đơn vị tính
		GhiChu TEXT -- Ghi chú
	);

	CREATE TABLE KhachHang (
		MaKhachHang INT PRIMARY KEY, -- Mã khách hàng
		TenKhachHang VARCHAR(255), -- Tên khách hàng
		DiaChi TEXT, -- Địa chỉ
		SoDienThoai VARCHAR(20) -- Số điện thoại
	);

	CREATE TABLE NhanVien (
		MaNhanVien INT PRIMARY KEY, -- Mã nhân viên
		HoTen VARCHAR(255), -- Họ tên
		NgaySinh DATE, -- Ngày sinh
		SoDienThoai VARCHAR(20) -- Số điện thoại
	);







	CREATE TABLE PhieuNhap (
		MaPN INT PRIMARY KEY, -- Mã phiếu nhập
		MaNhanVien INT, -- Khóa ngoại đến bảng NhanVien
		MaNhaCungCap INT, -- Khóa ngoại đến bảng NhaCungCap
		NgayNhap DATE, -- Ngày nhập

    -- Khoan hả chạy dòng lệnh này ********************************
		FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien), -- Khóa ngoại đến bảng NhanVien


    -- Khoan hả chạy dòng lệnh này ******************************
		FOREIGN KEY (MaNhaCungCap) REFERENCES NhaCungCap(MaNhaCungCap) -- Khóa ngoại đến bảng NhaCungCap
	);

	CREATE TABLE ChiTietPhieuNhap (
		MaPN INT, -- Khóa ngoại đến bảng PhieuNhap
		MaThietBi INT, -- Khóa ngoại đến bảng ThietBi
		SoLuong INT, -- Số lượng
		DonGia DECIMAL(10, 2), -- Đơn giá
		PRIMARY KEY (MaPN, MaThietBi), -- Khóa chính gồm 2 trường MaPN và MaThietBi
  
    -- Khoan hả chạy dòng lệnh này *******************************
		FOREIGN KEY (MaPN) REFERENCES PhieuNhap(MaPN), -- Khóa ngoại đến bảng PhieuNhap
    -- Khoan hả chạy dòng lệnh này ********************************
		FOREIGN KEY (MaThietBi) REFERENCES ThietBi(MaThietBi) -- Khóa ngoại đến bảng ThietBi
	);

	CREATE TABLE PhieuXuat (
		MaPX INT PRIMARY KEY, -- Mã phiếu xuất
		MaNhanVien INT, -- Khóa ngoại đến bảng NhanVien
		MaKhachHang INT, -- Khóa ngoại đến bảng KhachHang
		NgayXuat DATE, -- Ngày xuất
  
    -- Khoan hả chạy dòng lệnh này ********************************
		FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien), -- Khóa ngoại đến bảng NhanVien
		FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang) -- Khóa ngoại đến bảng KhachHang
	);

	CREATE TABLE ChiTietPhieuXuat (
		MaPX INT, -- Khóa ngoại đến bảng PhieuXuat
		MaThietBi INT, -- Khóa ngoại đến bảng ThietBi
		SoLuong INT, -- Số lượng
		DonGia DECIMAL(10, 2), -- Đơn giá
		PRIMARY KEY (MaPX, MaThietBi), -- Khóa chính gồm 2 trường MaPX và MaThietBi
    -- Khoan hả chạy dòng lệnh này ********************************
		FOREIGN KEY (MaPX) REFERENCES PhieuXuat(MaPX), -- Khóa ngoại đến bảng PhieuXuat
		FOREIGN KEY (MaThietBi) REFERENCES ThietBi(MaThietBi) -- Khóa ngoại đến bảng ThietBi
	);
    
    
