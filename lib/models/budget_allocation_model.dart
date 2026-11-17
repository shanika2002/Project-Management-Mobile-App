class BudgetAllocationModel {
  final int year;
  final double budgetAllocation;

  BudgetAllocationModel({required this.year, required this.budgetAllocation});

  factory BudgetAllocationModel.fromJson(Map<String, dynamic> json) {
    return BudgetAllocationModel(
      year: json['Year'] ?? 0,
      budgetAllocation: double.tryParse(json['BudgetAllocation'] ?? "0") ?? 0.0,
    );
  }
}
