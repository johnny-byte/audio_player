import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:audio_player/player.dart';
import 'package:equatable/equatable.dart';

part 'seek_bar_state.dart';

class SeekBarCubit extends Cubit<SeekBarState> {
  final Player _player;
  late final StreamSubscription<PlaybackData> _subscription;

  SeekBarCubit(this._player) : super(const SeekBarInitial()) {
    _subscription = _player.playbackDataStream.listen(
      (data) => emit(SeekBarUpdate(
        position: data.position,
        duration: data.duration,
      )),
    );
  }

  //TODO maybe ui bug when data comes from _subscription
  void seek(double value) {
    assert(0 <= value && value <= 1);
    final position = state._duration * value;
    _player.seek(state._duration * value);
    emit(SeekBarUpdate(position: position, duration: state._duration));
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
