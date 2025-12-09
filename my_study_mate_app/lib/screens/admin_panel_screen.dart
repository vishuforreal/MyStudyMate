import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../utils/colors.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';
import 'admin_management_screen.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        actions: [
          IconButton(
            icon: const Icon(Icons.admin_panel_settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AdminManagementScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService.logout();
              if (!context.mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.gray,
          indicatorColor: AppColors.primary,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Notes'),
            Tab(text: 'Books'),
            Tab(text: 'Tests'),
            Tab(text: 'PPTs'),
            Tab(text: 'Projects'),
            Tab(text: 'Assignments'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _AddNotesTab(),
          _AddBooksTab(),
          _AddTestsTab(),
          _AddPPTsTab(),
          _AddProjectsTab(),
          _AddAssignmentsTab(),
        ],
      ),
    );
  }
}

class _AddNotesTab extends StatefulWidget {
  @override
  State<_AddNotesTab> createState() => _AddNotesTabState();
}

class _AddNotesTabState extends State<_AddNotesTab> {
  final _formKey = GlobalKey<FormState>();
  String _category = 'College';
  String _course = 'BCA';
  String _subject = '';
  String _unit = '';
  String _chapter = '';
  bool _isFree = true;
  String _price = '0';
  String? _notesFile;
  String? _questionsFile;
  String? _answersFile;

