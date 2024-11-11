const express = require('express');
const router = express.Router();
const chitietphieuxuatController = require('../controllers/chitietphieuxuatController');

router.get('/', chitietphieuxuatController.getAllChiTietPhieuXuat);
router.get('/phieuxuat/:MaPX', chitietphieuxuatController.getChiTietPhieuXuatById);
router.post('/', chitietphieuxuatController.addChiTietPhieuXuat);
router.put('/:MaPX/:MaThietBi', chitietphieuxuatController.updateChiTietPhieuXuat);
router.delete('/:MaPX/:MaThietBi', chitietphieuxuatController.deleteChiTietPhieuXuat);
router.get('/details/:MaPX', chitietphieuxuatController.getPhieuXuatWithDetailsById);

module.exports = router;