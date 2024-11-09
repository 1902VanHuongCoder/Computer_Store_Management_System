const db = require("../config/db");

const NhaCungCap = {
  // Lấy tất cả nhà cung cấp
  getAll: (callback) => {
    const sql = "CALL GetAllNhaCungCap()"; // Gọi stored procedure GetAllNhaCungCap
    db.query(sql, (err, results) => {
      if (err) return callback(err);
      callback(null, results[0]); // results[0] chứa dữ liệu trả về
    });
  },

  // Lấy nhà cung cấp theo mã
  getById: (MaNCC, callback) => {
    const sql = "CALL GetNhaCungCapById(?)"; // Gọi stored procedure GetNhaCungCapById
    db.query(sql, [MaNCC], (err, results) => {
      if (err) return callback(err);
      callback(null, results[0]); // Trả về kết quả
    });
  },

  // Thêm mới nhà cung cấp
  create: (data, callback) => {
    const { TenNhaCungCap, DiaChi, SoDienThoai } = data;
    const sql = "CALL AddNhaCungCap(?, ?, ?)"; // Gọi stored procedure AddNhaCungCap
    db.query(sql, [TenNhaCungCap, DiaChi, SoDienThoai], (err, results) => {
      if (err) return callback(err);
      callback(null, results); // Trả về kết quả thêm
    });
  },

  // Cập nhật thông tin nhà cung cấp
  update: (MaNCC, data, callback) => {
    const { TenNhaCungCap, DiaChi, SoDienThoai } = data;
    const sql = "CALL UpdateNhaCungCap(?, ?, ?, ?)"; // Gọi stored procedure UpdateNhaCungCap
    db.query(
      sql,
      [MaNCC, TenNhaCungCap, DiaChi, SoDienThoai],
      (err, results) => {
        if (err) return callback(err);
        callback(null, results); // Trả về kết quả cập nhật
      }
    );
  },

  // Xóa nhà cung cấp
  delete: (MaNCC, callback) => {
    const sql = "CALL DeleteNhaCungCap(?)"; // Gọi stored procedure DeleteNhaCungCap
    db.query(sql, [MaNCC], (err, results) => {
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

module.exports = NhaCungCap;
