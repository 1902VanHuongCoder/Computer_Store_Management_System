const express = require('express');
const router = express.Router();
const nhasanxuatController = require('../controllers/nhasanxuatController');

router.get('/', nhasanxuatController.getAllNhaSanXuat);
router.get('/:MaNSX', nhasanxuatController.getNhaSanXuatById);
router.post('/', nhasanxuatController.addNhaSanXuat);
router.put('/:MaNSX', nhasanxuatController.updateNhaSanXuat);
router.delete('/:MaNSX', nhasanxuatController.deleteNhaSanXuat);

module.exports = router;