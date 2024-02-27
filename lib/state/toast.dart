// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/material.dart';

import '../types.dart';

class ToastQueue extends ChangeNotifier {
  final List<Toast> _toasts = [];
  Timer? timer;

  /// The amount of toasts in the queue.
  int get length => _toasts.length;

  Toast? get current => _toasts.isNotEmpty ? _toasts[0] : null;

  /// Adds [toast] to the list of current toasts in the queue.
  void add(Toast toast) {
    _toasts.add(toast);

    if (timer != null) {
      notifyListeners();
      return;
    }

    timer = Timer.periodic(const Duration(seconds: 5), (_timer) {
      if (_toasts.isEmpty) {
        _timer.cancel();
        timer = null;
        return;
      }

      _toasts.removeAt(0);
      notifyListeners();
    });

    notifyListeners();
  }

  /// Removes all items from the toast queue.
  void removeAll() {
    _toasts.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
/*
class ToastConsumer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      showBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return ListenableBuilder(
              listenable: queue,
              builder: (BuildContext context, Widget? child) {
                print("yes");
                print(queue.current?.variant);
                if (queue.current != null)
                  return ToastComponent(toast: queue.current!);
                return Container();
              },
            );
          });
    });
    return Consumer<ToastQueue>(
        builder: (context, toasts, child) => Stack(
              children: [
                // Use SomeExpensiveWidget here, without rebuilding every time.
                if (child != null) child,
                toasts.current != null
                    ? ToastComponent(toast: toasts.current!)
                    : Container()
              ],
            ));
  }
}
*/
