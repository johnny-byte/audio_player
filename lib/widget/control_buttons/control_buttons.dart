import 'package:audio_player/player.dart';
import 'package:audio_player/widget/control_buttons/cubit/control_buttons_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ControlButtons extends StatelessWidget {
  const ControlButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ControlButtonsCubit(context.read<Player>()),
      child: Row(
        children: const [
          _SkipPreviousButton(),
          _PlayPauseButton(),
          _SkipNextButton(),
        ],
      ),
    );
  }
}

class _SkipPreviousButton extends StatelessWidget {
  const _SkipPreviousButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: context.read<ControlButtonsCubit>().skipPrevious,
      icon: const Icon(Icons.skip_previous),
    );
  }
}

class _SkipNextButton extends StatelessWidget {
  const _SkipNextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: context.read<ControlButtonsCubit>().skipNext,
      icon: const Icon(Icons.skip_next),
    );
  }
}

class _PlayPauseButton extends StatelessWidget {
  const _PlayPauseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ControlButtonsCubit, ControlButtonsState>(
      builder: (context, state) {
        if (state is Pause) {
          return IconButton(
            onPressed: context.read<ControlButtonsCubit>().play,
            icon: const Icon(Icons.play_arrow),
          );
        }

        if (state is Playing) {
          return IconButton(
            onPressed: context.read<ControlButtonsCubit>().pause,
            icon: const Icon(Icons.pause),
          );
        }
        throw Exception("unhandled state: $state");
      },
    );
  }
}
