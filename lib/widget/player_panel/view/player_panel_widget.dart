import 'package:audio_player/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audio_player/widget/player_panel/cubit/player_panel_cubit.dart';

class PlayerPanel extends StatelessWidget {
  const PlayerPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayerPanelCubit(context.read<Player>()),
      child: BlocBuilder<PlayerPanelCubit, PlayerPanelState>(
        builder: (context, state) {
          if (state is PlayerPanelDisable) {
            return const SizedBox.shrink();
          }
          return SizedBox(
            height: 64,
            child: Column(children: [
              LinearProgressIndicator(
                value: state.position.inMilliseconds /
                    state.duration.inMilliseconds,
              ),
              Expanded(child: ControlButtonsLine(state: state)),
            ]),
          );
        },
      ),
    );
  }
}

class ControlButtonsLine extends StatelessWidget {
  final PlayerPanelState state;
  const ControlButtonsLine({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      IconButton(
        onPressed: context.read<PlayerPanelCubit>().seekToPrevious,
        icon: const Icon(Icons.skip_previous),
      ),
      if (state is PlayerPanelPause)
        IconButton(
            onPressed: context.read<PlayerPanelCubit>().play,
            icon: const Icon(Icons.play_arrow))
      else if (state is PlayerPanelPlaying)
        IconButton(
            onPressed: context.read<PlayerPanelCubit>().pause,
            icon: const Icon(Icons.pause))
      else
        throw Exception("unexpected state: $state"),
      IconButton(
        onPressed: context.read<PlayerPanelCubit>().seekToNext,
        icon: const Icon(Icons.skip_next),
      ),
    ]);
  }
}
