import 'dart:io';
import 'package:audio_player/model/audio.dart';
import 'package:audio_player/model/playlist.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioRepository {
  Playlist? _localStoragePlaylist;

  Future<Playlist> loadLocalStorageAudio() async {
    if (_localStoragePlaylist == null) {
      final audioList = <Audio>[];
      final String musicDirectoryPath;
      if (Platform.isLinux) {
        final homeDir = Platform.environment["HOME"];
        musicDirectoryPath = '${homeDir}/Music';
      } else if (Platform.isAndroid) {
        var permissionStatus = await Permission.storage.request();
        if (permissionStatus.isGranted) {
          musicDirectoryPath = "/storage/emulated/0/Music";
        } else {
          //FIXME
          print("Need permission");
          throw Exception("Need permission");
        }
      } else {
        print("Unsupported platform");
        throw Exception("Unsupported platform");
      }
      // break;
      var musicDirectory = Directory(musicDirectoryPath);
      //TODO use watch method
      //TODO set recursive true
      await for (var entity in musicDirectory.list()) {
        if (entity is File) {
          File file = entity;
          var ext = file.path.split('.').last;
          //TODO add more ext
          if (ext == "mp3") {
            audioList.add(Audio.fromFile(file.path));
          }
        }
      }
      await Future.delayed(const Duration(milliseconds: 500));
      _localStoragePlaylist = Playlist(audioList: audioList);
    }
    //Initialized line above
    return _localStoragePlaylist!;
  }
}
