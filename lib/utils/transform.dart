// This is the function you will use in your BLoC.
// It returns an EventTransformer that debounces events.
import 'dart:async';

import 'package:bloc/bloc.dart';

EventTransformer<E> customDebounce<E>(Duration duration) {
  return (events, mapper) {
    // We transform the event stream using our custom transformer
    // and then use asyncExpand to map the debounced event to an output stream.
    return events
        .transform(_DebounceStreamTransformer(duration))
        .asyncExpand(mapper);
  };
}

/// A custom StreamTransformer that implements the debounce logic.
/// It listens to an incoming stream and only emits the last item after a
/// specified duration of silence.
class _DebounceStreamTransformer<T> extends StreamTransformerBase<T, T> {
  final Duration duration;

  _DebounceStreamTransformer(this.duration);

  @override
  Stream<T> bind(Stream<T> stream) {
    Timer? timer;
    StreamController<T>? controller;
    StreamSubscription<T>? subscription;
    T? latestValue;

    // The controller is responsible for managing the new, debounced stream.
    controller = StreamController<T>(
      onListen: () {
        // When the debounced stream is listened to, we start listening to the original stream.
        subscription = stream.listen(
          (value) {
            // When a new value arrives, we store it.
            latestValue = value;
            // We cancel any existing timer. This is the core of the debounce logic.
            timer?.cancel();
            // And start a new timer.
            timer = Timer(duration, () {
              // When the timer completes, it means the specified duration has passed
              // without any new events. We can now emit the last value we received.
              final value = latestValue;
              if (value != null) {
                controller?.add(value);
              }
            });
          },
          onError: controller?.addError,
          onDone: () {
            // When the original stream is done, we clean up.
            timer?.cancel();
            // If there was a pending value, emit it before closing.
            final value = latestValue;
            if (value != null) {
              controller?.add(value);
            }
            controller?.close();
          },
        );
      },
      onPause: () => subscription?.pause(),
      onResume: () => subscription?.resume(),
      onCancel: () {
        // If the listener cancels, we clean up the timer and subscription.
        timer?.cancel();
        return subscription?.cancel();
      },
    );

    return controller.stream;
  }
}