  final List<String> _categories = ['College', 'School', 'Competitive'];
  final Map<String, List<String>> _courses = {
    'College': ['BCA', 'BBA', 'BCom', 'BA', 'BSc'],
    'School': ['Class 12', 'Class 11', 'Class 10', 'Class 9', 'Class 8'],
    'Competitive': ['SSC', 'Banking', 'Railway', 'CUET', 'TET'],
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              value: _category,
              decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
              items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (value) => setState(() {
                _category = value!;
                _course = _courses[_category]!.first;
              }),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _course,
              decoration: const InputDecoration(labelText: 'Course/Class/Exam', border: OutlineInputBorder()),
              items: _courses[_category]!.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (value) => setState(() => _course = value!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Subject Name', border: OutlineInputBorder()),
              onChanged: (value) => _subject = value,
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Unit Number', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              onChanged: (value) => _unit = value,
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Chapter Number', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              onChanged: (value) => _chapter = value,
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            const Text('Upload Files:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
                if (result != null) setState(() => _notesFile = result.files.first.name);
              },
              icon: const Icon(Icons.upload_file),
              label: Text(_notesFile ?? 'Upload Notes PDF'),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
                if (result != null) setState(() => _questionsFile = result.files.first.name);
              },
              icon: const Icon(Icons.upload_file),
              label: Text(_questionsFile ?? 'Upload Questions PDF'),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
                if (result != null) setState(() => _answersFile = result.files.first.name);
              },
              icon: const Icon(Icons.upload_file),
              label: Text(_answersFile ?? 'Upload Answers PDF'),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Free Content'),
              value: _isFree,
              onChanged: (value) => setState(() => _isFree = value),
            ),
            if (!_isFree)
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price (₹)', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onChanged: (value) => _price = value,
              ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Note added: $_subject - Unit $_unit, Chapter $_chapter')),
                    );
                  }
                },
                child: const Text('Add Note'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddBooksTab extends StatefulWidget {
  @override
  State<_AddBooksTab> createState() => _AddBooksTabState();
}

class _AddBooksTabState extends State<_AddBooksTab> {
  final _formKey = GlobalKey<FormState>();
  String _category = 'College';
  String _subject = 'BCA';
  String _title = '';
  String _author = '';
  bool _isFree = true;
  String _price = '0';
  String? _bookFile;

  final List<String> _categories = ['College', 'School', 'Competitive'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _category,
              decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
              items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (value) => setState(() => _category = value!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Subject/Class', border: OutlineInputBorder()),
              onChanged: (value) => _subject = value,
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Book Title', border: OutlineInputBorder()),
              onChanged: (value) => _title = value,
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Author', border: OutlineInputBorder()),
              onChanged: (value) => _author = value,
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
                if (result != null) setState(() => _bookFile = result.files.first.name);
              },
              icon: const Icon(Icons.upload_file),
              label: Text(_bookFile ?? 'Upload Book PDF'),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Free Book'),
              value: _isFree,
              onChanged: (value) => setState(() => _isFree = value),
            ),
            if (!_isFree)
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price (₹)', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onChanged: (value) => _price = value,
              ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Book added: $_title by $_author')),
                    );
                  }
                },
                child: const Text('Add Book'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddTestsTab extends StatefulWidget {
  @override
  State<_AddTestsTab> createState() => _AddTestsTabState();
}

class _AddTestsTabState extends State<_AddTestsTab> {
  final _formKey = GlobalKey<FormState>();
  String _category = 'College';
  String _course = 'BCA';
  String _title = '';
  String _duration = '';
  bool _isFree = true;
  String _price = '0';
  String? _jsonFileName;

  final List<String> _categories = ['College', 'School', 'Competitive'];
  final Map<String, List<String>> _courses = {
    'College': ['BCA', 'BBA', 'BCom', 'BA', 'BSc'],
    'School': ['Class 12', 'Class 11', 'Class 10'],
    'Competitive': ['SSC', 'Banking', 'Railway', 'CUET'],
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _category,
              decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
              items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (value) => setState(() {
                _category = value!;
                _course = _courses[_category]!.first;
              }),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _course,
              decoration: const InputDecoration(labelText: 'Course/Class/Exam', border: OutlineInputBorder()),
              items: _courses[_category]!.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (value) => setState(() => _course = value!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Test Title', border: OutlineInputBorder()),
              onChanged: (value) => _title = value,
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['json']);
                if (result != null) {
                  setState(() => _jsonFileName = result.files.first.name);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected: ${result.files.first.name}')),
                  );
                }
              },
              icon: const Icon(Icons.upload_file),
              label: Text(_jsonFileName ?? 'Upload Questions JSON'),
            ),
            if (_jsonFileName != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text('Selected: $_jsonFileName', style: const TextStyle(color: Colors.green)),
              ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Duration (minutes)', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              onChanged: (value) => _duration = value,
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Free Test'),
              value: _isFree,
              onChanged: (value) => setState(() => _isFree = value),
            ),
            if (!_isFree)
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price (₹)', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onChanged: (value) => _price = value,
              ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Test added: $_title')),
                    );
                  }
                },
                child: const Text('Add Test'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddPPTsTab extends StatefulWidget {
  @override
  State<_AddPPTsTab> createState() => _AddPPTsTabState();
}

class _AddPPTsTabState extends State<_AddPPTsTab> {
  final _formKey = GlobalKey<FormState>();
  String _category = 'College';
  String _course = 'BCA';
  String _subject = '';
  String _title = '';
  bool _isFree = true;
  String _price = '0';
  String? _pptFile;

  final List<String> _categories = ['College', 'School', 'Competitive'];
  final Map<String, List<String>> _courses = {
    'College': ['BCA', 'BBA', 'BCom', 'BA', 'BSc'],
    'School': ['Class 12', 'Class 11', 'Class 10'],
    'Competitive': ['SSC', 'Banking', 'Railway', 'CUET'],
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _category,
              decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
              items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (value) => setState(() {
                _category = value!;
                _course = _courses[_category]!.first;
              }),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _course,
              decoration: const InputDecoration(labelText: 'Course/Class/Exam', border: OutlineInputBorder()),
              items: _courses[_category]!.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (value) => setState(() => _course = value!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Subject', border: OutlineInputBorder()),
              onChanged: (value) => _subject = value,
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'PPT Title', border: OutlineInputBorder()),
              onChanged: (value) => _title = value,
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['ppt', 'pptx', 'pdf']);
                if (result != null) setState(() => _pptFile = result.files.first.name);
              },
              icon: const Icon(Icons.upload_file),
              label: Text(_pptFile ?? 'Upload PPT File'),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Free PPT'),
              value: _isFree,
              onChanged: (value) => setState(() => _isFree = value),
            ),
            if (!_isFree)
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price (₹)', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onChanged: (value) => _price = value,
              ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('PPT added: $_title')),
                    );
                  }
                },
                child: const Text('Add PPT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddProjectsTab extends StatefulWidget {
  @override
  State<_AddProjectsTab> createState() => _AddProjectsTabState();
}

