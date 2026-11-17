import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/project_statistics_service.dart';
import '../services/budget_service.dart';
import '../services/estimate_service.dart';
import '../models/project_statistics_model.dart';
import '../models/budget_allocation_model.dart';
import '../models/total_estimate_model.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  late Future<List<ProjectStatistics>> _futureStatistics;
  late Future<List<BudgetAllocationModel>> _futureBudgetAllocation;
  late Future<List<TotalEstimateModel>> _futureTotalEstimate;

  @override
  void initState() {
    super.initState();
    _futureStatistics = ProjectStatisticsService().fetchStatistics();
    _futureBudgetAllocation = BudgetService().fetchBudgets();
    _futureTotalEstimate = EstimateService().fetchTotalEstimate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text(
          'Project Statistics',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOverallProgress(),
            SizedBox(height: 20),
            _buildStatisticsList(),
            SizedBox(height: 20),
            _buildBudgetAndEstimateRow(), // ✅ Displays Total Budget & Total Estimate side by side
          ],
        ),
      ),
    );
  }

  /// ✅ **Overall Progress (Pie Chart)**
  Widget _buildOverallProgress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Overall Progress",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: MediaQuery.of(context).size.height * 0.25, // 1/4 of screen height
          child: PieChart(
            PieChartData(
              sections: _buildPieChartSections(),
              borderData: FlBorderData(show: false),
              sectionsSpace: 2,
              centerSpaceRadius: 30,
            ),
          ),
        ),
        SizedBox(height: 10),
        Center(
          child: Text(
            "Updated project progress",
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  /// ✅ **Pie Chart Data**
  List<PieChartSectionData> _buildPieChartSections() {
    return [
      PieChartSectionData(
        color: Colors.blue.shade700,
        value: 80,
        title: 'Completed',
        radius: 40,
        titleStyle: TextStyle(
          color: const Color.fromARGB(255, 0, 0, 0),
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      PieChartSectionData(
        color: Colors.blue.shade500,
        value: 60,
        title: 'Ongoing',
        radius: 40,
        titleStyle: TextStyle(
          color: const Color.fromARGB(255, 0, 0, 0),
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      PieChartSectionData(
        color: Colors.blue.shade300,
        value: 45,
        title: 'Pending',
        radius: 40,
        titleStyle: TextStyle(
          color: const Color.fromARGB(255, 0, 0, 0),
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    ];
  }

  /// ✅ **Site Wise Project Count**
  Widget _buildStatisticsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Site Wise Project Count",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
        ),
        FutureBuilder<List<ProjectStatistics>>(
          future: _futureStatistics,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(color: Colors.blue.shade700));
            } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No site statistics available"));
            }

            final stats = snapshot.data!;
            return ListView.builder(
              itemCount: stats.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = stats[index];
                return Card(
                  color: const Color.fromARGB(255, 98, 130, 151),
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.site,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 5, 35, 80),
                          ),
                        ),
                        Text(
                          item.count.toString(),
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  /// ✅ **Budget & Estimate Row**
  Widget _buildBudgetAndEstimateRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(child: _buildTotalBudgetSection()), // ✅ Left Side: Total Budget
          SizedBox(width: 10), // Space between sections
          Expanded(child: _buildTotalEstimateSection()), // ✅ Right Side: Total Estimate
        ],
      ),
    );
  }

  /// ✅ **Total Budget Section**
  Widget _buildTotalBudgetSection() {
    return FutureBuilder<List<BudgetAllocationModel>>(
      future: _futureBudgetAllocation,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _loadingContainer();
        } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return _errorContainer("Failed to load Total Budget");
        }

        final budgetData = snapshot.data!.first;
        return _buildInfoCard("Total Budget", "\$${budgetData.budgetAllocation.toStringAsFixed(2)}");
      },
    );
  }

  /// ✅ **Total Estimate Section**
  Widget _buildTotalEstimateSection() {
    return FutureBuilder<List<TotalEstimateModel>>(
      future: _futureTotalEstimate,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _loadingContainer();
        } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return _errorContainer("Failed to load Total Estimate");
        }

        final estimateData = snapshot.data!.first;
        return _buildInfoCard("Total Estimate", "\$${estimateData.totalEstimateCost.toStringAsFixed(2)}");
      },
    );
  }

  /// ✅ **Reusable Card UI for Total Budget & Estimate**
  Widget _buildInfoCard(String title, String value) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue.shade900)),
          SizedBox(height: 5),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
        ],
      ),
    );
  }

  Widget _loadingContainer() => Center(child: CircularProgressIndicator(color: Colors.blue.shade700));
  Widget _errorContainer(String message) => Center(child: Text(message));
}
