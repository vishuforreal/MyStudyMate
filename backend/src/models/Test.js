const mongoose = require('mongoose');

const testSchema = new mongoose.Schema({
  category: {
    type: String,
    required: true,
    enum: ['College', 'School', 'Competitive']
  },
  course: {
    type: String,
    required: true
  },
  title: {
    type: String,
    required: true
  },
  questions: [{
    question: String,
    options: [String],
    correctAnswer: Number
  }],
  duration: {
    type: Number,
    required: true
  },
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

module.exports = mongoose.model('Test', testSchema);
