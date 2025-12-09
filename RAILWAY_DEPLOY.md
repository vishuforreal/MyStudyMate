# 🚀 Railway Deploy - FASTEST WAY

## Option 1: Auto-Import (EASIEST)

### Step 1: Install Railway CLI
```bash
npm i -g @railway/cli
```

### Step 2: Login
```bash
railway login
```

### Step 3: Deploy (Auto-imports .env)
```bash
cd backend
railway init
railway up
```

**Done!** Railway automatically reads your `.env` file! 🎉

---

## Option 2: Web UI (No CLI)

### Step 1: Push to GitHub
```bash
git add .
git commit -m "ready for deploy"
git push
```

### Step 2: Railway Dashboard
1. Go to https://railway.app
2. New Project → Deploy from GitHub
3. Select repo
4. Click "Variables" → "Raw Editor"
5. Paste entire .env content
6. Deploy!

---

## Option 3: Copy-Paste Variables

Just copy these to Railway:

```
PORT=3000
JWT_SECRET=your_super_secret_jwt_key_change_this_in_production
JWT_EXPIRE=7d
NODE_ENV=production
CLOUDINARY_CLOUD_NAME=dkisaaawx
CLOUDINARY_API_KEY=386444949138948
CLOUDINARY_API_SECRET=18TniHAise9awqQdhmhoLY600po
```

Railway adds `MONGODB_URI` automatically when you add MongoDB plugin.

---

## 🏆 RECOMMENDED: Option 1 (CLI)

**Why?**
- ✅ Fastest (1 command)
- ✅ Auto-imports .env
- ✅ No manual copying

**Time: 2 minutes** ⚡

Ready? Run:
```bash
npm i -g @railway/cli
railway login
cd backend
railway init
railway up
```

Done! 🚀
