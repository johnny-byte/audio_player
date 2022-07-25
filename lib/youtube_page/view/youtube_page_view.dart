import 'package:audio_player/audio_repository.dart';
import 'package:audio_player/player.dart';
import 'package:audio_player/widget/player_panel/view/player_panel_widget.dart';
import 'package:audio_player/youtube_page/cubit/youtube_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YoutubePage extends StatelessWidget {
  const YoutubePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => YoutubePageCubit(
          audioRepository: context.read<AudioRepository>(),
          player: context.read<Player>()),
      child: Scaffold(
        appBar: AppBar(),
        body: YoutubePageView(),
        bottomSheet: const PlayerPanel(),
      ),
    );
  }
}

class YoutubePageView extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  YoutubePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<YoutubePageCubit, YoutubePageState>(
      builder: (context, state) {
        if (state is YoutubePageInitial) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              onEditingComplete: () =>
                  context.read<YoutubePageCubit>().load(_controller.text),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter youtube url',
              ),
            ),
          );
        }
        if (state is YoutubePageLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is YoutubePageLoaded) {
          return TextButton(
              onPressed: () =>
                  context.read<YoutubePageCubit>().play(state.playlist, 0),
              child: Text(state.playlist[0].name));
        }
        throw Exception("unexpected $state");
      },
    );
  }
}
