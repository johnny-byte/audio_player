part of 'player_panel_cubit.dart';

@immutable
abstract class PlayerPanelState extends Equatable {
  final Duration position;
  final Duration duration;

  const PlayerPanelState({
    this.position = Duration.zero,
    this.duration = const Duration(milliseconds: 1),
  });

  @override
  List<Object?> get props => [position, duration];
}

class PlayerPanelDisable extends PlayerPanelState {}

class PlayerPanelPlaying extends PlayerPanelState {
  const PlayerPanelPlaying({
    super.position,
    super.duration,
  });
}

class PlayerPanelPause extends PlayerPanelState {
  const PlayerPanelPause({
    super.position,
    super.duration,
  });
}
