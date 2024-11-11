const express = require('express');
const router = express.Router();
const phieuxuatController = require('../controllers/phieuxuatController');

router.get('/', phieuxuatController.getAllPhieuXuat);
router.get('/:MaPX', phieuxuatController.getPhieuXuatById);
router.post('/', phieuxuatController.addPhieuXuat);
router.put('/:MaPX', phieuxuatController.updatePhieuXuat);
router.delete('/:MaPX', phieuxuatController.deletePhieuXuat);

module.exports = router;