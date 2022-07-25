import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:just_audio/just_audio.dart';

class Audio {
  final String name;
  final Color color;
  final AudioSource source;
  Audio.fromFile(String path)
      : name = path,
        color = Color(Random().nextInt(0xDDDDDDDD)),
        source = AudioSource.uri(Uri.file(path));

  Audio.fromYoutube(Uri url)
      : name = url.toString(),
        color = Color(Random().nextInt(0xDDDDDDDD)),
        source = AudioSource.uri(url);
}
