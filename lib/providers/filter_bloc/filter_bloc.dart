import 'package:fleet_wise/providers/filter_bloc/filter_event.dart';
import 'package:fleet_wise/providers/filter_bloc/filter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(const FilterState(selectedFilter: 'Today')) {
    on<SelectFilter>(_onSelectFilter);
  }

  void _onSelectFilter(SelectFilter event, Emitter<FilterState> emit) {
    emit(FilterState(selectedFilter: event.filter));
  }
}
