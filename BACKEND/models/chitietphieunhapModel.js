const db = require("../config/db");

const ChiTietPhieuNhap = {
  getAll: (callback) => {
    const sql = "CALL GetAllChiTietPhieuNhap()";
    db.query(sql, (err, results) => {
      if (err) return callback(err);
      callback(null, results[0]);
    });
  },

  getByMaPN: (MaPN, callback) => {
    const sql = "CALL GetChiTietPhieuNhapByMaPN(?)";
    db.query(sql, [MaPN], (err, results) => {
      if (err) return callback(err);
      callback(null, results[0]);
    });
  },

  create: (data, callback) => {
    const { MaPN, MaThietBi, SoLuong } = data;
    const sql = "CALL AddChiTietPhieuNhap(?, ?, ?)";
    db.query(sql, [MaPN, MaThietBi, SoLuong], (err, results) => {
      if (err) {
        if (err.code === "45000") {
          return callback(new Error(err.sqlMessage));
        }
        return callback(err);
      }
      callback(null, results);
    });
  },

  update: (MaPN, MaThietBi, data, callback) => {
    const { SoLuong} = data;
    const sql = "CALL UpdateChiTietPhieuNhap(?, ?, ?)";
    db.query(sql, [MaPN, MaThietBi, SoLuong], (err, results) => {
      if (err) {
        if (err.code === "45000") {
          return callback(new Error(err.sqlMessage));
        }
        return callback(err);
      }
      callback(null, results);
    });
  },

  delete: (MaPN, MaThietBi, callback) => {
    const sql = "CALL DeleteChiTietPhieuNhap(?, ?)";
    db.query(sql, [MaPN, MaThietBi], (err, results) => {
      if (err) {
        if (err.code === "45000") {
          return callback(new Error(err.sqlMessage));
        }
        return callback(err);
      }
      callback(null, results);
    });
  },

  getPDFId: (MaPN, callback) => {
    // Thay đổi từ req, res sang MaPN, callback
    const sql = `
        SELECT pn.*, cpn.*
        FROM PhieuNhap pn
        LEFT JOIN ChiTietPhieuNhap cpn ON pn.MaPN = cpn.MaPN
        WHERE pn.MaPN = ?
    `;
    db.query(sql, [MaPN], (err, results) => {
      if (err) {
        return callback(err); // Gọi callback với lỗi
      }
      callback(null, results); // Gọi callback với kết quả
    });
  },
};

module.exports = ChiTietPhieuNhap;