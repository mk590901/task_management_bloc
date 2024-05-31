import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'core/interfaces/i_async_process.dart';

class AsyncTimerProcessSimulator implements IAsyncProcess {
  Timer? _timer;
  final Duration _duration;
  final int min = 0;
  final int max = 100;
  final _random = Random();

  AsyncTimerProcessSimulator(this._duration);

  @override
  void start(VoidCallback? success, VoidCallback? failed) {
    _timer = Timer(_duration, () {
      int randomNumber = min + _random.nextInt(max - min + 1);
      if (randomNumber < 50) {
        failed?.call();
      }
      else {
        success?.call();
      }
    });
  }

  @override
  void stop(VoidCallback? cancel) {
    if (_timer != null && _timer!.isActive) {
      _timer?.cancel();
      _timer = null;
      cancel?.call();
    }
  }
}