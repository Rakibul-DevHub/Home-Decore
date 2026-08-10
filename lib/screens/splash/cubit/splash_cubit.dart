import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<bool> {
  SplashCubit({required this.duration}) : super(false);

  final Duration duration;
  Timer? _timer;

  void start() {
    _timer?.cancel();
    _timer = Timer(duration, () {
      if (!isClosed) {
        emit(true);
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
