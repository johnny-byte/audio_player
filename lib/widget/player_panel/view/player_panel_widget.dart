import 'package:animations/animations.dart';
import 'package:audio_player/player.dart';
import 'package:audio_player/player_page/player_page.dart';
import 'package:audio_player/widget/control_buttons/control_buttons.dart';
import 'package:audio_player/widget/seek_bar/seek_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audio_player/widget/player_panel/cubit/player_panel_cubit.dart';

class PlayerPanel extends StatelessWidget {
  const PlayerPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedShape: const RoundedRectangleBorder(),
      openBuilder: (context, action) => const PlayerPage(),
      closedBuilder: (context, action) => BlocProvider(
        create: (context) => PlayerPanelCubit(context.read<Player>()),
        child: BlocBuilder<PlayerPanelCubit, PlayerPanelState>(
          builder: (context, state) {
            if (state is PlayerPanelDisable) {
              return const SizedBox.shrink();
            }
            if (state is PlayerPanelEnable) {
              return SizedBox(
                height: 64,
                child: Column(children: const [
                  SeekBar.small(),
                  Expanded(child: ControlButtons()),
                ]),
              );
            }
            throw Exception("unexpected state: $state");
          },
        ),
      ),
    );
  }
}
