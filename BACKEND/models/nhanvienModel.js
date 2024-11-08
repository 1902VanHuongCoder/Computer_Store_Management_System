const db = require("../config/db");
const bcrypt = require("bcryptjs");
function randomMaNhanVien() {
  const prefix = "NV";
  const randomNumber = Math.floor(100000 + Math.random() * 900000);
  return `${prefix}${randomNumber}`;
}

const NhanVien = {
  // Hàm kiểm tra số điện thoại đã tồn tại hay chưa
  checkPhoneNumberExists: (SoDienThoai, callback) => {
    const sql = "SELECT COUNT(*) AS count FROM NhanVien WHERE SoDienThoai = ?";
    db.query(sql, [SoDienThoai], (err, results) => {
      if (err) return callback(err);
      callback(null, results[0].count > 0);
    });
  },
  getAll: (callback) => {
    const sql = "CALL GetAllNhanVien()";
    db.query(sql, (err, results) => {
      if (err) return callback(err);
      callback(null, results[0]);
    });
  },

  getById: (MaKH, callback) => {
    const sql = "CALL GetNhanVienById(?)";
    db.query(sql, [MaKH], (err, results) => {
      if (err) return callback(err);
      callback(null, results[0]);
    });
  },

  create: async (data, callback) => {
    const MaNhanVien = randomMaNhanVien();
    const { HoTen, NgaySinh, SoDienThoai, ChucVu, MatKhau } = data;
    NhanVien.checkPhoneNumberExists(SoDienThoai, async (err, exists) => {
        if (err) return callback(err);
        if (exists) {
            return callback(new Error("Số điện thoại này đã tồn tại"));
        }

        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(MatKhau, salt);

        const sql = "CALL AddNhanVien(?, ?, ?, ?, ?, ?)";
        db.query(
            sql,
            [MaNhanVien, HoTen, NgaySinh, SoDienThoai, ChucVu, hashedPassword],
            (err, results) => {
                if (err) return callback(err);
                callback(null, results);
            }
        );
    });
},

  update: (MaNV, data, callback) => {
    const { TenKhachHang, NgaySinh, SoDienThoai } = data;
    const sql = "CALL UpdateNhanVien(?, ?, ?, ?)";
    db.query(
      sql,
      [MaNV, TenKhachHang, NgaySinh, SoDienThoai],
      (err, results) => {
        if (err) return callback(err);
        callback(null, results);
      }
    );
  },

  delete: (MaNV, callback) => {
    const sql = "CALL DeleteNhanVien(?)";
    db.query(sql, [MaNV], (err, results) => {
      if (err) return callback(err);
      callback(null, results);
    });
  },
};

module.exports = NhanVien;
