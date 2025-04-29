import 'dart:developer';
import 'dart:io';
import 'package:fleet_wise/models/profit_loss/today_model.dart';
import 'package:fleet_wise/providers/pnl_providers/monthly_pnl_bloc/monthly_pnl_event.dart';
import 'package:fleet_wise/providers/pnl_providers/monthly_pnl_bloc/monthly_pnl_state.dart';
import 'package:fleet_wise/services/local_storage_service.dart';
import 'package:fleet_wise/services/profi_loss_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MonthlyPnlBloc extends Bloc<MonthlyPnlEvent, MonthlyPnLState> {
  final ProfitLossService profilLossService = ProfitLossService();

  MonthlyPnlBloc() : super(MonthlyPnLInitial()) {
    on<FetchMonthlyPnLEvent>(_onFetchMonthlyPnL);
  }

  Future<void> _onFetchMonthlyPnL(
    FetchMonthlyPnLEvent event,
    Emitter<MonthlyPnLState> emit,
  ) async {
    emit(MonthlyPnLLoading());

    try {
      //! 1. Check Local Storage first

      if (event.useCache) {
        final localData = await LocalStorageService.getMonthlyPnLData();
        if (localData != null && localData.isNotEmpty) {
          final monthlyPnL = PnLModel.fromJson(localData);
          emit(MonthlyPnLLoaded(monthlyPnL: monthlyPnL));
          return; //  Stop here if cache used
        }
      }

      //! 2. Fetch fresh from API
      final data = await profilLossService.getMonthlyPnL();
      final monthlyPnL = PnLModel.fromJson(data);
      // !3. Save fresh data to LocalStorage
      await LocalStorageService.saveMonthlyPnLData(data);
      emit(MonthlyPnLLoaded(monthlyPnL: monthlyPnL));
    } on SocketException catch (_) {
      //! Internet not available!
      log('No Internet Connection');

      final localData = await LocalStorageService.getMonthlyPnLData();
      if (localData != null && localData.isNotEmpty) {
        final monthlyPnL = PnLModel.fromJson(localData);
        emit(MonthlyPnLLoaded(monthlyPnL: monthlyPnL));
      } else {
        emit(
          const MonthlyPnLError(
            message: 'No internet and no cached data found.',
          ),
        );
      }
    } catch (e) {
      log(e.toString());
      emit(MonthlyPnLError(message: e.toString()));
    }
  }
}
