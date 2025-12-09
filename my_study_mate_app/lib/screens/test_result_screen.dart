import 'package:flutter/material.dart';
import '../utils/colors.dart';

class TestResultScreen extends StatelessWidget {
  final String testTitle;
  final int totalQuestions;
  final int correctAnswers;
  final int timeTaken;

  const TestResultScreen({
    super.key,
    required this.testTitle,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.timeTaken,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (correctAnswers / totalQuestions * 100).toStringAsFixed(1);
    final passed = correctAnswers / totalQuestions >= 0.4;
    final minutes = timeTaken ~/ 60;
    final seconds = timeTaken % 60;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Result'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(
              passed ? Icons.check_circle : Icons.cancel,
              size: 100,
              color: passed ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 24),
            Text(
              passed ? 'Congratulations!' : 'Keep Trying!',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              testTitle,
              style: const TextStyle(fontSize: 18, color: AppColors.gray),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary.withOpacity(0.1), AppColors.secondary.withOpacity(0.1)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    '$percentage%',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: passed ? Colors.green : Colors.red,
                    ),
                  ),
                  const Text('Score', style: TextStyle(color: AppColors.gray)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildStatCard('Total Questions', totalQuestions.toString(), Icons.quiz),
            const SizedBox(height: 12),
            _buildStatCard('Correct Answers', correctAnswers.toString(), Icons.check_circle, Colors.green),
            const SizedBox(height: 12),
            _buildStatCard('Wrong Answers', (totalQuestions - correctAnswers).toString(), Icons.cancel, Colors.red),
            const SizedBox(height: 12),
            _buildStatCard('Time Taken', '${minutes}m ${seconds}s', Icons.timer),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                child: const Text('Back to Tests'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, [Color? color]) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.light),
      ),
      child: Row(
        children: [
          Icon(icon, color: color ?? AppColors.primary, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Text(label, style: const TextStyle(fontSize: 16, color: AppColors.gray)),
          ),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color ?? AppColors.dark)),
        ],
      ),
    );
  }
}
