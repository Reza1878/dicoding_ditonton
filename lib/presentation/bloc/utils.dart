import 'package:rxdart/rxdart.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
