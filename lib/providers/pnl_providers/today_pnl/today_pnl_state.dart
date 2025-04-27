import 'package:equatable/equatable.dart';
import 'package:fleet_wise/models/profit_loss/today_model.dart';

abstract class TodayPnLState extends Equatable {
  const TodayPnLState();

  @override
  List<Object> get props => [];
}

class TodayPnLInitial extends TodayPnLState {}

class TodayPnLLoading extends TodayPnLState {}

class TodayPnLLoaded extends TodayPnLState {
  final TodayPnLModel todayPnL;

  const TodayPnLLoaded({required this.todayPnL});

  @override
  List<Object> get props => [todayPnL];
}

class TodayPnLError extends TodayPnLState {
  final String message;

  const TodayPnLError({required this.message});

  @override
  List<Object> get props => [message];
}
