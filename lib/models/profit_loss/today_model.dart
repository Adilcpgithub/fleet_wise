//! TodayPnLModel Model
import 'package:fleet_wise/models/profit_loss/header_data_model.dart';
import 'package:fleet_wise/models/profit_loss/vehicle_data_model.dart';

class PnLModel {
  final List<VehicleData> vehicles;
  final HeaderData header;

  PnLModel({required this.vehicles, required this.header});

  factory PnLModel.fromJson(Map<String, dynamic> json) {
    final vehiclesJson = json['vehicles'] as List<dynamic>? ?? [];
    final headerJson = json['header'] as Map<String, dynamic>?; // 🔥 Safe cast
    return PnLModel(
      vehicles: vehiclesJson.map((v) => VehicleData.fromJson(v)).toList(),
      header:
          headerJson != null
              ? HeaderData.fromJson(headerJson)
              : HeaderData.empty(),
    );
  }
}
