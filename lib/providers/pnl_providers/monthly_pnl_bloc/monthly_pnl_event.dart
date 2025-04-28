import 'package:equatable/equatable.dart';

abstract class MonthlyPnlEvent extends Equatable {
  const MonthlyPnlEvent();

  @override
  List<Object> get props => [];
}

class FetchMonthlyPnLEvent extends MonthlyPnlEvent {
  final bool useCache;

  const FetchMonthlyPnLEvent({this.useCache = true});

  @override
  List<Object> get props => [useCache];
}
