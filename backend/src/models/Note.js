const mongoose = require('mongoose');

const noteSchema = new mongoose.Schema({
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
  unit: {
    type: Number,
    required: true
  },
  chapter: {
    type: Number,
    required: true
  },
  notesFileUrl: String,
  questionsFileUrl: String,
  answersFileUrl: String,
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

module.exports = mongoose.model('Note', noteSchema);
