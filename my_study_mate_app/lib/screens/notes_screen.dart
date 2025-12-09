import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'chapter_detail_screen.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _selectedCollegeCourse;
  String? _selectedSchoolClass;
  String? _selectedCompetitiveExam;
  String _searchQuery = '';

  final List<String> _collegeCourses = ['BCA', 'BBA', 'BCom', 'BA', 'BSc'];
  final List<String> _schoolClasses = ['Class 12', 'Class 11', 'Class 10', 'Class 9', 'Class 8'];
  final List<String> _competitiveExams = ['SSC', 'Banking', 'Railway', 'CUET', 'TET'];

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
              hintText: 'Search notes...',
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
              _buildCollegeNotes(),
              _buildSchoolNotes(),
              _buildCompetitiveNotes(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCollegeNotes() {
    Map<String, List<Map<String, String>>> courseSubjects = {};

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: DropdownButtonFormField<String>(
            value: _selectedCollegeCourse,
            decoration: InputDecoration(
              labelText: 'Select Course',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.school),
            ),
            items: _collegeCourses.map((course) {
              return DropdownMenuItem(value: course, child: Text(course));
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCollegeCourse = value;
              });
            },
          ),
        ),
        Expanded(
          child: Builder(
            builder: (context) {
              final subjects = courseSubjects[_selectedCollegeCourse] ?? [];
              final filtered = subjects.where((s) => 
                s['name']!.toLowerCase().contains(_searchQuery)
              ).toList();
              if (filtered.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 64, color: AppColors.gray),
                      const SizedBox(height: 16),
                      Text('Sorry, no notes found', style: TextStyle(fontSize: 18, color: AppColors.gray)),
                    ],
                  ),
                );
              }
              return ListView(
                padding: const EdgeInsets.all(16),
                children: filtered.map((subject) => 
                  _buildNoteCard(subject['name']!, subject['chapters']!)
                ).toList(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSchoolNotes() {
    Map<String, List<Map<String, String>>> classSubjects = {};

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: DropdownButtonFormField<String>(
            value: _selectedSchoolClass,
            decoration: InputDecoration(
              labelText: 'Select Class',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.class_),
            ),
            items: _schoolClasses.map((cls) {
              return DropdownMenuItem(value: cls, child: Text(cls));
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedSchoolClass = value;
              });
            },
          ),
        ),
        Expanded(
          child: Builder(
            builder: (context) {
              final subjects = classSubjects[_selectedSchoolClass] ?? [];
              final filtered = subjects.where((s) => 
                s['name']!.toLowerCase().contains(_searchQuery)
              ).toList();
              if (filtered.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 64, color: AppColors.gray),
                      const SizedBox(height: 16),
                      Text('Sorry, no notes found', style: TextStyle(fontSize: 18, color: AppColors.gray)),
                    ],
                  ),
                );
              }
              return ListView(
                padding: const EdgeInsets.all(16),
                children: filtered.map((subject) => 
                  _buildNoteCard(subject['name']!, subject['chapters']!)
                ).toList(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCompetitiveNotes() {
    Map<String, List<Map<String, String>>> examSubjects = {};

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: DropdownButtonFormField<String>(
            value: _selectedCompetitiveExam,
            decoration: InputDecoration(
              labelText: 'Select Exam',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: const Icon(Icons.emoji_events),
            ),
            items: _competitiveExams.map((exam) {
              return DropdownMenuItem(value: exam, child: Text(exam));
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCompetitiveExam = value;
              });
            },
          ),
        ),
        Expanded(
          child: Builder(
            builder: (context) {
              final subjects = examSubjects[_selectedCompetitiveExam] ?? [];
              final filtered = subjects.where((s) => 
                s['name']!.toLowerCase().contains(_searchQuery)
              ).toList();
              if (filtered.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off, size: 64, color: AppColors.gray),
                      const SizedBox(height: 16),
                      Text('Sorry, no notes found', style: TextStyle(fontSize: 18, color: AppColors.gray)),
                    ],
                  ),
                );
              }
              return ListView(
                padding: const EdgeInsets.all(16),
                children: filtered.map((subject) => 
                  _buildNoteCard(subject['name']!, subject['chapters']!)
                ).toList(),
              );
            },
          ),
        ),
      ],
    );
  }



  Widget _buildNoteCard(String subject, String chapters) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.note, color: AppColors.primary),
        ),
        title: Text(
          subject,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text('$chapters Chapters • Updated today'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChapterDetailScreen(
                subject: subject,
                totalChapters: int.parse(chapters),
              ),
            ),
          );
        },
      ),
    );
  }
}
