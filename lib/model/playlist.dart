import 'package:audio_player/model/audio.dart';

class Playlist extends Iterable<Audio> {
  List<Audio> _audioList;

  Playlist({List<Audio> audioList = const []}) : _audioList = audioList;

  @override
  int get length => _audioList.length;

  Audio operator [](int index) => _audioList[index];

  @override
  Iterator<Audio> get iterator => _audioList.iterator;
}
