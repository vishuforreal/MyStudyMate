const mongoose = require('mongoose');
const User = require('../models/User');
require('dotenv').config();

const createAdmin = async () => {
  try {
    await mongoose.connect(process.env.MONGODB_URI);
    console.log('✅ Connected to MongoDB');

    const existingAdmin = await User.findOne({ email: 'admin@mystudymate.com' });
    
    if (existingAdmin) {
      console.log('⚠️  Admin already exists');
      process.exit(0);
    }

    const admin = await User.create({
      name: 'Super Admin',
      email: 'admin@mystudymate.com',
      password: 'admin123',
      phone: '1234567890',
      course: 'BCA',
      role: 'superadmin',
      securityQuestion: 'What is your pet name?',
      securityAnswer: 'admin',
    });

    console.log('✅ Admin user created successfully');
    console.log('📧 Email: admin@mystudymate.com');
    console.log('🔑 Password: admin123');
    
    process.exit(0);
  } catch (error) {
    console.error('❌ Error:', error.message);
    process.exit(1);
  }
};

createAdmin();
