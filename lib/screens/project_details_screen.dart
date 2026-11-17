import 'package:flutter/material.dart';
import '../models/project_model.dart';
import '../models/project_progressby_id_model.dart';
import '../services/project_progressby_id_service.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final Project project;

  ProjectDetailsScreen({required this.project});

  @override
  _ProjectDetailsScreenState createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  late Future<List<ProjectProgress>> _futureProjectProgress;

  @override
  void initState() {
    super.initState();
    _futureProjectProgress = ProjectProgressByIdService().fetchProjectProgressById(widget.project.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text(
          'Project Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.project.name.isNotEmpty ? widget.project.name : "N/A",
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              _buildProjectField('ID', widget.project.id),
              _buildProjectField('Site', widget.project.site),
              _buildProjectField('Description', widget.project.description),
              _buildProjectField('Department', widget.project.department),
              _buildProjectField('Contractor', widget.project.contractor),
              _buildProjectField('Construction Period', widget.project.constructionPeriod),
              _buildProjectField('Contract Price', widget.project.contractPrice),
              _buildProjectField('Start Date', widget.project.startDate),
              _buildProjectField('End Date', widget.project.endDate),
              _buildProjectField('Award Date', widget.project.awardDate),
              _buildProjectField('Completion Date', widget.project.completionDate),
              _buildProjectField('Total Estimated Cost', widget.project.totalEstiCost),
              _buildProjectField('Status', widget.project.status),

              SizedBox(height: 20),
              _buildProgressSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectField(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: Colors.blue.shade700, size: 16),
          SizedBox(width: 4),
          Expanded(
            child: Text(
              "$label: ${value != null && value.isNotEmpty ? value : 'N/A'}",
              style: TextStyle(
                color: Colors.blue.shade900,
                fontSize: 14,
              ),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }

  /// **🔹 Displays Project Progress by ID**
  Widget _buildProgressSection() {
    return FutureBuilder<List<ProjectProgress>>(
      future: _futureProjectProgress,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: Colors.blue.shade700));
        } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No project progress data available"));
        }

        final progressList = snapshot.data!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Project Progress by ID",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(height: 10),
            Column(
              children: progressList.map((progress) {
                return Card(
                  color: Colors.blue.shade50,
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: Icon(Icons.timeline, color: Colors.blue.shade700),
                    title: Text(
                      "Progress: ${progress.progress}%",
                      style: TextStyle(color: Colors.blue.shade900, fontSize: 14),
                    ),
                    subtitle: Text("Date: ${progress.date}"),
                    trailing: Text("ID: ${progress.progId}"),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
