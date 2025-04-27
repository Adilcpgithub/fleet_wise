//! Header Data  Model
class HeaderData {
  final int tripsCompleted;
  final int vehiclesOnRoad;
  final double totalDistance;
  final double profitOrLoss;

  HeaderData({
    required this.tripsCompleted,
    required this.vehiclesOnRoad,
    required this.totalDistance,
    required this.profitOrLoss,
  });

  factory HeaderData.fromJson(Map<String, dynamic> json) {
    return HeaderData(
      tripsCompleted: (json['trips_completed'] ?? 0),
      vehiclesOnRoad: (json['vehicles_on_road'] ?? 0),
      totalDistance: (json['total_distance'] ?? 0.0).toDouble(),
      profitOrLoss:
          (json['profit/loss'] ?? 0.0).toDouble(), //  Mapping profit/loss here
    );
  }
  //   this helper
  factory HeaderData.empty() {
    return HeaderData(
      tripsCompleted: 0,
      vehiclesOnRoad: 0,
      totalDistance: 0.0,
      profitOrLoss: 0.0,
    );
  }
}
