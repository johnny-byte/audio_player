part of 'control_buttons_cubit.dart';

abstract class ControlButtonsState extends Equatable {
  const ControlButtonsState();

  @override
  List<Object> get props => [];
}

class Pause extends ControlButtonsState {}

class Playing extends ControlButtonsState {}
