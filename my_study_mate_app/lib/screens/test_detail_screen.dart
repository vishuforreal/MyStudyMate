import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'test_taking_screen.dart';

class TestDetailScreen extends StatelessWidget {
  final String testTitle;
  final String subject;
  final int questions;
  final int duration;

  const TestDetailScreen({
    super.key,
    required this.testTitle,
    required this.subject,
    required this.questions,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    testTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subject,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildInfoCard('Total Questions', '$questions', Icons.quiz),
            _buildInfoCard('Duration', '$duration mins', Icons.timer),
            _buildInfoCard('Total Marks', '$questions', Icons.star),
            _buildInfoCard('Passing Marks', '${(questions * 0.4).toInt()}', Icons.check_circle),
            const SizedBox(height: 24),
            const Text(
              'Instructions:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildInstruction('Each question carries 1 mark'),
            _buildInstruction('No negative marking'),
            _buildInstruction('You can review and change answers'),
            _buildInstruction('Submit test before time ends'),
            _buildInstruction('Results will be shown immediately'),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Sample questions for demo
                  final sampleQuestions = List.generate(
                    questions,
                    (i) => {
                      'question': 'Sample Question ${i + 1}?',
                      'options': ['Option A', 'Option B', 'Option C', 'Option D'],
                      'correctAnswer': 0,
                    },
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TestTakingScreen(
                        testTitle: testTitle,
                        questions: sampleQuestions,
                        duration: duration,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Start Test',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary, size: 32),
        title: Text(label),
        trailing: Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildInstruction(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.check, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
