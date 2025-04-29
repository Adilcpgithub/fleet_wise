import 'package:equatable/equatable.dart';

class FilterState extends Equatable {
  final String selectedFilter;

  const FilterState({required this.selectedFilter});

  @override
  List<Object> get props => [selectedFilter];
}
