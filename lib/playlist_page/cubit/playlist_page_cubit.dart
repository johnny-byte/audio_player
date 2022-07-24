import 'package:audio_player/audio_repository.dart';
import 'package:audio_player/model/playlist.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'playlist_page_state.dart';

class PlaylistPageCubit extends Cubit<PlaylistPageState> {
  final AudioRepository _audioRepository;

  PlaylistPageCubit(this._audioRepository) : super(PlaylistPageLoading()) {
    _audioRepository
        .loadLocalStorageAudio()
        //TODO error handler
        .then((playlist) => emit(PlaylistPageLoaded(playlist)));
  }
}
