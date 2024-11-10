const db = require("../config/db");

const LoaiThietBi = {
  // Lấy tất cả loại thiết bị
  getAll: (callback) => {
    const sql = "CALL GetAllLoaiThietBi()"; // Gọi stored procedure GetAllLoaiThietBi
    db.query(sql, (err, results) => {
      if (err) return callback(err);
      callback(null, results[0]); // results[0] chứa dữ liệu trả về
    });
  },

  // Lấy loại thiết bị theo mã
  getById: (MaLoaiThietBi, callback) => {
    const sql = "CALL GetLoaiThietBiById(?)"; // Gọi stored procedure GetLoaiThietBiId
    db.query(sql, [MaLoaiThietBi], (err, results) => {
      if (err) return callback(err);
      callback(null, results[0]); // Trả về kết quả
    });
  },

  // Thêm mới loại thiết bị
  create: (data, callback) => {
    const { TenLoai, DonViTinh, GhiChu } = data;
    const sql = "CALL AddLoaiThietBi(?, ?, ?)"; // Gọi stored procedure AddLoaiThietBi
    db.query(sql, [TenLoai, DonViTinh, GhiChu], (err, results) => {
      if (err) {
        if (err.code === "45000") {
          return callback(new Error(err.sqlMessage));
        }
        return callback(err);
      }
      callback(null, results); // Trả về kết quả thêm
    });
  },

  // Cập nhật thông tin loại thiết bị
  update: (MaLoaiThietBi, data, callback) => {
    const { TenLoai, DonViTinh, GhiChu } = data;
    const sql = "CALL UpdateLoaiThietBi(?, ?, ?, ?)"; // Gọi stored procedure UpdateLoaiThietBi
    db.query(
      sql,
      [MaLoaiThietBi, TenLoai, DonViTinh, GhiChu],
      (err, results) => {
        if (err) {
          if (err.code === "45000") {
            return callback(new Error(err.sqlMessage));
          }
          return callback(err);
        }
        callback(null, results); // Trả về kết quả cập nhật
      }
    );
  },

  // Xóa loại thiết bị
  delete: (MaLoaiThietBi, callback) => {
    const sql = "CALL DeleteLoaiThietBi(?)"; // Gọi stored procedure DeleteLoaiThietBi
    db.query(sql, [MaLoaiThietBi], (err, results) => {
      if (err) {
        if (err.code === "45000") {
          return callback(new Error(err.sqlMessage));
        }
        return callback(err);
      }
      callback(null, results);
    });
  },
};

module.exports = LoaiThietBi;
