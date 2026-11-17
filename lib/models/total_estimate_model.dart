class TotalEstimateModel {
  final double totalEstimateCost;

  TotalEstimateModel({required this.totalEstimateCost});

  factory TotalEstimateModel.fromJson(Map<String, dynamic> json) {
    return TotalEstimateModel(
      totalEstimateCost: double.tryParse(json['TotalEstimateCost'] ?? "0") ?? 0.0,
    );
  }
}
