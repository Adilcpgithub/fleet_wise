import 'package:equatable/equatable.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object> get props => [];
}

class SelectFilter extends FilterEvent {
  final String filter;

  const SelectFilter(this.filter);

  @override
  List<Object> get props => [filter];
}
