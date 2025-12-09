const express = require('express');
const router = express.Router();
const { getAssignments, getAssignmentById, createAssignment, updateAssignment, deleteAssignment } = require('../controllers/assignmentController');
const { protect } = require('../middleware/auth');

router.get('/', getAssignments);
router.get('/:id', getAssignmentById);
router.post('/', protect, createAssignment);
router.put('/:id', protect, updateAssignment);
router.delete('/:id', protect, deleteAssignment);

module.exports = router;
