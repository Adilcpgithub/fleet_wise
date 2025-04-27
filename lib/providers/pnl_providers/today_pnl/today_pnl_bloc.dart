import 'dart:developer';
import 'dart:io';

import 'package:fleet_wise/core/widgets/toast_message_custom.dart';
import 'package:fleet_wise/models/profit_loss/today_model.dart';
import 'package:fleet_wise/providers/pnl_providers/today_pnl/today_pnl_event.dart';
import 'package:fleet_wise/providers/pnl_providers/today_pnl/today_pnl_state.dart';
import 'package:fleet_wise/services/local_storage_service.dart';
import 'package:fleet_wise/services/profi_loss_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodayPnLBloc extends Bloc<TodayPnLEvent, TodayPnLState> {
  final ProfilLossService profilLossService = ProfilLossService();

  TodayPnLBloc() : super(TodayPnLInitial()) {
    on<FetchTodayPnLEvent>(_onFetchTodayPnL);
  }

  Future<void> _onFetchTodayPnL(
    FetchTodayPnLEvent event,
    Emitter<TodayPnLState> emit,
  ) async {
    emit(TodayPnLLoading());

    try {
      //! 1. Check Local Storage first

      if (event.useCache) {
        final localData = await LocalStorageService.getTodayPnLData();
        if (localData != null) {
          final todayPnL = TodayPnLModel.fromJson(localData);
          emit(TodayPnLLoaded(todayPnL: todayPnL));
        }
      }

      //! 2. Fetch fresh from API
      final data = await profilLossService.getTodayPnL();
      final todayPnL = TodayPnLModel.fromJson(data);
      // !3. Save fresh data to LocalStorage
      await LocalStorageService.saveTodayPnLData(data);
      emit(TodayPnLLoaded(todayPnL: todayPnL));
    } on SocketException catch (_) {
      //! Internet not available!
      log('No Internet Connection');

      final localData = await LocalStorageService.getTodayPnLData();
      if (localData != null) {
        final todayPnL = TodayPnLModel.fromJson(localData);
        emit(TodayPnLLoaded(todayPnL: todayPnL));
      } else {
        emit(
          const TodayPnLError(message: 'No internet and no cached data found.'),
        );
      }
    } catch (e) {
      log(e.toString());
      emit(TodayPnLError(message: e.toString()));
    }
  }
}
