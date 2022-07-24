part of 'playlist_page_cubit.dart';

@immutable
abstract class PlaylistPageState {}

class PlaylistPageLoading extends PlaylistPageState {}

class PlaylistPageLoaded extends PlaylistPageState {
  final Playlist playlist;

  PlaylistPageLoaded(this.playlist);
}
