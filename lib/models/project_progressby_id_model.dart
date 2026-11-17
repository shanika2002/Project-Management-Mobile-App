class ProjectProgress {
  final int pid;
  final int progId;
  final String date;
  final double progress;

  ProjectProgress({
    required this.pid,
    required this.progId,
    required this.date,
    required this.progress,
  });

  factory ProjectProgress.fromJson(Map<String, dynamic> json) {
    return ProjectProgress(
      pid: json['PID'] ?? 0,
      progId: json['ProgID'] ?? 0,
      date: json['DATE'] ?? '',
      progress: double.tryParse(json['Progress']?.toString() ?? '0.0') ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PID': pid,
      'ProgID': progId,
      'DATE': date,
      'Progress': progress,
    };
  }
}
