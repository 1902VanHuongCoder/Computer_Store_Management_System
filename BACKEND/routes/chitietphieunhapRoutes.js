const express = require('express');
const router = express.Router();
const chitietphieunhapController = require('../controllers/chitietphieunhapController');

router.get('/', chitietphieunhapController.getAllChiTietPhieuNhap);
router.get('/phieunhap/:MaPN', chitietphieunhapController.getChiTietPhieuNhapById);
router.post('/', chitietphieunhapController.addChiTietPhieuNhap);
router.put('/:MaPN/:MaThietBi', chitietphieunhapController.updateChiTietPhieuNhap);
router.delete('/:MaPN/:MaThietBi', chitietphieunhapController.deleteChiTietPhieuNhap);

module.exports = router;