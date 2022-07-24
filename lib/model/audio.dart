import 'package:just_audio/just_audio.dart';

class Audio {
  final String name;
  final AudioSource source;
  Audio.fromFile(String path)
      : name = path,
        source = AudioSource.uri(Uri.file(path));
}
