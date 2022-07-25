part of 'seek_bar_cubit.dart';

abstract class SeekBarState extends Equatable {
  final Duration _position;
  final Duration _duration;

  const SeekBarState({required Duration position, required Duration duration})
      : _position = position,
        _duration = duration;

  double get value => _position.inMilliseconds / _duration.inMilliseconds;

  @override
  List<Object> get props => [value];
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
