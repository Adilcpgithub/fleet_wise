import 'package:equatable/equatable.dart';

abstract class TodayPnLEvent extends Equatable {
  const TodayPnLEvent();

  @override
  List<Object> get props => [];
}

class FetchTodayPnLEvent extends TodayPnLEvent {
  final bool useCache;

  const FetchTodayPnLEvent({this.useCache = true});

  @override
  List<Object> get props => [useCache];
}
