const ThietBi = require("../models/thietbiModel");

module.exports = {
  getAllThietBi: (req, res) => {
    ThietBi.getAll((err, result) => {
      if (err) {
        return res
          .status(500)
          .json({ error: "Lỗi khi lấy danh sách thiết bị" });
      }
      res.json(result);
    });
  },

  getThietBiById: (req, res) => {
    const { MaTB } = req.params;
    ThietBi.getById(MaTB, (err, result) => {
      if (err) {
        return res.status(500).json({ error: "Lỗi khi lấy thiết bị" });
      }
      res.json(result);
    });
  },

  addThietBi: (req, res) => {
    const data = req.body;
    if (!data.MaNSX) {
      return res.status(400).json({ error: "Mã nhà sản xuất không được để trống" });
    } else if (!data.MaNhaCungCap){
      return res.status(400).json({ error: "Mã nhà cung cấp không được để trống" });
    } else if (!data.MaLoai) {
      return res.status(400).json({ error: "Mã loại thiết bị không được để trống" });
    } else if (!data.GiaThanh) {
      return res.status(400).json({ error: "Giá thành không được để trống" });
    }

    ThietBi.create(data, (err, result) => {
      if (err) {
        return res.status(400).json({ error: err.message });
      }
      res
        .status(201)
        .json({ message: "Thêm thiết bị thành công", result });
    });
  },

  updateThietBi: (req, res) => {
    const { MaTB } = req.params;
    const data = req.body;
    ThietBi.update(MaTB, data, (err, result) => {
      if (err) {
        return res.status(400).json({ error: err.message });
      }
      res.json({ message: "Cập nhật thiết bị thành công", result });
    });
  },

  deleteThietBi: (req, res) => {
    const { MaTB } = req.params;
    ThietBi.delete(MaTB, (err, result) => {
      if (err) {
        return res.status(400).json({ error: err.message });
      }
      res.json({ message: "Xóa thiết bị thành công", result });
    });
  },
};
