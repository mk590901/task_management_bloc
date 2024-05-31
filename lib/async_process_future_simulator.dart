import 'dart:async';
import 'dart:math';
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'core/interfaces/i_async_process.dart';

class AsyncFutureProcessSimulator implements IAsyncProcess {
  CancelableOperation?
      _action; // Create a CancelableOperation variable to manage cancellation.

  bool _isActive = false;
  bool _actionCompleted = false;

  final Duration _duration;
  final int min = 0;
  final int max = 100;
  final _random = Random();

  AsyncFutureProcessSimulator(this._duration);

  @override
  void start(VoidCallback? success, VoidCallback? failed) {
    _isActive = true;
    _actionCompleted = false;

    _process(success, failed);
  }

  Future<void> _process(VoidCallback? success, VoidCallback? failed) async {
    try {
      // Simulate a time-consuming download operation.
      _action = CancelableOperation.fromFuture(
        Future.delayed(_duration),
      ).then((_) {
        // Handle completion
        debugPrint("******* Handle completion *******");

        int randomNumber = min + _random.nextInt(max - min + 1);
        if (randomNumber < 50) {
          failed?.call();
        } else {
          success?.call();
        }
      });

      if (!_action!.isCanceled) {
        _actionCompleted = true;
        debugPrint("******* Completed *******");
      }
    } catch (exception) {
      // Handle exception
      debugPrint("******* exception *******");
      failed?.call();
    } finally {
      _isActive = false;
      debugPrint("******* finally *******");
    }
  }

  @override
  void stop(VoidCallback? cancel) {
    if (_action != null && !_action!.isCanceled) {
      _action!.cancel(); // Cancel the process if it's running.
      _isActive = false;
      debugPrint("******* cancel *******");
      cancel?.call();
    }
  }
}
