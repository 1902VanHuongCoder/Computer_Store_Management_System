const db = require("../config/db");

const PhieuXuat = {
  getAll: (callback) => {
    const sql = "CALL GetAllPhieuXuat()";
    db.query(sql, (err, results) => {
      if (err) return callback(err);
      callback(null, results[0]);
    });
  },

  getById: (MaPX, callback) => {
    const sql = "CALL GetPhieuXuatById(?)";
    db.query(sql, [MaPX], (err, results) => {
      if (err) return callback(err);
      callback(null, results[0]);
    });
  },

  create: (data, callback) => {
    const { MaNhanVien, MaKhachHang } = data;
    const sql = "CALL AddPhieuXuat(?, ?)";
    db.query(sql, [ MaNhanVien, MaKhachHang], (err, results) => {
      if (err) {
        if (err.code === "45000") {
          return callback(new Error(err.sqlMessage));
        }
        return callback(err);
      }
      callback(null, results);
    });
  },

  update: (MaPX, data, callback) => {
    const { MaNhanVien, MaKhachHang} = data;
    const sql = "CALL UpdatePhieuXuat(?, ?, ?)";
    db.query(sql, [MaPX, MaNhanVien, MaKhachHang], (err, results) => {
      if (err) {
        if (err.code === "45000") {
          return callback(new Error(err.sqlMessage));
        }
        return callback(err);
      }
      callback(null, results);
    });
  },

  delete: (MaPX, callback) => {
    const sql = "CALL DeletePhieuXuat(?)";
    db.query(sql, [MaPX], (err, results) => {
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

module.exports = PhieuXuat;
