import 'package:audio_player/player.dart';
import 'package:audio_player/player_page/cubit/player_page_cubit.dart';
import 'package:audio_player/widget/control_buttons/control_buttons.dart';
import 'package:audio_player/widget/seek_bar/seek_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayerPageCubit(context.read<Player>()),
      child: Scaffold(
        appBar: AppBar(),
        body: PlayerPageView(),
      ),
    );
  }
}

class PlayerPageView extends StatelessWidget {
  const PlayerPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dimension = MediaQuery.of(context).size.width * 0.75;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlocBuilder<PlayerPageCubit, PlayerPageState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                color: state.audio.color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: SizedBox.square(
                dimension: dimension,
                child: Icon(
                  Icons.audiotrack,
                  size: dimension,
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
        SeekBar.big(),
        ControlButtons()
      ],
    );
  }
}
