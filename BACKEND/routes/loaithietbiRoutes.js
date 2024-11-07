const express = require('express');
const router = express.Router();
const loaithietbiController = require('../controllers/loaithietbiController');

router.get('/', loaithietbiController.getAllLoaiThietBi);
router.get('/:MaLoaiThietBi', loaithietbiController.getLoaiThietBiById);
router.post('/', loaithietbiController.addLoaiThietBi);
router.put('/:MaLoaiThietBi', loaithietbiController.updateLoaiThietBi);
router.delete('/:MaLoaiThietBi', loaithietbiController.deleteLoaiThietBi);

module.exports = router;