import 'package:equatable/equatable.dart';
import 'package:fleet_wise/models/profit_loss/today_model.dart';

abstract class YesterdayPnlState extends Equatable {
  const YesterdayPnlState();

  @override
  List<Object> get props => [];
}

class YesterdayPnLInitial extends YesterdayPnlState {}

class YesterdayPnLLoading extends YesterdayPnlState {}

class YesterdayPnLLoaded extends YesterdayPnlState {
  final PnLModel yesterdayPnL;

  const YesterdayPnLLoaded({required this.yesterdayPnL});

  @override
  List<Object> get props => [yesterdayPnL];
}

class YesterdayPnLError extends YesterdayPnlState {
  final String message;

  const YesterdayPnLError({required this.message});

  @override
  List<Object> get props => [message];
}
