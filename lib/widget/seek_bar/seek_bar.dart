import 'package:audio_player/player.dart';
import 'package:audio_player/widget/seek_bar/cubit/seek_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeekBar extends StatelessWidget {
  final bool _isSmall;

  const SeekBar.big({Key? key})
      : _isSmall = false,
        super(key: key);

  const SeekBar.small({Key? key})
      : _isSmall = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SeekBarCubit(context.read<Player>()),
      child: _isSmall ? const _SmallSeekBar() : const _BigSeekBar(),
    );
  }
}

class _SmallSeekBar extends StatelessWidget {
  const _SmallSeekBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeekBarCubit, SeekBarState>(
      builder: (context, state) => LinearProgressIndicator(
          value: state.position.inMilliseconds / state.duration.inMilliseconds),
    );
  }
}

class _BigSeekBar extends StatefulWidget {
  const _BigSeekBar({Key? key}) : super(key: key);

  @override
  State<_BigSeekBar> createState() => _BigSeekBarState();
}

class _BigSeekBarState extends State<_BigSeekBar> {
  late double _changedValue;
  bool _isChanged = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeekBarCubit, SeekBarState>(
      builder: (context, state) {
        return Slider(
          value: _isChanged
              ? _changedValue
              : state.position.inMilliseconds.toDouble(),
          max: state.duration.inMilliseconds.toDouble(),
          onChangeStart: (value) {
            _isChanged = true;
          },
          onChanged: (value) {
            setState(() {
              _changedValue = value;
            });
          },
          onChangeEnd: (value) {
            _isChanged = false;
            context
                .read<SeekBarCubit>()
                .seek(Duration(milliseconds: value.toInt()));
          },
        );
      },
    );
  }
}
