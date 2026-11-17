class Project {
  final String id;
  final String site;
  final String name;
  final String description;
  final String division;
  final String contractor;
  final String constructionPeriod;
  final String contractPrice;
  final String startDate;
  final String endDate;
  final String awardDate;
  final String completionDate;
  final String status;
  final String department;
  final String totalEstiCost;

  Project({
    required this.id,
    required this.site,
    required this.name,
    required this.description,
    required this.division,
    required this.contractor,
    required this.constructionPeriod,
    required this.contractPrice,
    required this.startDate,
    required this.endDate,
    required this.awardDate,
    required this.completionDate,
    required this.status,
    required this.department,
    required this.totalEstiCost
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['ID']?.toString() ?? "N/A",
      site: json['Site'] ?? "N/A",
      name: json['PDescription'] ?? "N/A",
      description: json['PDescription'] ?? "N/A",
      division: json['DName'] ?? "N/A",
      contractor: json['Contractor'] ?? "N/A",
      constructionPeriod: json['ConstructionPeriod'] ?? "N/A",
      contractPrice: json['ContractPrice']?.toString() ?? "N/A",
      startDate: json['StartDate'] ?? "N/A",
      endDate: json['EndDate'] ?? "N/A",
      awardDate: json['AwardDate'] ?? "N/A",
      completionDate: json['CompletionDate'] ?? "N/A",
      status: json['Status'] ?? "N/A",
      department: json['Department'] ?? "N/A",
      totalEstiCost: json['TotalEstiCost']?.toString() ?? "N/A"
    );
  }
}
