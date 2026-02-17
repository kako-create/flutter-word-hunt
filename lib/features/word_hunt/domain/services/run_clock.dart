import 'dart:async';
import 'dart:math';

typedef RunClockTick = void Function(int elapsedMs, int? remainingMs);

class RunClock {
  final int? timeLimitMs;
  final Duration tickInterval;
  final RunClockTick? onTick;
  final Stopwatch _stopwatch;

  Timer? _timer;
  int _elapsedBeforeStartMs = 0;

  RunClock({
    this.timeLimitMs,
    this.tickInterval = const Duration(milliseconds: 250),
    this.onTick,
    Stopwatch? stopwatch,
  }) : _stopwatch = stopwatch ?? Stopwatch();

  bool get isRunning => _stopwatch.isRunning;

  int get elapsedMs =>
      _elapsedBeforeStartMs +
      (_stopwatch.isRunning ? _stopwatch.elapsedMilliseconds : 0);

  int? get remainingMs {
    final limit = timeLimitMs;
    if (limit == null) return null;
    return max(0, limit - elapsedMs);
  }

  void start({int initialElapsedMs = 0}) {
    _elapsedBeforeStartMs = max(0, initialElapsedMs);
    _stopwatch
      ..stop()
      ..reset()
      ..start();
    _startTimer();
    _emitTick();
  }

  void pause() {
    if (!_stopwatch.isRunning) return;
    _elapsedBeforeStartMs += _stopwatch.elapsedMilliseconds;
    _stopwatch
      ..stop()
      ..reset();
    _cancelTimer();
    _emitTick();
  }

  void resume() {
    if (_stopwatch.isRunning) return;
    _stopwatch.start();
    _startTimer();
    _emitTick();
  }

  void stop() {
    if (_stopwatch.isRunning) {
      _elapsedBeforeStartMs += _stopwatch.elapsedMilliseconds;
    }
    _stopwatch
      ..stop()
      ..reset();
    _cancelTimer();
    _emitTick();
  }

  void setElapsedMs(int valueMs) {
    _elapsedBeforeStartMs = max(0, valueMs);
    _stopwatch
      ..stop()
      ..reset();
    _cancelTimer();
    _emitTick();
  }

  void dispose() {
    _cancelTimer();
    _stopwatch
      ..stop()
      ..reset();
  }

  void _startTimer() {
    _cancelTimer();
    _timer = Timer.periodic(tickInterval, (_) => _emitTick());
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _emitTick() {
    onTick?.call(elapsedMs, remainingMs);
  }
}
