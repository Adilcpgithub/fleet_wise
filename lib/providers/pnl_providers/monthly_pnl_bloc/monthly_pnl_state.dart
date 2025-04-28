import 'package:equatable/equatable.dart';
import 'package:fleet_wise/models/profit_loss/today_model.dart';

abstract class MonthlyPnLState extends Equatable {
  const MonthlyPnLState();

  @override
  List<Object> get props => [];
}

class MonthlyPnLInitial extends MonthlyPnLState {}

class MonthlyPnLLoading extends MonthlyPnLState {}

class MonthlyPnLLoaded extends MonthlyPnLState {
  final PnLModel monthlyPnL;

  const MonthlyPnLLoaded({required this.monthlyPnL});

  @override
  List<Object> get props => [monthlyPnL];
}

class MonthlyPnLError extends MonthlyPnLState {
  final String message;

  const MonthlyPnLError({required this.message});

  @override
  List<Object> get props => [message];
}
