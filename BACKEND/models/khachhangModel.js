const db = require("../config/db");

const KhachHang = {
  // Lấy tất cả khách hàng
  getAll: (callback) => {
    const sql = "CALL GetAllKhachHang()"; // Gọi stored procedure GetAllKhachHang
    db.query(sql, (err, results) => {
      if (err) return callback(err);
      callback(null, results[0]); // results[0] chứa dữ liệu trả về
    });
  },

  // Lấy khách hàng theo mã
  getById: (MaKH, callback) => {
    const sql = "CALL GetKhachHangById(?)"; // Gọi stored procedure GetKhachHangById
    db.query(sql, [MaKH], (err, results) => {
      if (err) return callback(err);
      callback(null, results[0]); // Trả về kết quả
    });
  },

  // Thêm mới khách hàng
  create: (data, callback) => {
    const { TenKhachHang, DiaChi, SoDienThoai } = data;
    const sql = "CALL AddKhachHang(?, ?, ?)"; // Gọi stored procedure AddKhachHang
    db.query(sql, [TenKhachHang, DiaChi, SoDienThoai], (err, results) => {
      if (err) return callback(err);
      callback(null, results); // Trả về kết quả thêm
    });
  },

  // Cập nhật thông tin khách hàng
  update: (MaKH, data, callback) => {
    const { TenKhachHang, DiaChi, SoDienThoai } = data;
    const sql = "CALL UpdateKhachHang(?, ?, ?, ?)"; // Gọi stored procedure UpdateKhachHang
    db.query(sql, [MaKH, TenKhachHang, DiaChi, SoDienThoai], (err, results) => {
      if (err) return callback(err);
      callback(null, results); // Trả về kết quả cập nhật
    });
  },

  // Xóa khách hàng
  delete: (MaKH, callback) => {
    const sql = "CALL DeleteKhachHang(?)"; // Gọi stored procedure DeleteKhachHang
    db.query(sql, [MaKH], (err, results) => {
      if (err) {
        if (err.code === "45000") {
          return callback(new Error(err.sqlMessage));
        }
        return callback(err);
      }
      callback(null, results); // Trả về kết quả xóa
    });
  },
};

module.exports = KhachHang;
