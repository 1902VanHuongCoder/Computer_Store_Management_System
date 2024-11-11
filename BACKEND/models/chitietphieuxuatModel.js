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
    const { MaPX, MaThietBi, SoLuong, DonGia } = data;
    const sql = "CALL AddChiTietPhieuXuat(?, ?, ?, ?)";
    db.query(sql, [MaPX, MaThietBi, SoLuong, DonGia], (err, results) => {
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
    const { SoLuong, DonGia } = data;
    const sql = "CALL UpdateChiTietPhieuXuat(?, ?, ?, ?)";
    db.query(sql, [MaPX, MaThietBi, SoLuong, DonGia], (err, results) => {
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
};

module.exports = ChiTietPhieuXuat;