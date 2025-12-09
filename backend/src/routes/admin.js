const express = require('express');
const router = express.Router();
const {
  getAllUsers,
  getAllAdmins,
  createAdmin,
  deleteAdmin,
  toggleBlockUser,
  updateUserPermissions,
  getCategories,
  createCategory,
  updateCategory,
  deleteCategory
} = require('../controllers/adminController');
const { protect } = require('../middleware/auth');

// User management
router.get('/users', protect, getAllUsers);
router.put('/users/:id/block', protect, toggleBlockUser);
router.put('/users/:id/permissions', protect, updateUserPermissions);

// Admin management
router.get('/admins', protect, getAllAdmins);
router.post('/admins', protect, createAdmin);
router.delete('/admins/:id', protect, deleteAdmin);

// Category management
router.get('/categories', protect, getCategories);
router.post('/categories', protect, createCategory);
router.put('/categories/:id', protect, updateCategory);
router.delete('/categories/:id', protect, deleteCategory);

module.exports = router;
