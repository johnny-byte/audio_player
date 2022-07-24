import 'package:audio_player/model/audio.dart';
import 'package:just_audio/just_audio.dart';

class Playlist extends Iterable<Audio> {
  List<Audio> _audioList;
  ConcatenatingAudioSource _concatenatingAudioSource;

  Playlist({List<Audio> audioList = const []})
      : _audioList = audioList,
        _concatenatingAudioSource = ConcatenatingAudioSource(
            children: audioList.map((e) => e.source).toList());

  ConcatenatingAudioSource get source => _concatenatingAudioSource;

  @override
  int get length => _audioList.length;

  Audio operator [](int index) => _audioList[index];

  @override
  Iterator<Audio> get iterator => _audioList.iterator;
}
