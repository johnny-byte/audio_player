import 'package:audio_player/audio_repository.dart';
import 'package:audio_player/model/playlist.dart';
import 'package:audio_player/player.dart';
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'playlist_page_state.dart';

class PlaylistPageCubit extends Cubit<PlaylistPageState> {
  final Player player;

  PlaylistPageCubit({
    required this.player,
    required Future<Playlist> playlistFuture,
  }) : super(PlaylistPageLoading()) {
    playlistFuture
        //TODO error handler
        .then((playlist) => emit(PlaylistPageLoaded(playlist)));
  }

  Future<void> play(int index) async {
    if (state is PlaylistPageLoaded) {
      player.checkedPlay((state as PlaylistPageLoaded).playlist, index);
    }
  }
}
