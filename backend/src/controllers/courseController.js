// @desc    Get all courses
// @route   GET /api/courses
exports.getCourses = async (req, res) => {
  try {
    const courses = {
      college: ['BCA', 'BBA', 'BCom', 'BA', 'BSc'],
      school: ['Class 6', 'Class 7', 'Class 8', 'Class 9', 'Class 10', 'Class 11', 'Class 12'],
      competitive: ['SSC', 'Railway', 'Banking', 'CUET', 'TET', 'Police']
    };

    res.json({
      success: true,
      data: courses
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
