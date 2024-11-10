const express = require('express');
const router = express.Router();
const nhanvienController = require('../controllers/nhanvienController');

router.get('/', nhanvienController.getAllNhanVien);
router.get('/:MaNV', nhanvienController.getNhanVienById);
router.post('/', nhanvienController.addNhanVien);
router.put('/:MaNV', nhanvienController.updateNhanVien);
router.delete('/:MaNV', nhanvienController.deleteNhanVien);
router.post('/login', nhanvienController.loginNhanVien);

module.exports = router;