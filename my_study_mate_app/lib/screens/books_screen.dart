import 'package:flutter/material.dart';
import '../utils/colors.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: AppColors.white,
          child: TextField(
            onChanged: (value) {
              setState(() {
                _searchQuery = value.toLowerCase();
              });
            },
            decoration: InputDecoration(
              hintText: 'Search books...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        Container(
          color: AppColors.white,
          child: TabBar(
            controller: _tabController,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.gray,
            indicatorColor: AppColors.primary,
            tabs: const [
              Tab(text: 'College'),
              Tab(text: 'School'),
              Tab(text: 'Competitive'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildCollegeBooks(),
              _buildSchoolBooks(),
              _buildCompetitiveBooks(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCollegeBooks() {
    final books = <Map<String, dynamic>>[];
    
    final filtered = books.where((book) => 
      (book['title'] as String).toLowerCase().contains(_searchQuery) ||
      (book['author'] as String).toLowerCase().contains(_searchQuery) ||
      (book['subject'] as String).toLowerCase().contains(_searchQuery)
    ).toList();
    
    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: AppColors.gray),
            const SizedBox(height: 16),
            Text('Sorry, no books found', style: TextStyle(fontSize: 18, color: AppColors.gray)),
          ],
        ),
      );
    }
    
    return GridView.count(
      padding: const EdgeInsets.all(12),
      crossAxisCount: 2,
      childAspectRatio: 0.68,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: filtered.map((book) => 
        _buildBookCard(book['title'] as String, book['author'] as String, book['subject'] as String, book['price'] as String, book['isFree'] == true)
      ).toList(),
    );
  }

  Widget _buildSchoolBooks() {
    final books = <Map<String, dynamic>>[];
    
    final filtered = books.where((book) => 
      (book['title'] as String).toLowerCase().contains(_searchQuery) ||
      (book['author'] as String).toLowerCase().contains(_searchQuery) ||
      (book['subject'] as String).toLowerCase().contains(_searchQuery)
    ).toList();
    
    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: AppColors.gray),
            const SizedBox(height: 16),
            Text('Sorry, no books found', style: TextStyle(fontSize: 18, color: AppColors.gray)),
          ],
        ),
      );
    }
    
    return GridView.count(
      padding: const EdgeInsets.all(12),
      crossAxisCount: 2,
      childAspectRatio: 0.68,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: filtered.map((book) => 
        _buildBookCard(book['title'] as String, book['author'] as String, book['subject'] as String, book['price'] as String, book['isFree'] == true)
      ).toList(),
    );
  }

  Widget _buildCompetitiveBooks() {
    final books = <Map<String, dynamic>>[];
    
    final filtered = books.where((book) => 
      (book['title'] as String).toLowerCase().contains(_searchQuery) ||
      (book['author'] as String).toLowerCase().contains(_searchQuery) ||
      (book['subject'] as String).toLowerCase().contains(_searchQuery)
    ).toList();
    
    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: AppColors.gray),
            const SizedBox(height: 16),
            Text('Sorry, no books found', style: TextStyle(fontSize: 18, color: AppColors.gray)),
          ],
        ),
      );
    }
    
    return GridView.count(
      padding: const EdgeInsets.all(12),
      crossAxisCount: 2,
      childAspectRatio: 0.68,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: filtered.map((book) => 
        _buildBookCard(book['title'] as String, book['author'] as String, book['subject'] as String, book['price'] as String, book['isFree'] == true)
      ).toList(),
    );
  }

  Widget _buildBookCard(String title, String author, String subject, String price, bool isFree) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.secondary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                  ),
                  child: const Center(
                    child: Icon(Icons.book, size: 45, color: Colors.white),
                  ),
                ),
                if (isFree)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('FREE', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12), maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Text(author, style: const TextStyle(color: AppColors.gray, fontSize: 10)),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(price, style: TextStyle(color: isFree ? Colors.green : AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold)),
                      if (!isFree)
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)),
                            child: const Text('Buy', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
