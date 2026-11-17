import 'package:flutter/material.dart';
import '../services/project_service.dart';
import '../models/project_model.dart';
import 'project_details_screen.dart'; 
import 'statistics_screen.dart'; 

class ProjectListScreen extends StatefulWidget {
  @override
  _ProjectListScreenState createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  final ProjectService _projectService = ProjectService();
  List<Project> _projects = [];
  List<Project> _filteredProjects = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    try {
      List<Project> projects = await _projectService.fetchProjects();
      setState(() {
        _projects = projects;
        _filteredProjects = projects;
      });
    } catch (e) {
      print("Error loading projects: $e");
    }
  }

  void _searchProjects(String query) {
    setState(() {
      _filteredProjects = _projects
          .where((project) => project.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 99, 216),
        elevation: 0,
        title: Text(
          'Project Management',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    style: TextStyle(color: Colors.black), // ✅ Search text is black
                    decoration: InputDecoration(
                      labelText: 'Search Projects',
                      labelStyle: TextStyle(color: Colors.blue.shade900),
                      prefixIcon: Icon(Icons.search, color: Colors.blue.shade700),
                      filled: true,
                      fillColor: Colors.blue.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: _searchProjects,
                  ),
                ),
                SizedBox(width: 10), // Space between search bar and icon
                IconButton(
                  icon: Icon(Icons.bar_chart, color: Colors.blue.shade700, size: 30),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StatisticsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredProjects.length,
              itemBuilder: (context, index) {
                final project = _filteredProjects[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProjectDetailsScreen(project: project),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue.shade700, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                project.name,
                                style: TextStyle(color: Colors.blue.shade900, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Site: ${project.site}",
                                style: TextStyle(color: Colors.blue.shade700, fontSize: 14),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Division: ${project.division}",
                                style: TextStyle(color: Colors.blue.shade500, fontSize: 14, fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.blue.shade900),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
