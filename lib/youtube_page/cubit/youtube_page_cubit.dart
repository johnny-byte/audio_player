import 'package:audio_player/audio_repository.dart';
import 'package:audio_player/model/playlist.dart';
import 'package:audio_player/player.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'youtube_page_state.dart';

class YoutubePageCubit extends Cubit<YoutubePageState> {
  final AudioRepository _audioRepository;
  final Player _player;

  YoutubePageCubit({
    required AudioRepository audioRepository,
    required Player player,
  })  : _player = player,
        _audioRepository = audioRepository,
        super(YoutubePageInitial());

  void load(String url) {
    //FIXME await future
    _audioRepository
        .loadYoutubeAudio(url)
        .then((playlist) => emit(YoutubePageLoaded(playlist)));
    emit(YoutubePageLoading());
  }

  void play(Playlist playlist, int index) {
    _player.checkedPlay(playlist, index);
  }
}
