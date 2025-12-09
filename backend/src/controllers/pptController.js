const PPT = require('../models/PPT');

exports.getPPTs = async (req, res) => {
  try {
    const { category, course } = req.query;
    let query = {};
    if (category) query.category = category;
    if (course) query.course = course;
    const ppts = await PPT.find(query).sort('-createdAt');
    res.json({ success: true, count: ppts.length, data: ppts });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.getPPTById = async (req, res) => {
  try {
    const ppt = await PPT.findById(req.params.id);
    if (!ppt) return res.status(404).json({ message: 'PPT not found' });
    res.json({ success: true, data: ppt });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.createPPT = async (req, res) => {
  try {
    const ppt = await PPT.create(req.body);
    res.status(201).json({ success: true, data: ppt });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.updatePPT = async (req, res) => {
  try {
    const ppt = await PPT.findByIdAndUpdate(req.params.id, req.body, { new: true });
    if (!ppt) return res.status(404).json({ message: 'PPT not found' });
    res.json({ success: true, data: ppt });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.deletePPT = async (req, res) => {
  try {
    const ppt = await PPT.findByIdAndDelete(req.params.id);
    if (!ppt) return res.status(404).json({ message: 'PPT not found' });
    res.json({ success: true, message: 'PPT deleted' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
