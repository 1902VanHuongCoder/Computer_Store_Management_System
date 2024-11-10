const db = require("../config/db");

const PhieuNhap = {
  getAll: (callback) => {
    const sql = "CALL GetAllPhieuNhap()";
    db.query(sql, (err, results) => {
      if (err) return callback(err);
      callback(null, results[0]);
    });
  },

  getById: (MaPN, callback) => {
    const sql = "CALL GetPhieuNhapById(?)";
    db.query(sql, [MaPN], (err, results) => {
      if (err) return callback(err);
      callback(null, results[0]);
    });
  },

  create: (data, callback) => {
    const { MaNhanVien, MaNhaCungCap } = data;
    const sql = "CALL AddPhieuNhap(?, ?)";
    db.query(sql, [ MaNhanVien, MaNhaCungCap], (err, results) => {
      if (err) {
        if (err.code === "45000") {
          return callback(new Error(err.sqlMessage));
        }
        return callback(err);
      }
      callback(null, results);
    });
  },

  update: (MaPN, data, callback) => {
    const { MaNhanVien, MaNhaCungCap } = data;
    const sql = "CALL UpdatePhieuNhap(?, ?, ?)";
    db.query(sql, [MaPN, MaNhanVien, MaNhaCungCap], (err, results) => {
      if (err) {
        if (err.code === "45000") {
          return callback(new Error(err.sqlMessage));
        }
        return callback(err);
      }
      callback(null, results);
    });
  },

  delete: (MaPN, callback) => {
    const sql = "CALL DeletePhieuNhap(?)";
    db.query(sql, [MaPN], (err, results) => {
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

module.exports = PhieuNhap;
