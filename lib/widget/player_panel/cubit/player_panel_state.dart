part of 'player_panel_cubit.dart';

@immutable
abstract class PlayerPanelState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlayerPanelDisable extends PlayerPanelState {}

class PlayerPanelEnable extends PlayerPanelState {}
