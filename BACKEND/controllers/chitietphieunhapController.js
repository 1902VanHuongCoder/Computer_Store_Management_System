const ChiTietPhieuNhap = require("../models/chitietphieunhapModel");

module.exports = {
  getAllChiTietPhieuNhap: (req, res) => {
    ChiTietPhieuNhap.getAll((err, result) => {
      if (err) {
        return res.status(500).json({ error: "Lỗi khi lấy danh sách chi tiết phiếu nhập" });
      }
      res.json(result);
    });
  },

  getChiTietPhieuNhapById: (req, res) => {
    const { MaPN } = req.params;
    ChiTietPhieuNhap.getByMaPN(MaPN, (err, result) => {
      if (err) {
        return res.status(500).json({ error: "Lỗi khi lấy chi tiết phiếu nhập" });
      }
      res.json(result);
    });
  },

  addChiTietPhieuNhap: (req, res) => {
    const data = req.body;
    if (!data.MaPN) {
      return res.status(400).json({ error: "Mã phiếu nhập không được để trống" });
    } else if (!data.MaThietBi) {
      return res.status(400).json({ error: "Mã thiết bị không được để trống" });
    } else if (!data.SoLuong) {
      return res.status(400).json({ error: "Số lượng không được để trống" });
    } else if (!data.DonGia) {
      return res.status(400).json({ error: "Đơn giá không được để trống" });
    }
    ChiTietPhieuNhap.create(data, (err, result) => {
      if (err) {
        return res.status(400).json({ error: err.message });
      }
      res.status(201).json({ message: "Thêm chi tiết phiếu nhập thành công", result });
    });
  },

  updateChiTietPhieuNhap: (req, res) => {
    const { MaPN, MaThietBi } = req.params;
    const data = req.body;
    if (!data.SoLuong) {
      return res.status(400).json({ error: "Số lượng không được để trống" });
    } else if (!data.DonGia) {
      return res.status(400).json({ error: "Đơn giá không được để trống" });
    }
    ChiTietPhieuNhap.update(MaPN, MaThietBi, data, (err, result) => {
      if (err) {
        return res.status(400).json({ error: err.message });
      }
      res.json({ message: "Cập nhật chi tiết phiếu nhập thành công", result });
    });
  },

  deleteChiTietPhieuNhap: (req, res) => {
    const { MaPN, MaThietBi } = req.params;
    ChiTietPhieuNhap.delete(MaPN, MaThietBi, (err, result) => {
      if (err) {
        return res.status(400).json({ error: err.message });
      }
      res.json({ message: "Xóa chi tiết phiếu nhập thành công", result });
    });
  },
};