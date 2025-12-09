const express = require('express');
const router = express.Router();
const { getPPTs, getPPTById, createPPT, updatePPT, deletePPT } = require('../controllers/pptController');
const { protect } = require('../middleware/auth');

router.get('/', getPPTs);
router.get('/:id', getPPTById);
router.post('/', protect, createPPT);
router.put('/:id', protect, updatePPT);
router.delete('/:id', protect, deletePPT);

module.exports = router;
