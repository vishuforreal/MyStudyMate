# 🚀 Complete Beginner's Guide - My Study Mate Flutter App

## Step 1: Install Flutter SDK (15 minutes)

### Download Flutter
1. Go to: https://docs.flutter.dev/get-started/install/windows
2. Click "Download Flutter SDK" button
3. Download the ZIP file (around 1 GB)

### Extract Flutter
1. Extract the ZIP file to `C:\` drive
2. You should have: `C:\flutter\` folder
3. Inside you'll see folders like `bin`, `packages`, etc.

### Add Flutter to PATH
1. Press `Windows + R`
2. Type: `sysdm.cpl` and press Enter
3. Click "Advanced" tab → "Environment Variables"
4. Under "User variables", find "Path" → Click "Edit"
5. Click "New" → Add: `C:\flutter\bin`
6. Click "OK" on all windows
7. **Restart your computer**

### Verify Flutter Installation
1. Open Command Prompt (search "cmd" in Windows)
2. Type: `flutter --version`
3. You should see Flutter version info

---

## Step 2: Install Android Studio (20 minutes)

### Download Android Studio
1. Go to: https://developer.android.com/studio
2. Click "Download Android Studio"
3. Accept terms and download (around 1 GB)

### Install Android Studio
1. Run the downloaded `.exe` file
2. Click "Next" → "Next" → "Install"
3. Wait for installation (10-15 minutes)
4. Click "Finish"

### First Time Setup
1. Android Studio will open
2. Click "Next" on Welcome screen
3. Choose "Standard" installation
4. Click "Next" → "Finish"
5. Wait for SDK download (this takes 10-20 minutes)

---

## Step 3: Configure Flutter in Android Studio (5 minutes)

### Install Flutter Plugin
1. Open Android Studio
2. Click "Plugins" (on welcome screen) OR File → Settings → Plugins
3. Search for "Flutter"
4. Click "Install" on Flutter plugin
5. It will also install Dart plugin automatically
6. Click "Restart IDE"

### Run Flutter Doctor
1. Open Command Prompt
2. Type: `flutter doctor`
3. This checks if everything is installed correctly
4. You might see some warnings - that's okay for now

---

## Step 4: Create Android Emulator (10 minutes)

### Open Device Manager
1. Open Android Studio
2. Click "More Actions" → "Virtual Device Manager"
   OR Tools → Device Manager

### Create New Device
1. Click "Create Device"
2. Select "Phone" → Choose "Pixel 5" → Click "Next"
3. Download a system image:
   - Select "R" (API 30) or latest
   - Click "Download" next to it
   - Wait for download (5-10 minutes)
   - Click "Finish"
4. Click "Next" → "Finish"

### Start Emulator
1. Click the ▶️ (Play) button next to your device
2. Wait for emulator to start (2-3 minutes first time)
3. You'll see an Android phone on your screen

---

## Step 5: Open Your Flutter Project (5 minutes)

### Open Project in Android Studio
1. Open Android Studio
2. Click "Open" (on welcome screen)
3. Navigate to: `D:\MyStudyMate\flutter_app`
4. Click "OK"

### Wait for Setup
1. Android Studio will index files (2-3 minutes)
2. Bottom right: You'll see "Pub get" running
3. Wait until it says "Ready"

---

## Step 6: Run Your App! 🎉 (2 minutes)

### Make Sure Emulator is Running
1. Check if Android emulator is open
2. If not, start it from Device Manager

### Run the App
1. In Android Studio, top right corner
2. You'll see a green ▶️ (Play) button
3. Next to it, select your emulator device
4. Click the green ▶️ button
5. Wait 2-3 minutes for first build

### See Your App!
- The app will open in the emulator
- You'll see the My Study Mate splash screen
- Then onboarding screens
- Then login screen

---

## 🎯 Quick Commands Reference

```bash
# Check Flutter installation
flutter doctor

# Get dependencies
cd D:\MyStudyMate\flutter_app
flutter pub get

# Run app
flutter run

# Build APK
flutter build apk --release
```

---

## ⚠️ Common Issues & Solutions

### Issue 1: "flutter is not recognized"
**Solution:** Flutter not in PATH. Redo Step 1 (Add to PATH) and restart computer.

### Issue 2: Android Studio can't find Flutter SDK
**Solution:** 
1. File → Settings → Languages & Frameworks → Flutter
2. Set Flutter SDK path: `C:\flutter`

### Issue 3: Emulator won't start
**Solution:** 
1. Enable Virtualization in BIOS
2. OR use a physical Android phone (enable USB debugging)

### Issue 4: "Pub get failed"
**Solution:**
```bash
cd D:\MyStudyMate\flutter_app
flutter clean
flutter pub get
```

---

## 📱 Using Physical Phone Instead of Emulator

1. Enable Developer Options on your phone:
   - Go to Settings → About Phone
   - Tap "Build Number" 7 times
2. Enable USB Debugging:
   - Settings → Developer Options → USB Debugging (ON)
3. Connect phone to computer via USB
4. Allow USB debugging on phone
5. In Android Studio, select your phone from device dropdown
6. Click Run

---

## 🎓 What You Have Now

✅ Flutter SDK installed
✅ Android Studio setup
✅ Emulator ready
✅ My Study Mate app running
✅ 6 screens working (Splash, Onboarding, Login, Register, Home, Course Selection)

---

## 🚀 Next Steps After Running

1. **Explore the app** - Click through all screens
2. **Modify colors** - Edit `lib/utils/colors.dart`
3. **Add more features** - I can help you build:
   - Notes viewer
   - PDF reader
   - Test/Quiz module
   - Payment integration

---

## 💡 Tips

- First build takes 5-10 minutes (normal!)
- Hot reload: Press `r` in terminal while app is running
- Hot restart: Press `R` in terminal
- Stop app: Press `q` in terminal

---

## 📞 Need Help?

If you get stuck at any step, tell me:
1. Which step you're on
2. What error message you see
3. Screenshot if possible

I'll help you fix it! 🚀

---

**Total Time: ~1 hour for complete setup**
**After setup: Run app in 2 minutes anytime!**
