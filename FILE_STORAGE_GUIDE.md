# File Storage Setup Guide

## Option 1: Local Server Storage (Development)

### Setup
1. Create uploads folder:
```bash
cd backend
mkdir uploads
mkdir uploads/notes uploads/books uploads/tests uploads/ppts uploads/projects uploads/assignments
```

2. Install multer (already installed):
```bash
npm install multer
```

3. Files stored at: `backend/uploads/`

### Pros:
- Free
- Fast for development
- No external dependencies

### Cons:
- Files lost if server restarts
- Not scalable
- No CDN

---

## Option 2: AWS S3 (Recommended for Production)

### Setup Steps:

#### 1. Create AWS Account
- Go to https://aws.amazon.com
- Sign up (Free tier: 5GB storage, 20,000 GET requests/month)

#### 2. Create S3 Bucket
1. Go to AWS Console → S3
2. Click "Create bucket"
3. Bucket name: `mystudymate-files` (must be unique)
4. Region: Choose closest to you
5. Uncheck "Block all public access"
6. Click "Create bucket"

#### 3. Get Access Keys
1. Go to IAM → Users → Create user
2. User name: `mystudymate-uploader`
3. Attach policy: `AmazonS3FullAccess`
4. Create user
5. Security credentials → Create access key
6. Save: Access Key ID and Secret Access Key

#### 4. Install AWS SDK
```bash
cd backend
npm install aws-sdk multer multer-s3
```

#### 5. Update .env
```
AWS_ACCESS_KEY_ID=your_access_key
AWS_SECRET_ACCESS_KEY=your_secret_key
AWS_REGION=us-east-1
AWS_BUCKET_NAME=mystudymate-files
```

### Pros:
- Scalable
- Reliable
- CDN available
- 99.99% uptime

### Cons:
- Costs money after free tier
- Requires AWS account

---

## Option 3: Firebase Storage (Easy Alternative)

### Setup Steps:

#### 1. Create Firebase Project
1. Go to https://console.firebase.google.com
2. Click "Add project"
3. Project name: `MyStudyMate`
4. Disable Google Analytics (optional)
5. Create project

#### 2. Enable Storage
1. Go to Build → Storage
2. Click "Get started"
3. Start in production mode
4. Choose location
5. Done

#### 3. Get Config
1. Project settings → General
2. Scroll to "Your apps"
3. Click Web icon (</>)
4. Copy config

#### 4. Install Firebase
```bash
cd backend
npm install firebase-admin
```

#### 5. Download Service Account
1. Project settings → Service accounts
2. Click "Generate new private key"
3. Save as `firebase-service-account.json` in backend folder

### Pros:
- Easy setup
- Free tier: 5GB storage, 1GB/day download
- Good documentation

### Cons:
- Google dependency
- Limited free tier

---

## Option 4: Cloudinary (Best for Images/PDFs)

### Setup Steps:

#### 1. Create Account
- Go to https://cloudinary.com
- Sign up (Free: 25GB storage, 25GB bandwidth/month)

#### 2. Get Credentials
- Dashboard shows: Cloud name, API Key, API Secret

#### 3. Install SDK
```bash
cd backend
npm install cloudinary multer
```

#### 4. Update .env
```
CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_API_KEY=your_api_key
CLOUDINARY_API_SECRET=your_api_secret
```

### Pros:
- Easy setup
- Generous free tier
- Automatic optimization
- CDN included

### Cons:
- Mainly for images/videos
- PDF support limited

---

## Recommended Setup for MyStudyMate

### For Development:
**Use Local Storage** (Option 1)
- Quick to setup
- No costs
- Good for testing

### For Production:
**Use AWS S3** (Option 2)
- Most reliable
- Scalable
- Industry standard
- Cost: ~$0.023/GB/month

---

## Quick Start: Local Storage

I'll implement this now - it's the fastest way to get started!

### Files will be stored at:
```
backend/
  uploads/
    notes/
    books/
    tests/
    ppts/
    projects/
    assignments/
```

### Access URLs:
```
http://localhost:3000/uploads/notes/file.pdf
http://localhost:3000/uploads/books/book.pdf
```

Ready to implement? I'll create the upload system now!
