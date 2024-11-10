const db = require("../config/db");
const bcrypt = require("bcryptjs");
function randomMaNhanVien() {
  const prefix = "NV";
  const randomNumber = Math.floor(100000 + Math.random() * 900000);
  return `${prefix}${randomNumber}`;
}

const NhanVien = {
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

    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(MatKhau, salt);

    const sql = "CALL AddNhanVien(?, ?, ?, ?, ?, ?)";
    db.query(
      sql,
      [MaNhanVien, HoTen, NgaySinh, SoDienThoai, ChucVu, hashedPassword],
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

  update: async (MaNV, data, callback) => {
    const { HoTen, NgaySinh, SoDienThoai, ChucVu, MatKhau } = data;
    if (MatKhau) {
      const salt = await bcrypt.genSalt(10);
      hashedPassword = await bcrypt.hash(MatKhau, salt);
    } else {
      // Lấy mật khẩu hiện tại từ cơ sở dữ liệu
      const existingEmployee = await new Promise((resolve, reject) => {
        const sql = "SELECT MatKhau FROM NhanVien WHERE MaNhanVien = ?";
        db.query(sql, [MaNV], (err, results) => {
          if (err) return reject(err);
          resolve(results[0]);
        });
      });
      hashedPassword = existingEmployee ? existingEmployee.MatKhau : null; // Lưu mật khẩu cũ
    }

    const sql = "CALL UpdateNhanVien(?, ?, ?, ?, ?, ?)";
    db.query(
      sql,
      [MaNV, HoTen, NgaySinh, SoDienThoai, ChucVu, hashedPassword || MatKhau], // Sử dụng mật khẩu cũ nếu hashedPassword là null
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

  delete: (MaNV, callback) => {
    const sql = "CALL DeleteNhanVien(?)";
    db.query(sql, [MaNV], (err, results) => {
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

module.exports = NhanVien;
