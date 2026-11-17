class ProjectStatistics {
  final String site;
  final int count;

  ProjectStatistics({required this.site, required this.count});

  // Factory method to convert JSON into Dart Object
  factory ProjectStatistics.fromJson(Map<String, dynamic> json) {
    return ProjectStatistics(
      site: json['Site'] ?? "N/A",
      count: json['COUNT'] ?? 0,
    );
  }
}
