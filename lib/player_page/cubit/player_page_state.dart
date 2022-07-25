part of 'player_page_cubit.dart';

abstract class PlayerPageState extends Equatable {
  final Audio audio;

  const PlayerPageState(this.audio);

  @override
  List<Object> get props => [audio];
}

class PlayerPageInitial extends PlayerPageState {
  const PlayerPageInitial(super.audio);
}
