import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

EventTransformer<Event> throttle<Event>(
  Duration duration, {
  bool trailing = false,
  bool leading = true,
}) =>
    (events, mapper) => events
        .throttleTime(duration, trailing: trailing, leading: leading)
        .flatMap(mapper);
