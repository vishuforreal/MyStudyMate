const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const connectDB = require('./config/database');

// Load env vars
dotenv.config();

// Connect to database
connectDB();

const app = express();

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use('/uploads', express.static('uploads'));

// Routes
app.use('/api/auth', require('./routes/auth'));
app.use('/api/users', require('./routes/users'));
app.use('/api/admin', require('./routes/admin'));
app.use('/api/notes', require('./routes/notes'));
app.use('/api/books', require('./routes/books'));
app.use('/api/tests', require('./routes/tests'));
app.use('/api/ppts', require('./routes/ppts'));
app.use('/api/projects', require('./routes/projects'));
app.use('/api/assignments', require('./routes/assignments'));
app.use('/api/upload', require('./routes/upload'));
app.use('/api', require('./routes/createAdmin'));

// Health check
app.get('/', (req, res) => {
  res.json({ 
    message: 'My Study Mate API',
    status: 'Running',
    version: '1.0.0'
  });
});

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
  console.log(`🚀 Server running on port ${PORT}`);
});
