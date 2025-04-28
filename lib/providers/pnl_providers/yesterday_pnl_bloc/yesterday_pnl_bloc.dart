import 'dart:developer';
import 'dart:io';
import 'package:fleet_wise/models/profit_loss/today_model.dart';
import 'package:fleet_wise/providers/pnl_providers/yesterday_pnl_bloc/yesterday_pnl_event.dart';
import 'package:fleet_wise/providers/pnl_providers/yesterday_pnl_bloc/yesterday_pnl_state.dart';
import 'package:fleet_wise/services/local_storage_service.dart';
import 'package:fleet_wise/services/profi_loss_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YesterdayPnlBloc extends Bloc<YesterdayPnlEvent, YesterdayPnlState> {
  final ProfitLossService profilLossService = ProfitLossService();

  YesterdayPnlBloc() : super(YesterdayPnLInitial()) {
    on<FetchYesterdayPnLEvent>(_onFetchYesterdayPnL);
  }

  Future<void> _onFetchYesterdayPnL(
    FetchYesterdayPnLEvent event,
    Emitter<YesterdayPnlState> emit,
  ) async {
    emit(YesterdayPnLLoading());

    try {
      //! 1. Check Local Storage first

      if (event.useCache) {
        final localData = await LocalStorageService.getYesterdayPnLData();
        if (localData != null) {
          final yesterdayPnL = PnLModel.fromJson(localData);
          emit(YesterdayPnLLoaded(yesterdayPnL: yesterdayPnL));
        }
      }

      //! 2. Fetch fresh from API
      final data = await profilLossService.getYesterdayPnL();
      final yesterdayPnL = PnLModel.fromJson(data);
      // !3. Save fresh data to LocalStorage
      await LocalStorageService.saveYesterdayPnLData(data);
      emit(YesterdayPnLLoaded(yesterdayPnL: yesterdayPnL));
    } on SocketException catch (_) {
      //! Internet not available!
      log('No Internet Connection');

      final localData = await LocalStorageService.getYesterdayPnLData();
      if (localData != null) {
        final yesterdayPnL = PnLModel.fromJson(localData);
        emit(YesterdayPnLLoaded(yesterdayPnL: yesterdayPnL));
      } else {
        emit(
          const YesterdayPnLError(
            message: 'No internet and no cached data found.',
          ),
        );
      }
    } catch (e) {
      log(e.toString());
      emit(YesterdayPnLError(message: e.toString()));
    }
  }
}