class _AddProjectsTabState extends State<_AddProjectsTab> {
  final _formKey = GlobalKey<FormState>();
  String _category = 'College';
  String _course = 'BCA';
  String _subject = '';
  String _title = '';
  String _type = 'Mini Project';
  bool _isFree = true;
  String _price = '0';
  String? _projectFile;

  final List<String> _categories = ['College', 'School', 'Competitive'];
  final List<String> _projectTypes = ['Mini Project', 'Major Project', 'Semester Project'];
  final Map<String, List<String>> _courses = {
    'College': ['BCA', 'BBA', 'BCom', 'BA', 'BSc'],
    'School': ['Class 12', 'Class 11', 'Class 10'],
    'Competitive': ['SSC', 'Banking', 'Railway', 'CUET'],
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _category,
              decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
              items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (value) => setState(() {
                _category = value!;
                _course = _courses[_category]!.first;
              }),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _course,
              decoration: const InputDecoration(labelText: 'Course/Class/Exam', border: OutlineInputBorder()),
              items: _courses[_category]!.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (value) => setState(() => _course = value!),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _type,
              decoration: const InputDecoration(labelText: 'Project Type', border: OutlineInputBorder()),
              items: _projectTypes.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
              onChanged: (value) => setState(() => _type = value!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Subject', border: OutlineInputBorder()),
              onChanged: (value) => _subject = value,
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Project Title', border: OutlineInputBorder()),
              onChanged: (value) => _title = value,
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['zip', 'rar']);
                if (result != null) setState(() => _projectFile = result.files.first.name);
              },
              icon: const Icon(Icons.upload_file),
              label: Text(_projectFile ?? 'Upload Project Files (ZIP)'),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Free Project'),
              value: _isFree,
              onChanged: (value) => setState(() => _isFree = value),
            ),
            if (!_isFree)
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price (₹)', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onChanged: (value) => _price = value,
              ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Project added: $_title')),
                    );
                  }
                },
                child: const Text('Add Project'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddAssignmentsTab extends StatefulWidget {
  @override
  State<_AddAssignmentsTab> createState() => _AddAssignmentsTabState();
}

class _AddAssignmentsTabState extends State<_AddAssignmentsTab> {
  final _formKey = GlobalKey<FormState>();
  String _category = 'College';
  String _course = 'BCA';
  String _subject = '';
  String _title = '';
  bool _isFree = true;
  String _price = '0';
  String? _assignmentFile;

  final List<String> _categories = ['College', 'School', 'Competitive'];
  final Map<String, List<String>> _courses = {
    'College': ['BCA', 'BBA', 'BCom', 'BA', 'BSc'],
    'School': ['Class 12', 'Class 11', 'Class 10'],
    'Competitive': ['SSC', 'Banking', 'Railway', 'CUET'],
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _category,
              decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
              items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (value) => setState(() {
                _category = value!;
                _course = _courses[_category]!.first;
              }),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _course,
              decoration: const InputDecoration(labelText: 'Course/Class/Exam', border: OutlineInputBorder()),
              items: _courses[_category]!.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (value) => setState(() => _course = value!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Subject', border: OutlineInputBorder()),
              onChanged: (value) => _subject = value,
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Assignment Title', border: OutlineInputBorder()),
              onChanged: (value) => _title = value,
              validator: (value) => value!.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'doc', 'docx']);
                if (result != null) setState(() => _assignmentFile = result.files.first.name);
              },
              icon: const Icon(Icons.upload_file),
              label: Text(_assignmentFile ?? 'Upload Assignment PDF'),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Free Assignment'),
              value: _isFree,
              onChanged: (value) => setState(() => _isFree = value),
            ),
            if (!_isFree)
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price (₹)', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                onChanged: (value) => _price = value,
              ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Assignment added: $_title')),
                    );
                  }
                },
                child: const Text('Add Assignment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
