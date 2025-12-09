@echo off
echo ========================================
echo   My Study Mate Backend with Cloudinary
echo ========================================
echo.
echo Testing Cloudinary connection...
cd backend
node test-cloudinary.js
echo.
echo ========================================
echo Starting backend server...
echo ========================================
echo.
npm start
