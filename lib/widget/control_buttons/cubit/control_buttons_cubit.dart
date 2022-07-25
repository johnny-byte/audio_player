import 'dart:async';

import 'package:audio_player/player.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'control_buttons_state.dart';

class ControlButtonsCubit extends Cubit<ControlButtonsState> {
  final Player _player;
  late final StreamSubscription<bool> _subscription;

  ControlButtonsCubit(this._player) : super(Pause()) {
    _subscription = _player.playingStream
        .listen((isPlaying) => emit(isPlaying ? Playing() : Pause()));
  }

  void play() => _player.play();
  void pause() => _player.pause();

  void skipPrevious() => _player.seekToPrevious();
  void skipNext() => _player.seekToNext();

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
