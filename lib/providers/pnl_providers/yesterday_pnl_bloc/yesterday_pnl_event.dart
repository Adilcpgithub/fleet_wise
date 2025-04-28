import 'package:equatable/equatable.dart';

abstract class YesterdayPnlEvent extends Equatable {
  const YesterdayPnlEvent();

  @override
  List<Object> get props => [];
}

class FetchYesterdayPnLEvent extends YesterdayPnlEvent {
  final bool useCache;

  const FetchYesterdayPnLEvent({this.useCache = true});

  @override
  List<Object> get props => [useCache];
}
