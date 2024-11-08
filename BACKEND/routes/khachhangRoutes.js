const express = require('express');
const router = express.Router();
const khachhangController = require('../controllers/khachhangController');

router.get('/', khachhangController.getAllKhachHang);
router.get('/:MaKH', khachhangController.getKhachHangById);
router.post('/', khachhangController.addKhachHang);
router.put('/:MaKH', khachhangController.updateKhachHang);
router.delete('/:MaKH', khachhangController.deleteKhachHang);

module.exports = router;