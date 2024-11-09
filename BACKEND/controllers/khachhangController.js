const KhachHang = require('../models/khachhangModel');

module.exports = {

    // Lấy danh sách tất cả khách hàng
    getAllKhachHang: (req, res) => {
        KhachHang.getAll((err, result) => {
            if (err) {
                return res.status(500).json({ error: 'Lỗi khi lấy danh sách khách hàng' });
            }
            res.json(result);
        });
    },

    // Lấy khách hàng theo mã
    getKhachHangById: (req, res) => {
        const { MaKH } = req.params;
        KhachHang.getById(MaKH, (err, result) => {
            if (err) {
                return res.status(500).json({ error: 'Lỗi khi lấy khách hàng' });
            }
            res.json(result);
        });
    },

    // Thêm khách hàng mới
    addKhachHang: (req, res) => {
        const data = req.body;
        KhachHang.create(data, (err, result) => {
            if (err) {
                return res.status(500).json({ error: 'Lỗi khi thêm khách hàng' });
            }
            res.status(201).json({ message: 'Thêm khách hàng thành công', result });
        });
    },

    // Cập nhật thông tin khách hàng
    updateKhachHang: (req, res) => {
        const { MaKH } = req.params;
        const data = req.body;
        KhachHang.update(MaKH, data, (err, result) => {
            if (err) {
                return res.status(500).json({ error: 'Lỗi khi cập nhật khách hàng' });
            }
            res.json({ message: 'Cập nhật khách hàng thành công', result });
        });
    },

    // Xóa khách hàng
    deleteKhachHang: (req, res) => {
        const { MaKH } = req.params;
        KhachHang.delete(MaKH, (err, result) => {
            if (err) {
                return res.status(500).json({ error: 'Lỗi khi xóa khách hàng' });
            }
            res.json({ message: 'Xóa khách hàng thành công', result });
        });
    }
};
