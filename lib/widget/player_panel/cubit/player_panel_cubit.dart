import 'dart:async';
import 'package:audio_player/player.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';

part 'player_panel_state.dart';

class PlayerPanelCubit extends Cubit<PlayerPanelState> {
  final Player _player;
  late final StreamSubscription<PlaybackData> _subscription;

  PlayerPanelCubit(this._player) : super(PlayerPanelDisable()) {
    _subscription = _player.playbackDataStream.listen((data) {
      if (data.playing) {
        emit(PlayerPanelPlaying(
          position: data.position,
          duration: data.duration,
        ));
      } else {
        emit(PlayerPanelPause(
          position: data.position,
          duration: data.duration,
        ));
      }
    });
  }

  void play() {
    _player.play();
    // subscription emit new state
  }

  void pause() {
    _player.pause();
    // subscription emit new state
  }

  void seekToPrevious() => _player.seekToPrevious();

  void seekToNext() => _player.seekToNext();

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
