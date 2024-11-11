const db = require("../config/db");

const ChiTietPhieuXuat = {
  getAll: (callback) => {
    const sql = "CALL GetAllChiTietPhieuXuat()";
    db.query(sql, (err, results) => {
      if (err) return callback(err);
      callback(null, results[0]);
    });
  },

  getByMaPX: (MaPX, callback) => {
    const sql = "CALL GetChiTietPhieuXuatByMaPX(?)";
    db.query(sql, [MaPX], (err, results) => {
      if (err) return callback(err);
      callback(null, results[0]);
    });
  },

  create: (data, callback) => {
    const { MaPX, MaThietBi, SoLuong } = data;
    const sql = "CALL AddChiTietPhieuXuat(?, ?, ?)";
    db.query(sql, [MaPX, MaThietBi, SoLuong], (err, results) => {
      if (err) {
        if (err.code === "45000") {
          return callback(new Error(err.sqlMessage));
        }
        return callback(err);
      }
      callback(null, results);
    });
  },

  update: (MaPX, MaThietBi, data, callback) => {
    const { SoLuong } = data;
    const sql = "CALL UpdateChiTietPhieuXuat(?, ?, ?)";
    db.query(sql, [MaPX, MaThietBi, SoLuong], (err, results) => {
      if (err) {
        if (err.code === "45000") {
          return callback(new Error(err.sqlMessage));
        }
        return callback(err);
      }
      callback(null, results);
    });
  },

  delete: (MaPX, MaThietBi, callback) => {
    const sql = "CALL DeleteChiTietPhieuXuat(?, ?)";
    db.query(sql, [MaPX, MaThietBi], (err, results) => {
      if (err) {
        if (err.code === "45000") {
          return callback(new Error(err.sqlMessage));
        }
        return callback(err);
      }
      callback(null, results);
    });
  },
  getPDFId: (MaPX, callback) => { // Thay đổi từ req, res sang MaPX, callback
    const sql = `
        SELECT px.*, cpx.*
        FROM PhieuXuat px
        LEFT JOIN ChiTietPhieuXuat cpx ON px.MaPX = cpx.MaPX
        WHERE px.MaPX = ?
    `;
    db.query(sql, [MaPX], (err, results) => {
        if (err) {
            return callback(err); // Gọi callback với lỗi
        }
        callback(null, results); // Gọi callback với kết quả
    });
},
};

module.exports = ChiTietPhieuXuat;
