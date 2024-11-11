const ChiTietPhieuXuat = require("../models/chitietphieuxuatModel");

module.exports = {
  getAllChiTietPhieuXuat: (req, res) => {
    ChiTietPhieuXuat.getAll((err, result) => {
      if (err) {
        return res.status(500).json({ error: "Lỗi khi lấy danh sách chi tiết phiếu xuất" });
      }
      res.json(result);
    });
  },

  getChiTietPhieuXuatById: (req, res) => {
    const { MaPX } = req.params;
    ChiTietPhieuXuat.getByMaPX(MaPX, (err, result) => {
      if (err) {
        return res.status(500).json({ error: "Lỗi khi lấy chi tiết phiếu xuất" });
      }
      res.json(result);
    });
  },

  addChiTietPhieuXuat: (req, res) => {
    const data = req.body;
    if (!data.MaThietBi) {
      return res.status(400).json({ error: "Mã thiết bị không được để trống" });
    } else if (!data.MaPX) {
      return res.status(400).json({ error: "Mã hóa đơn không được để trống" });
    } else if (!data.SoLuong) {
      return res.status(400).json({ error: "Số lượng không được để trống" });
    }
    ChiTietPhieuXuat.create(data, (err, result) => {
      if (err) {
        return res.status(400).json({ error: err.message });
      }
      res.status(201).json({ message: "Thêm chi tiết phiếu xuất thành công", result });
    });
  },

  updateChiTietPhieuXuat: (req, res) => {
    const { MaPX, MaThietBi } = req.params;
    const data = req.body;
    if (!data.SoLuong) {
      return res.status(400).json({ error: "Số lượng không được để trống" });
    }
    ChiTietPhieuXuat.update(MaPX, MaThietBi, data, (err, result) => {
      if (err) {
        return res.status(400).json({ error: err.message });
      }
      res.json({ message: "Cập nhật chi tiết phiếu xuất thành công", result });
    });
  },

  deleteChiTietPhieuXuat: (req, res) => {
    const { MaPX, MaThietBi } = req.params;
    ChiTietPhieuXuat.delete(MaPX, MaThietBi, (err, result) => {
      if (err) {
        return res.status(400).json({ error: err.message });
      }
      res.json({ message: "Xóa chi tiết phiếu xuất thành công", result });
    });
  },
};