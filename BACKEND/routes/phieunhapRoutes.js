const express = require('express');
const router = express.Router();
const phieunhapController = require('../controllers/phieunhapController');

router.get('/', phieunhapController.getAllPhieuNhap);
router.get('/:MaPN', phieunhapController.getPhieuNhapById);
router.post('/', phieunhapController.addPhieuNhap);
router.put('/:MaPN', phieunhapController.updatePhieuNhap);
router.delete('/:MaPN', phieunhapController.deletePhieuNhap);

module.exports = router;