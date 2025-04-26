//! TodayPnLModel Model
import 'package:fleet_wise/models/profit_loss/header_data_model.dart';
import 'package:fleet_wise/models/profit_loss/vehicle_data_model.dart';

class TodayPnLModel {
  final List<VehicleData> vehicles;
  final HeaderData header;

  TodayPnLModel({required this.vehicles, required this.header});

  factory TodayPnLModel.fromJson(Map<String, dynamic> json) {
    final vehiclesJson = json['vehicles'] as List<dynamic>;
    return TodayPnLModel(
      vehicles: vehiclesJson.map((v) => VehicleData.fromJson(v)).toList(),
      header: HeaderData.fromJson(json['header']),
    );
  }
}
