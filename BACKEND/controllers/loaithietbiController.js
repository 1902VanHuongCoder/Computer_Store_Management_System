const LoaiThietBi = require('../models/loaithietbiModel');

module.exports = {

    // Lấy danh sách tất cả loại thiết bị
    getAllLoaiThietBi: (req, res) => {
        LoaiThietBi.getAll((err, result) => {
            if (err) {
                return res.status(500).json({ error: 'Lỗi khi lấy danh sách loại thiết bị' });
            }
            res.json(result);
        });
    },

    // Lấy loại thiết bị theo mã
    getLoaiThietBiById: (req, res) => {
        const { MaLoaiThietBi } = req.params;
        LoaiThietBi.getById(MaLoaiThietBi, (err, result) => {
            if (err) {
                return res.status(500).json({ error: 'Lỗi khi lấy loại thiết bị' });
            }
            res.json(result);
        });
    },

    // Thêm loại thiết bị mới
    addLoaiThietBi: (req, res) => {
        const data = req.body;
        LoaiThietBi.create(data, (err, result) => {
            if (err) {
                return res.status(500).json({ error: 'Lỗi khi thêm loại thiết bị' });
            }
            res.status(201).json({ message: 'Thêm loại thiết bị thành công', result });
        });
    },

    // Cập nhật thông tin loại thiết bị
    updateLoaiThietBi: (req, res) => {
        const { MaLoaiThietBi } = req.params;
        const data = req.body;
        LoaiThietBi.update(MaLoaiThietBi, data, (err, result) => {
            if (err) {
                return res.status(500).json({ error: 'Lỗi khi cập nhật loại thiết bị' });
            }
            res.json({ message: 'Cập nhật loại thiết bị thành công', result });
        });
    },

    // Xóa loại thiết bị
    deleteLoaiThietBi: (req, res) => {
        const { MaLoaiThietBi } = req.params;
        LoaiThietBi.delete(MaLoaiThietBi, (err, result) => {
            if (err) {
                return res.status(500).json({ error: 'Lỗi khi xóa loại thiết bị' });
            }
            res.json({ message: 'Xóa loại thiết bị thành công', result });
        });
    }
};
