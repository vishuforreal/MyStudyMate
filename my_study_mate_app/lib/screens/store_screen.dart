import 'package:flutter/material.dart';
import '../utils/colors.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final allItems = <Map<String, String>>[];

    final filtered = allItems.where((item) => 
      item['name']!.toLowerCase().contains(_searchQuery) ||
      item['category']!.toLowerCase().contains(_searchQuery)
    ).toList();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: AppColors.white,
          child: TextField(
            onChanged: (value) => setState(() => _searchQuery = value.toLowerCase()),
            decoration: InputDecoration(
              hintText: 'Search resources...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
        Expanded(
          child: filtered.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 64, color: AppColors.gray),
                      const SizedBox(height: 16),
                      Text('Sorry, no resources found', style: TextStyle(fontSize: 18, color: AppColors.gray)),
                    ],
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: filtered.map((item) => _buildStoreItem(item['name']!, item['price']!)).toList(),
                ),
        ),
      ],
    );
  }

  Widget _buildStoreItem(String name, String price) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.shopping_cart, color: AppColors.primary),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          price,
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        trailing: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          child: const Text('Get'),
        ),
      ),
    );
  }
}
