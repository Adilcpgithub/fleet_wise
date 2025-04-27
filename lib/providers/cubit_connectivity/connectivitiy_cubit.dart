import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectivityCubit extends Cubit<bool> {
  final Connectivity _connectivity = Connectivity();

  ConnectivityCubit() : super(true) {
    // Initial connectivity check
    checkConnectivity();

    // Listen for connectivity changes
    _connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      log(results.toString());
      emit(_hasInternet(results));
    });
  }

  Future<void> checkConnectivity() async {
    final results = await _connectivity.checkConnectivity();
    emit(_hasInternet(results));
  }

  bool _hasInternet(List<ConnectivityResult> results) {
    // If the list contains mobile or wifi, then there's internet
    return results.contains(ConnectivityResult.mobile) ||
        results.contains(ConnectivityResult.wifi) ||
        results.contains(ConnectivityResult.ethernet) ||
        results.contains(ConnectivityResult.vpn);
  }
}
