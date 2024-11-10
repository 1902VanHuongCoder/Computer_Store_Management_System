const NhanVien = require("../models/nhanvienModel");

module.exports = {
  // Lấy danh sách tất cả nhân viên
  getAllNhanVien: (req, res) => {
    NhanVien.getAll((err, result) => {
      if (err) {
        return res
          .status(500)
          .json({ error: "Lỗi khi lấy danh sách nhân viên" });
      }
      res.json(result);
    });
  },

  // Lấy nhân viên theo mã
  getNhanVienById: (req, res) => {
    const { MaNV } = req.params;
    NhanVien.getById(MaNV, (err, result) => {
      if (err) {
        return res.status(500).json({ error: "Lỗi khi lấy nhân viên" });
      }
      res.json(result);
    });
  },

  // Thêm nhân viên mới
  addNhanVien: (req, res) => {
    const data = req.body;
    if (!data.MatKhau) {
      return res.status(400).json({ error: "Mật khẩu không được để trống" });
    }
    if (data.MatKhau.length < 6) {
        return res.status(400).json({ error: "Mật khẩu phải có ít nhất 6 ký tự" });
    }
    NhanVien.create(data, (err, result) => {
      if (err) {
        return res.status(400).json({ error: err.message });
      }
      res.status(201).json({ message: "Thêm nhân viên thành công", result });
    });
  },

  // Cập nhật thông tin nhân viên
  updateNhanVien: (req, res) => {
    const { MaNV } = req.params;
    const data = req.body;
    NhanVien.update(MaNV, data, (err, result) => {
      if (err) {
        return res.status(400).json({ error: err.message });
      }
      res.json({ message: "Cập nhật nhân viên thành công", result });
    });
  },

  // Xóa nhân viên
  deleteNhanVien: (req, res) => {
    const { MaNV } = req.params;
    NhanVien.delete(MaNV, (err, result) => {
      if (err) {
        return res.status(400).json({ error: err.message });
      }
      res.json({ message: "Xóa nhân viên thành công", result });
    });
  },
};
