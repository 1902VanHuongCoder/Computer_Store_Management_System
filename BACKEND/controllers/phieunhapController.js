const PhieuNhap = require("../models/phieunhapModel");

module.exports = {
  getAllPhieuNhap: (req, res) => {
    PhieuNhap.getAll((err, result) => {
      if (err) {
        return res
          .status(500)
          .json({ error: "Lỗi khi lấy danh sách phiếu nhập" });
      }
      res.json(result);
    });
  },

  getPhieuNhapById: (req, res) => {
    const { MaPN } = req.params;
    PhieuNhap.getById(MaPN, (err, result) => {
      if (err) {
        return res.status(500).json({ error: "Lỗi khi lấy phiếu nhập" });
      }
      res.json(result);
    });
  },

  addPhieuNhap: (req, res) => {
    const data = req.body;
    if (!data.MaNhaCungCap) {
        return res.status(400).json({ error: "Mã nhà cung cấp không được để trống" });
    } else if (!data.MaNhanVien) {
        return res.status(400).json({ error: "Mã nhân viên không được để trống" });
    }
    PhieuNhap.create(data, (err, result) => {
      if (err) {
        return res.status(400).json({ error: err.message });
      }
      res.status(201).json({ message: "Thêm phiếu nhập thành công", result });
    });
  },

  updatePhieuNhap: (req, res) => {
    const { MaPN } = req.params;
    const data = req.body;
    if (!data.MaNhaCungCap) {
        return res.status(400).json({ error: "Mã nhà cung cấp không được để trống" });
    } else if (!data.MaNhanVien) {
        return res.status(400).json({ error: "Mã nhân viên không được để trống" });
    }
    PhieuNhap.update(MaPN, data, (err, result) => {
      if (err) {
        return res.status(400).json({ error: err.message });
      }
      res.json({ message: "Cập nhật phiếu nhập thành công", result });
    });
  },

  deletePhieuNhap: (req, res) => {
    const { MaPN } = req.params;
    PhieuNhap.delete(MaPN, (err, result) => {
      if (err) {
        return res.status(400).json({ error: err.message });
      }
      res.json({ message: "Xóa phiếu nhập thành công", result });
    });
  },
};
