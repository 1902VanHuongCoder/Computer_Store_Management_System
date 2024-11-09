const db = require("../config/db");
function randomMaThietBi() {
  const prefix = "TB";
  const randomNumber = Math.floor(100000 + Math.random() * 900000);
  return `${prefix}${randomNumber}`;
}
const ThietBi = {
  getAll: (callback) => {
    const sql = "CALL GetAllThietBi()";
    db.query(sql, (err, results) => {
      if (err) return callback(err);
      callback(null, results[0]);
    });
  },

  getById: (MaTB, callback) => {
    const sql = "CALL GetThietBiById(?)";
    db.query(sql, [MaTB], (err, results) => {
      if (err) return callback(err);
      callback(null, results[0]);
    });
  },

  create: (data, callback) => {
    const MaThietBi = randomMaThietBi();
    const { TenThietBi, MaNSX, ThongSoKT, MaLoai, GiaThanh, MaNhaCungCap } = data;
    const sql = "CALL AddThietBi(?, ?, ?, ?, ?, ?, ?)";
    db.query( 
      sql,
      [MaThietBi, TenThietBi, MaNSX, ThongSoKT, MaLoai, GiaThanh, MaNhaCungCap],
      (err, results) => {
        if (err) {
          return callback(new Error(err.sqlMessage));
        }
        callback(null, results);
      }
    );
  },

  update: (MaTB, data, callback) => {
    const { TenThietBi, MaNSX, ThongSoKT, MaLoai, GiaThanh, MaNhaCungCap } =
      data;
    const sql = "CALL UpdateThietBi(?, ?, ?, ?, ?, ?, ?)";
    db.query(
      sql,
      [MaTB, TenThietBi, MaNSX, ThongSoKT, MaLoai, GiaThanh, MaNhaCungCap],
      (err, results) => {
        if (err) {
          if (err.code === "45000") {
            return callback(new Error(err.sqlMessage));
          }
          return callback(err);
        }
        callback(null, results);
      }
    );
  },

  delete: (MaTB, callback) => {
    const sql = "CALL DeleteThietBi(?)";
    db.query(sql, [MaTB], (err, results) => {
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

module.exports = ThietBi;