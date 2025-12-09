const express = require('express');
const router = express.Router();
const User = require('../models/User');

router.post('/create-admin-now', async (req, res) => {
  try {
    const existingAdmin = await User.findOne({ email: 'admin@mystudymate.com' });
    
    if (existingAdmin) {
      return res.json({ message: 'Admin already exists', email: 'admin@mystudymate.com' });
    }

    const admin = await User.create({
      name: 'Super Admin',
      email: 'admin@mystudymate.com',
      password: 'admin123',
      phone: '1234567890',
      course: 'Admin',
      role: 'superadmin',
      securityQuestion: 'What is your pet name?',
      securityAnswer: 'admin',
    });

    res.json({ 
      success: true, 
      message: 'Admin created successfully',
      email: 'admin@mystudymate.com',
      password: 'admin123'
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

module.exports = router;
