const mongoose = require('mongoose');

const assignmentSchema = new mongoose.Schema({
  category: {
    type: String,
    required: true,
    enum: ['College', 'School', 'Competitive']
  },
  course: {
    type: String,
    required: true
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

module.exports = mongoose.model('Assignment', assignmentSchema);
