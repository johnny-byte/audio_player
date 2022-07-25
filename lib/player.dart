import 'package:just_audio/just_audio.dart';
import 'package:audio_player/model/playlist.dart';
import 'package:rxdart/rxdart.dart';

class PlaybackData {
  final Duration duration;
  final Duration position;
  final bool playing;

  PlaybackData({
    required this.playing,
    required this.duration,
    required this.position,
  });
}

class Player extends AudioPlayer {
  Playlist? _playlist;

  Player() : super();

  Playlist? get playlist => _playlist;

  Stream<PlaybackData> get playbackDataStream => CombineLatestStream.combine3(
        durationStream,
        positionStream,
        playingStream,
        (Duration? duration, Duration position, bool playing) =>
            duration == null
                ? null
                : PlaybackData(
                    duration: duration,
                    // position can be greater than duration
                    position: position < duration ? position : duration,
                    playing: playing,
                  ),
      ).whereNotNull();

  Future<void> checkedPlay(
    Playlist playlist,
    int index, {
    bool preload = true,
    Duration? initialPosition,
  }) async {
    if (_playlist != playlist) {
      await setPlaylist(
        playlist,
        preload: preload,
        initialIndex: index,
        initialPosition: initialPosition,
      );
    } else if (currentIndex != index) {
      await seek(initialPosition ?? Duration.zero, index: index);
    }
    play();
  }

  Future<Duration?> setPlaylist(
    Playlist playlist, {
    bool preload = true,
    int? initialIndex,
    Duration? initialPosition,
  }) {
    _playlist = playlist;
    return setAudioSource(
      _playlist!.source,
      preload: preload,
      initialIndex: initialIndex,
      initialPosition: initialPosition,
    );
  }
}
