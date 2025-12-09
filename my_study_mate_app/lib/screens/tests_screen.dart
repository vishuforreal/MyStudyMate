import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'test_detail_screen.dart';

class TestsScreen extends StatefulWidget {
  const TestsScreen({super.key});

  @override
  State<TestsScreen> createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _selectedCollegeCourse;
  String? _selectedSchoolClass;
  String? _selectedCompetitiveExam;
  String _searchQuery = '';

  final List<String> _collegeCourses = ['BCA', 'BBA', 'BCom', 'BA', 'BSc'];
  final List<String> _schoolClasses = ['Class 12', 'Class 11', 'Class 10'];
  final List<String> _competitiveExams = ['SSC', 'Banking', 'Railway', 'CUET'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _selectedCollegeCourse = 'BCA';
    _selectedSchoolClass = 'Class 12';
    _selectedCompetitiveExam = 'SSC';
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
            onChanged: (value) => setState(() => _searchQuery = value.toLowerCase()),
            decoration: InputDecoration(
              hintText: 'Search tests...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
              _buildCollegeTests(),
              _buildSchoolTests(),
              _buildCompetitiveTests(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCollegeTests() {
    Map<String, List<Map<String, dynamic>>> courseTests = {};

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: DropdownButtonFormField<String>(
            value: _selectedCollegeCourse,
            decoration: InputDecoration(
              labelText: 'Select Course',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              prefixIcon: const Icon(Icons.school),
            ),
            items: _collegeCourses.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
            onChanged: (value) => setState(() => _selectedCollegeCourse = value),
          ),
        ),
        Expanded(
          child: Builder(
            builder: (context) {
              final tests = courseTests[_selectedCollegeCourse] ?? [];
              final filtered = tests.where((t) => 
                t['title'].toLowerCase().contains(_searchQuery) ||
                t['subtitle'].toLowerCase().contains(_searchQuery)
              ).toList();
              if (filtered.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 64, color: AppColors.gray),
                      const SizedBox(height: 16),
                      Text('Sorry, no tests found', style: TextStyle(fontSize: 18, color: AppColors.gray)),
                    ],
                  ),
                );
              }
              return ListView(
                padding: const EdgeInsets.all(16),
                children: filtered.map((test) {
                  return _buildTestCard(test['title'], test['subtitle'], test['questions'], test['time'], test['color'], test['price'], test['isFree']);
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSchoolTests() {
    final tests = <Map<String, dynamic>>[];
    final filtered = tests.where((t) => 
      (t['title'] as String).toLowerCase().contains(_searchQuery) ||
      (t['subtitle'] as String).toLowerCase().contains(_searchQuery)
    ).toList();
    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: AppColors.gray),
            const SizedBox(height: 16),
            Text('Sorry, no tests found', style: TextStyle(fontSize: 18, color: AppColors.gray)),
          ],
        ),
      );
    }
    return ListView(
      padding: const EdgeInsets.all(16),
      children: filtered.map((test) => _buildTestCard(test['title'] as String, test['subtitle'] as String, test['questions'] as String, test['time'] as String, test['color'] as Color, test['price'] as String, test['isFree'] as bool)).toList(),
    );
  }

  Widget _buildCompetitiveTests() {
    final tests = <Map<String, dynamic>>[];
    final filtered = tests.where((t) => 
      (t['title'] as String).toLowerCase().contains(_searchQuery) ||
      (t['subtitle'] as String).toLowerCase().contains(_searchQuery)
    ).toList();
    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: AppColors.gray),
            const SizedBox(height: 16),
            Text('Sorry, no tests found', style: TextStyle(fontSize: 18, color: AppColors.gray)),
          ],
        ),
      );
    }
    return ListView(
      padding: const EdgeInsets.all(16),
      children: filtered.map((test) => _buildTestCard(test['title'] as String, test['subtitle'] as String, test['questions'] as String, test['time'] as String, test['color'] as Color, test['price'] as String, test['isFree'] as bool)).toList(),
    );
  }

  Widget _buildTestCard(String title, String subtitle, String questions, String time, Color color, String price, bool isFree) {
    int questionCount = int.parse(questions.split(' ')[0]);
    int duration = int.parse(time.split(' ')[0]);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.quiz, color: color, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: const TextStyle(color: AppColors.gray, fontSize: 14)),
                    ],
                  ),
                ),
                if (isFree)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(8)),
                    child: const Text('FREE', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildInfoChip(Icons.question_answer, questions),
                const SizedBox(width: 8),
                _buildInfoChip(Icons.timer, time),
                const Spacer(),
                if (!isFree)
                  Text(price, style: const TextStyle(color: AppColors.primary, fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: isFree ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TestDetailScreen(
                          testTitle: title,
                          subject: subtitle,
                          questions: questionCount,
                          duration: duration,
                        ),
                      ),
                    );
                  } : () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    backgroundColor: isFree ? AppColors.primary : Colors.green,
                  ),
                  child: Text(isFree ? 'Start' : 'Buy', style: const TextStyle(fontSize: 11)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.light,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.gray),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(fontSize: 12, color: AppColors.gray)),
        ],
      ),
    );
  }
}
