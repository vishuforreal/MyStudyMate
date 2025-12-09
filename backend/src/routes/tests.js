const express = require('express');
const router = express.Router();
const { getTests, getTestById, createTest, updateTest, deleteTest, submitTest, getUserResults } = require('../controllers/testController');
const { protect } = require('../middleware/auth');

router.get('/', getTests);
router.get('/results', protect, getUserResults);
router.get('/:id', getTestById);
router.post('/', protect, createTest);
router.put('/:id', protect, updateTest);
router.delete('/:id', protect, deleteTest);
router.post('/:id/submit', protect, submitTest);

module.exports = router;
