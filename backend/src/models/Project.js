const mongoose = require('mongoose');

const projectSchema = new mongoose.Schema({
  category: {
    type: String,
    required: true,
    enum: ['College', 'School', 'Competitive']
  },
  course: {
    type: String,
    required: true
  },
  type: {
    type: String,
    required: true,
    enum: ['Mini Project', 'Major Project', 'Semester Project']
  },
  subject: {
    type: String,
    required: true
  },
  title: {
    type: String,
    required: true
  },
  fileUrl: String,
  isFree: {
    type: Boolean,
    default: true
  },
  price: {
    type: Number,
    default: 0
  },
  createdAt: {
    type: Date,
    default: Date.now
  }
});

module.exports = mongoose.model('Project', projectSchema);
