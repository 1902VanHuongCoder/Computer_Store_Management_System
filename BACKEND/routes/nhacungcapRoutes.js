const express = require('express');
const router = express.Router();
const nhacungcapController = require('../controllers/nhacungcapController');

router.get('/', nhacungcapController.getAllNhaCungCap);
router.get('/:MaNCC', nhacungcapController.getNhaCungCapById);
router.post('/', nhacungcapController.addNhaCungCap);
router.put('/:MaNCC', nhacungcapController.updateNhaCungCap);
router.delete('/:MaNCC', nhacungcapController.deleteNhaCungCap);

module.exports = router;