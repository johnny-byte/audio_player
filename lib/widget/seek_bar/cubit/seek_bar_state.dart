part of 'seek_bar_cubit.dart';

abstract class SeekBarState extends Equatable {
  final Duration position;
  final Duration duration;

  const SeekBarState({required this.position, required this.duration});

  @override
  List<Object> get props => [position, duration];
}

class SeekBarInitial extends SeekBarState {
  const SeekBarInitial()
      : super(
          position: Duration.zero,
          duration: const Duration(milliseconds: 1),
        );
}

class SeekBarUpdate extends SeekBarState {
  const SeekBarUpdate({required super.position, required super.duration});
}
