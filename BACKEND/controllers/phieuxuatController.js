const PhieuXuat = require("../models/phieuxuatModel");

module.exports = {
  getAllPhieuXuat: (req, res) => {
    PhieuXuat.getAll((err, result) => {
      if (err) {
        return res
          .status(500)
          .json({ error: "Lỗi khi lấy danh sách phiếu xuất" });
      }
      res.json(result);
    });
  },

  getPhieuXuatById: (req, res) => {
    const { MaPX } = req.params;
    PhieuXuat.getById(MaPX, (err, result) => {
      if (err) {
        return res.status(500).json({ error: "Lỗi khi lấy phiếu xuất" });
      }
      res.json(result);
    });
  },

  addPhieuXuat: (req, res) => {
    const data = req.body;
    if (!data.MaKhachHang) {
        return res.status(400).json({ error: "Mã khách hàng không được để trống" });
    } else if (!data.MaNhanVien) {
        return res.status(400).json({ error: "Mã nhân viên không được để trống" });
    }
    PhieuXuat.create(data, (err, result) => {
      if (err) {
        return res.status(400).json({ error: err.message });
      }
      res.status(201).json({ message: "Thêm phiếu xuất thành công", result });
    });
  },

  updatePhieuXuat: (req, res) => {
    const { MaPX } = req.params;
    const data = req.body;
    if (!data.MaKhachHang) {
        return res.status(400).json({ error: "Mã khách hàng không được để trống" });
    } else if (!data.MaNhanVien) {
        return res.status(400).json({ error: "Mã nhân viên không được để trống" });
    }
    PhieuXuat.update(MaPX, data, (err, result) => {
      if (err) {
        return res.status(400).json({ error: err.message });
      }
      res.json({ message: "Cập nhật phiếu xuất thành công", result });
    });
  },

  deletePhieuXuat: (req, res) => {
    const { MaPX } = req.params;
    PhieuXuat.delete(MaPX, (err, result) => {
      if (err) {
        return res.status(400).json({ error: err.message });
      }
      res.json({ message: "Xóa phiếu xuất thành công", result });
    });
  },
};