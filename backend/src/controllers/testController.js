const Test = require('../models/Test');

// @desc    Get all tests
// @route   GET /api/tests
exports.getTests = async (req, res) => {
  try {
    const { category, course } = req.query;
    let query = {};
    if (category) query.category = category;
    if (course) query.course = course;
    const tests = await Test.find(query).sort('-createdAt');
    res.json({ success: true, count: tests.length, data: tests });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// @desc    Get single test
// @route   GET /api/tests/:id
exports.getTestById = async (req, res) => {
  try {
    const test = await Test.findById(req.params.id);
    if (!test) return res.status(404).json({ message: 'Test not found' });
    res.json({ success: true, data: test });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.createTest = async (req, res) => {
  try {
    const test = await Test.create(req.body);
    res.status(201).json({ success: true, data: test });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.updateTest = async (req, res) => {
  try {
    const test = await Test.findByIdAndUpdate(req.params.id, req.body, { new: true });
    if (!test) return res.status(404).json({ message: 'Test not found' });
    res.json({ success: true, data: test });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.deleteTest = async (req, res) => {
  try {
    const test = await Test.findByIdAndDelete(req.params.id);
    if (!test) return res.status(404).json({ message: 'Test not found' });
    res.json({ success: true, message: 'Test deleted' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// @desc    Submit test
// @route   POST /api/tests/:id/submit
exports.submitTest = async (req, res) => {
  try {
    const test = await Test.findById(req.params.id);
    
    if (!test) {
      return res.status(404).json({ message: 'Test not found' });
    }

    const { answers, timeTaken } = req.body;
    
    let correctAnswers = 0;
    test.questions.forEach((question, index) => {
      const userAnswer = answers.find(a => a.questionIndex === index);
      if (userAnswer && userAnswer.selectedAnswer === question.correctAnswer) {
        correctAnswers++;
      }
    });

    const totalQuestions = test.questions.length;
    const percentage = (correctAnswers / totalQuestions) * 100;
    const passed = percentage >= 40;

    const TestResult = require('../models/TestResult');
    const result = await TestResult.create({
      user: req.user.id,
      test: test._id,
      answers,
      score: correctAnswers,
      totalQuestions,
      correctAnswers,
      percentage,
      timeTaken,
      passed
    });

    res.json({
      success: true,
      data: {
        correctAnswers,
        totalQuestions,
        percentage,
        passed,
        timeTaken
      }
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// @desc    Get user test results
// @route   GET /api/tests/results
exports.getUserResults = async (req, res) => {
  try {
    const TestResult = require('../models/TestResult');
    const results = await TestResult.find({ user: req.user.id })
      .populate('test', 'title subject')
      .sort('-completedAt');
    
    res.json({
      success: true,
      count: results.length,
      data: results
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
