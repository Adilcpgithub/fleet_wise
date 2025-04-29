import 'dart:developer';
import 'dart:io';
import 'package:fleet_wise/models/profit_loss/today_model.dart';
import 'package:fleet_wise/providers/pnl_providers/today_pnl_bloc/today_pnl_event.dart';
import 'package:fleet_wise/providers/pnl_providers/today_pnl_bloc/today_pnl_state.dart';
import 'package:fleet_wise/services/local_storage_service.dart';
import 'package:fleet_wise/services/profi_loss_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodayPnLBloc extends Bloc<TodayPnLEvent, TodayPnLState> {
  final ProfitLossService profilLossService = ProfitLossService();

  TodayPnLBloc() : super(TodayPnLInitial()) {
    on<FetchTodayPnLEvent>(_onFetchTodayPnL);
  }

  Future<void> _onFetchTodayPnL(
    FetchTodayPnLEvent event,
    Emitter<TodayPnLState> emit,
  ) async {
    emit(TodayPnLLoading());

    try {
      log('fetching todays  ');
      // 1️ Use local cache if requested
      if (event.useCache) {
        log(' Fetching TodayPnL from local storage...');
        log('1111111111111111111111111111111111111111');
        final localData = await LocalStorageService.getTodayPnLData();
        if (localData != null && localData.isNotEmpty) {
          log(' Found TodayPnL in local storage.');
          log('222222222222222222222222222222222222');
          final todayPnL = PnLModel.fromJson(localData);
          emit(TodayPnLLoaded(todayPnL: todayPnL));
          log('33333333333333333333333333333333');
          return;
        } else {
          log('444444444444444444444444444444444444');
          log('❌ No TodayPnL in local storage.');
        }
      }

      // 2️ Fetch from API
      log(' Fetching TodayPnL from API...');
      log('55555555555555555555555555555');
      final data = await profilLossService.getTodayPnL();
      final todayPnL = PnLModel.fromJson(data);
      log('66666666666666666666666666666');
      if (todayPnL.vehicles.isNotEmpty) {
        emit(TodayPnLError(message: 'No internet Connection'));
      }
      // 3️ Save to local
      await LocalStorageService.saveTodayPnLData(data);
      log(' TodayPnL saved to local storage.');
      log('777777777777777777777777777');

      emit(TodayPnLLoaded(todayPnL: todayPnL));
      log('88888888888888888888888888888');
    } on SocketException catch (_) {
      // 4️ Network is OFF, try cache fallback
      log(' No Internet Connection. Trying local fallback...');
      log('999999999999999999999999999999999999999');
      final localData = await LocalStorageService.getTodayPnLData();
      if (localData != null && localData.isNotEmpty) {
        log('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
        final todayPnL = PnLModel.fromJson(localData);
        emit(TodayPnLLoaded(todayPnL: todayPnL));
        log('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb');
      } else {
        log('ccccccccccccccccccccccccccccccccccccc');
        emit(TodayPnLError(message: 'No internet and no cached data found.'));
      }
    } catch (e) {
      log('dddddddddddddddddddddddddddddddddddd');
      // 5️ Any other unexpected error
      log('❗ Unexpected error in TodayPnL fetch: $e');
      emit(TodayPnLError(message: e.toString()));
    }
  }
}
