//! Vihicle Data Model
class VehicleData {
  final double earning;
  final double costing;

  VehicleData({required this.earning, required this.costing});

  factory VehicleData.fromJson(Map<String, dynamic> json) {
    return VehicleData(
      earning: (json['earning'] ?? 0.0).toDouble(),
      costing: (json['costing'] ?? 0.0).toDouble(),
    );
  }
}
