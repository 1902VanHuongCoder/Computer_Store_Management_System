const NhaCungCap = require("../models/nhacungcapModel");

module.exports = {
  // Lấy danh sách tất cả nhà cung cấp
  getAllNhaCungCap: (req, res) => {
    NhaCungCap.getAll((err, result) => {
      if (err) {
        return res
          .status(500)
          .json({ error: "Lỗi khi lấy danh sách nhà cung cấp" });
      }
      res.json(result);
    });
  },

  // Lấy nhà cung cấp theo mã
  getNhaCungCapById: (req, res) => {
    const { MaNCC } = req.params;
    NhaCungCap.getById(MaNCC, (err, result) => {
      if (err) {
        return res.status(500).json({ error: "Lỗi khi lấy nhà cung cấp" });
      }
      res.json(result);
    });
  },

  // Thêm nhà cung cấp mới
  addNhaCungCap: (req, res) => {
    const data = req.body;
    NhaCungCap.create(data, (err, result) => {
      if (err) {
        return res.status(500).json({ error: "Lỗi khi thêm nhà cung cấp" });
      }
      res.status(201).json({ message: "Thêm nhà cung cấp thành công", result });
    });
  },

  // Cập nhật thông tin nhà cung cấp
  updateNhaCungCap: (req, res) => {
    const { MaNCC } = req.params;
    const data = req.body;
    NhaCungCap.update(MaNCC, data, (err, result) => {
      if (err) {
        return res.status(500).json({ error: "Lỗi khi cập nhật nhà cung cấp" });
      }
      res.json({ message: "Cập nhật nhà cung cấp thành công", result });
    });
  },

  // Xóa nhà cung cấp
  deleteNhaCungCap: (req, res) => {
    const { MaNCC } = req.params;
    NhaCungCap.delete(MaNCC, (err, result) => {
      if (err) {
        if (err.sqlMessage) {
          return res.status(400).json({ error: err.sqlMessage });
        }
        return res.status(500).json({ error: "Lỗi khi xóa nhà cung cấp" });
      }
      res.json({ message: "Xóa nhà cung cấp thành công", result });
    });
  },
};
