const express = require('express');
const router = express.Router();
const upload = require('../config/upload');
const { uploadFile, deleteFile } = require('../controllers/uploadController');
const { protect } = require('../middleware/auth');

router.post('/', protect, upload.single('file'), uploadFile);
router.delete('/', protect, deleteFile);

module.exports = router;
