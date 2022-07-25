import 'dart:async';

import 'package:audio_player/model/audio.dart';
import 'package:audio_player/player.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'player_page_state.dart';

class PlayerPageCubit extends Cubit<PlayerPageState> {
  final Player _player;
  late final StreamSubscription<int?> _subscription;

  PlayerPageCubit(this._player)
      : super(PlayerPageInitial(_player.playlist![_player.currentIndex!])) {
    _subscription = _player.currentIndexStream.listen((index) {
      emit(PlayerPageInitial(_player.playlist![index!]));
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
