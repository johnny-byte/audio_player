part of 'youtube_page_cubit.dart';

abstract class YoutubePageState extends Equatable {
  const YoutubePageState();

  @override
  List<Object> get props => [];
}

class YoutubePageInitial extends YoutubePageState {}

class YoutubePageLoading extends YoutubePageState {}

class YoutubePageLoaded extends YoutubePageState {
  final Playlist playlist;

  YoutubePageLoaded(this.playlist);
}
