const NhaSanXuat = require("../models/nhasanxuatModel");

module.exports = {
  // Lấy danh sách tất cả nhà sản xuất
  getAllNhaSanXuat: (req, res) => {
    NhaSanXuat.getAll((err, result) => {
      if (err) {
        return res
          .status(500)
          .json({ error: "Lỗi khi lấy danh sách nhà sản xuất" });
      }
      res.json(result);
    });
  },

  // Lấy nhà sản xuất theo mã
  getNhaSanXuatById: (req, res) => {
    const { MaNSX } = req.params;
    NhaSanXuat.getById(MaNSX, (err, result) => {
      if (err) {
        return res.status(500).json({ error: "Lỗi khi lấy nhà sản xuất" });
      }
      res.json(result);
    });
  },

  // Thêm nhà sản xuất mới
  addNhaSanXuat: (req, res) => {
    const data = req.body;
    NhaSanXuat.create(data, (err, result) => {
      if (err) {
        return res.status(500).json({ error: "Lỗi khi thêm nhà sản xuất" });
      }
      res.status(201).json({ message: "Thêm nhà sản xuất thành công", result });
    });
  },

  // Cập nhật thông tin nhà sản xuất
  updateNhaSanXuat: (req, res) => {
    const { MaNSX } = req.params;
    const data = req.body;
    NhaSanXuat.update(MaNSX, data, (err, result) => {
      if (err) {
        return res.status(500).json({ error: "Lỗi khi cập nhật nhà sản xuất" });
      }
      res.json({ message: "Cập nhật nhà sản xuất thành công", result });
    });
  },

  // Xóa nhà sản xuất
  deleteNhaSanXuat: (req, res) => {
    const { MaNSX } = req.params;
    NhaSanXuat.delete(MaNSX, (err, result) => {
      if (err) {
        if (err.sqlMessage) {
          return res.status(400).json({ error: err.sqlMessage });
        }
        return res.status(500).json({ error: "Lỗi khi xóa nhà sản xuất" });
      }
      res.json({ message: "Xóa nhà sản xuất thành công", result });
    });
  },
};
