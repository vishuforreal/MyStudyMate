require('dotenv').config();
const cloudinary = require('./src/config/cloudinary');

console.log('🧪 Testing Cloudinary Connection...\n');

console.log('Configuration:');
console.log('✓ Cloud Name:', process.env.CLOUDINARY_CLOUD_NAME);
console.log('✓ API Key:', process.env.CLOUDINARY_API_KEY);
console.log('✓ API Secret:', process.env.CLOUDINARY_API_SECRET ? '***' + process.env.CLOUDINARY_API_SECRET.slice(-4) : 'Not set');

cloudinary.api.ping()
  .then(result => {
    console.log('\n✅ SUCCESS! Cloudinary is connected!');
    console.log('Status:', result.status);
    console.log('\n🎉 You can now upload files to Cloudinary!');
  })
  .catch(error => {
    console.log('\n❌ ERROR! Connection failed:');
    console.log(error.message);
  });
