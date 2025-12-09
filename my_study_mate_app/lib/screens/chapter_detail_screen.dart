import 'package:flutter/material.dart';
import '../utils/colors.dart';

class ChapterDetailScreen extends StatelessWidget {
  final String subject;
  final int totalChapters;

  const ChapterDetailScreen({
    super.key,
    required this.subject,
    required this.totalChapters,
  });

  @override
  Widget build(BuildContext context) {
    final chapters = List.generate(totalChapters, (index) {
      final chapterNum = index + 1;
      final isFree = chapterNum <= 3;
      return {
        'number': chapterNum,
        'title': 'Chapter $chapterNum',
        'description': 'Introduction to ${subject} - Part $chapterNum',
        'isFree': isFree,
        'price': isFree ? 'Free' : '₹${29 + (chapterNum * 5)}',
      };
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(subject),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: chapters.length,
        itemBuilder: (context, index) {
          final chapter = chapters[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: chapter['isFree'] == true ? Colors.green.withOpacity(0.1) : AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    '${chapter['number']}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: chapter['isFree'] == true ? Colors.green : AppColors.primary,
                    ),
                  ),
                ),
              ),
              title: Text(
                chapter['title'] as String,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(chapter['description'] as String),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (chapter['isFree'] == true)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text('FREE', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        )
                      else
                        Text(
                          chapter['price'] as String,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              trailing: chapter['isFree'] == true
                  ? IconButton(
                      icon: const Icon(Icons.play_circle_filled, color: Colors.green, size: 32),
                      onPressed: () {},
                    )
                  : ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      child: const Text('Buy', style: TextStyle(fontSize: 11)),
                    ),
            ),
          );
        },
      ),
    );
  }
}
