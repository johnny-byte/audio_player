import 'package:audio_player/audio_repository.dart';
import 'package:audio_player/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audio_player/playlist_page/cubit/playlist_page_cubit.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlaylistPageCubit(
        audioRepository: context.read<AudioRepository>(),
        player: context.read<Player>(),
      ),
      child: Scaffold(
        appBar: AppBar(),
        body: const PlaylistView(),
      ),
    );
  }
}

class PlaylistView extends StatelessWidget {
  const PlaylistView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistPageCubit, PlaylistPageState>(
      builder: (context, state) {
        if (state is PlaylistPageLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is PlaylistPageLoaded) {
          return ListView.builder(
            itemCount: state.playlist.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(state.playlist[index].name),
              onTap: () => context.read<PlaylistPageCubit>().play(index),
            ),
          );
        }
        throw UnimplementedError("unexpected state: $state");
      },
    );
  }
}
