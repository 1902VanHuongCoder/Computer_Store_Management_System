const db = require("../config/db");

const NhaSanXuat = {
  // Lấy tất cả nhà sản xuất
  getAll: (callback) => {
    const sql = "CALL GetAllNhaSanXuat()"; // Gọi stored procedure GetAllNhaSanXuat
    db.query(sql, (err, results) => {
      if (err) return callback(err);
      callback(null, results[0]); // results[0] chứa dữ liệu trả về
    });
  },

  // Lấy nhà sản xuất theo mã
  getById: (MaNSX, callback) => {
    const sql = "CALL GetNhaSanXuatById(?)"; // Gọi stored procedure GetNhaSanXuatById
    db.query(sql, [MaNSX], (err, results) => {
      if (err) return callback(err);
      callback(null, results[0]); // Trả về kết quả
    });
  },

  // Thêm mới nhà sản xuất
  create: (data, callback) => {
    const { TenNSX, QuocGia } = data;
    const sql = "CALL AddNhaSanXuat(?, ?)"; // Gọi stored procedure AddNhaSanXuat
    db.query(sql, [TenNSX, QuocGia], (err, results) => {
      if (err) {
        if (err.code === "45000") {
          return callback(new Error(err.sqlMessage));
        }
        return callback(err);
      }
      callback(null, results); // Trả về kết quả thêm
    });
  },

  // Cập nhật thông tin nhà sản xuất
  update: (MaNSX, data, callback) => {
    const { TenNSX, QuocGia } = data;
    const sql = "CALL UpdateNhaSanXuat(?, ?, ?)"; // Gọi stored procedure UpdateNhaSanXuat
    db.query(sql, [MaNSX, TenNSX, QuocGia], (err, results) => {
      if (err) {
        if (err.code === "45000") {
          return callback(new Error(err.sqlMessage));
        }
        return callback(err);
      }
      callback(null, results); // Trả về kết quả cập nhật
    });
  },

  // Xóa nhà sản xuất
  delete: (MaNSX, callback) => {
    const sql = "CALL DeleteNhaSanXuat(?)";
    db.query(sql, [MaNSX], (err, results) => {
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

module.exports = NhaSanXuat;
