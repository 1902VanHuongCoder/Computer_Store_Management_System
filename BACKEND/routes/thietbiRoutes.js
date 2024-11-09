const express = require('express');
const router = express.Router();
const thietbiController = require('../controllers/thietbiController');

router.get('/', thietbiController.getAllThietBi);
router.get('/:MaTB', thietbiController.getThietBiById);
router.post('/', thietbiController.addThietBi);
router.put('/:MaTB', thietbiController.updateThietBi);
router.delete('/:MaTB', thietbiController.deleteThietBi);

module.exports = router;