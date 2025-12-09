const express = require('express');
const router = express.Router();
const { updateProfile, changePassword, forgotPassword, getSecurityQuestion } = require('../controllers/userController');
const { protect } = require('../middleware/auth');

router.put('/profile', protect, updateProfile);
router.put('/change-password', protect, changePassword);
router.post('/forgot-password', forgotPassword);
router.get('/security-question', getSecurityQuestion);

module.exports = router;
