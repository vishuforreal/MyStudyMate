import 'package:flutter/material.dart';
import '../utils/colors.dart';

class MyPurchasesScreen extends StatelessWidget {
  const MyPurchasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildResourceCard(
          'Premium Subscription',
          'Active until Dec 31, 2025',
          '₹199/month',
          Icons.star,
          Colors.amber,
          true,
        ),
        _buildResourceCard(
          'BCA Notes Pack',
          'Acquired on Jan 15, 2024',
          '₹149',
          Icons.note,
          AppColors.primary,
          false,
        ),
        _buildResourceCard(
          'Data Structures Book',
          'Acquired on Jan 10, 2024',
          '₹99',
          Icons.book,
          Colors.green,
          false,
        ),
        _buildResourceCard(
          'C Programming PPT',
          'Acquired on Jan 5, 2024',
          '₹49',
          Icons.slideshow,
          Colors.orange,
          false,
        ),
        const SizedBox(height: 20),
        Center(
          child: TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.history),
            label: const Text('View All Resources History'),
          ),
        ),
      ],
    );
  }

  Widget _buildResourceCard(
    String title,
    String subtitle,
    String price,
    IconData icon,
    Color color,
    bool isActive,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (isActive)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Active',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.gray,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    price,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.download),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
