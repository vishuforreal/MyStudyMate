import 'package:flutter/material.dart';
import '../utils/colors.dart';

class AdminManagementScreen extends StatefulWidget {
  const AdminManagementScreen({super.key});

  @override
  State<AdminManagementScreen> createState() => _AdminManagementScreenState();
}

class _AdminManagementScreenState extends State<AdminManagementScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Management'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Users'),
            Tab(text: 'Admins'),
            Tab(text: 'Categories'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _UsersTab(),
          _AdminsTab(),
          _CategoriesTab(),
        ],
      ),
    );
  }
}

class _UsersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildUserCard('John Doe', 'john@example.com', 'BCA', false, true),
        _buildUserCard('Jane Smith', 'jane@example.com', 'BBA', true, false),
      ],
    );
  }

  Widget _buildUserCard(String name, String email, String course, bool isBlocked, bool hasAccess) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: CircleAvatar(child: Text(name[0])),
        title: Text(name),
        subtitle: Text('$email • $course'),
        trailing: isBlocked ? const Chip(label: Text('Blocked'), backgroundColor: Colors.red) : null,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Notes Access'),
                  value: hasAccess,
                  onChanged: (v) {},
                ),
                SwitchListTile(
                  title: const Text('Books Access'),
                  value: hasAccess,
                  onChanged: (v) {},
                ),
                SwitchListTile(
                  title: const Text('Tests Access'),
                  value: hasAccess,
                  onChanged: (v) {},
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(isBlocked ? Icons.check : Icons.block),
                        label: Text(isBlocked ? 'Unblock' : 'Block'),
                        style: ElevatedButton.styleFrom(backgroundColor: isBlocked ? Colors.green : Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AdminsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            onPressed: () => _showAddAdminDialog(context),
            icon: const Icon(Icons.add),
            label: const Text('Add New Admin'),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildAdminCard('Super Admin', 'admin@mystudymate.com', true),
              _buildAdminCard('John Admin', 'johnadmin@example.com', false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAdminCard(String name, String email, bool isSuperAdmin) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isSuperAdmin ? Colors.amber : AppColors.primary,
          child: Icon(isSuperAdmin ? Icons.star : Icons.admin_panel_settings, color: Colors.white),
        ),
        title: Text(name),
        subtitle: Text(email),
        trailing: isSuperAdmin
            ? const Chip(label: Text('Super Admin'), backgroundColor: Colors.amber)
            : IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {},
              ),
      ),
    );
  }

  void _showAddAdminDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Admin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(decoration: const InputDecoration(labelText: 'Name')),
            TextField(decoration: const InputDecoration(labelText: 'Email')),
            TextField(decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            TextField(decoration: const InputDecoration(labelText: 'Phone')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Add')),
        ],
      ),
    );
  }
}

class _CategoriesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            onPressed: () => _showAddCategoryDialog(context),
            icon: const Icon(Icons.add),
            label: const Text('Add Category'),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildCategoryCard('BCA', 'College', ['Semester 1', 'Semester 2', 'Semester 3']),
              _buildCategoryCard('Class 12', 'School', ['Science', 'Commerce', 'Arts']),
              _buildCategoryCard('SSC', 'Competitive', ['CGL', 'CHSL', 'MTS']),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(String name, String type, List<String> courses) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: const Icon(Icons.category),
        title: Text(name),
        subtitle: Text(type),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Courses:', style: TextStyle(fontWeight: FontWeight.bold)),
                ...courses.map((c) => Chip(label: Text(c))),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: OutlinedButton(onPressed: () {}, child: const Text('Edit'))),
                    const SizedBox(width: 8),
                    Expanded(child: ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text('Delete'))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(decoration: const InputDecoration(labelText: 'Category Name')),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Type'),
              items: ['College', 'School', 'Competitive'].map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
              onChanged: (v) {},
            ),
            TextField(decoration: const InputDecoration(labelText: 'Courses (comma separated)')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Add')),
        ],
      ),
    );
  }
}
