import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';

import 'core/interfaces/i_async_process.dart';

class AsyncFutureProcessSimulator implements IAsyncProcess {

  CancelableOperation? _downloadOperation; // Create a CancelableOperation variable to manage cancellation.
  bool _isDownloading = false;
  bool _downloadCompleted = false;

  final Duration _duration;
  final int min = 0;
  final int max = 100;
  final _random = Random();

  AsyncFutureProcessSimulator(this._duration);

  @override
  void start(VoidCallback? success, VoidCallback? failed) {

    _isDownloading = true;
    _downloadCompleted = false;

    _downloadFile(success, failed);

    // _timer = Timer(_duration, () {
    //   int randomNumber = min + _random.nextInt(max - min + 1);
    //   if (randomNumber < 50) {
    //     failed?.call();
    //   }
    //   else {
    //     success?.call();
    //   }
    // });

  }

  Future<void> _downloadFile(VoidCallback? success, VoidCallback? failed) async {
    try {
      // Simulate a time-consuming download operation.
      _downloadOperation = CancelableOperation.fromFuture(
        Future.delayed(_duration),
      ).then((_) {
        // Handle completion
        debugPrint("******* Handle completion *******");

          int randomNumber = min + _random.nextInt(max - min + 1);
          if (randomNumber < 50) {
            failed?.call();
          }
          else {
            success?.call();
          }



      });

      if (!_downloadOperation!.isCanceled) {
        _downloadCompleted = true;
        debugPrint("******* Completed *******");
      }
    } catch (exception) {
      // Handle errors
      debugPrint("******* exception *******");

    } finally {
      _isDownloading = false;
      debugPrint("******* finally *******");
    }
  }

  @override
  void stop(VoidCallback? cancel) {
    if (_downloadOperation != null && !_downloadOperation!.isCanceled) {
      _downloadOperation!.cancel(); // Cancel the download operation if it's running.
      _isDownloading = false;
      cancel?.call();
    }
  }
}