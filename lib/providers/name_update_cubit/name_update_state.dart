import 'package:equatable/equatable.dart';

abstract class NameUpdateState extends Equatable {
  @override
  List<Object> get props => [];
}

class NameUpdateInitial extends NameUpdateState {}

class NameUpdateLoading extends NameUpdateState {}

class NameUpdateSuccess extends NameUpdateState {
  final String name;

  NameUpdateSuccess(this.name);

  @override
  List<Object> get props => [name];
}

class NameUpdateError extends NameUpdateState {
  final String error;

  NameUpdateError(this.error);

  @override
  List<Object> get props => [error];
}
