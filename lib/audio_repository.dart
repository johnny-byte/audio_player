import 'dart:io';
import 'package:audio_player/model/audio.dart';
import 'package:audio_player/model/playlist.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as youtube;

class AudioRepository {
  Playlist? _localStoragePlaylist;

  void _parseDescription(String text) {
    var exp = RegExp(r"((?<hours>\d*):)?(?<minutes>\d{1,2}):(?<seconds>\d\d)");
    print("start parse");
    for (var line in text.split('\n')) {
      var match = exp.firstMatch(line);
      if (match != null) {
        print(line);
        var hours = int.parse(match.namedGroup("hours") ?? "0");
        var minutes = int.parse(match.namedGroup("minutes") ?? "0");
        var seconds = int.parse(match.namedGroup("seconds") ?? "0");
        var dur = Duration(hours: hours, minutes: minutes, seconds: seconds);
        print(dur);
      }
    }
  }

  Future<Playlist> loadYoutubeAudio(String url) async {
    try {
      var yt = youtube.YoutubeExplode();
      var video = await yt.videos.get(url);
      // print(video);
      _parseDescription(video.description);
      var manifest = await yt.videos.streamsClient.getManifest(url);
      var source = manifest.audioOnly.withHighestBitrate();

      return Playlist(audioList: [Audio.fromYoutube(source.url)]);
    } on FormatException catch (e) {
      //TODO
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

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
      //TODO
      await Future.delayed(const Duration(milliseconds: 500));
      _localStoragePlaylist = Playlist(audioList: audioList);
    }
    //Initialized line above
    return _localStoragePlaylist!;
  }
}
