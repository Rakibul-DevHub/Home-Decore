import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeCubit extends Cubit<bool> {
  WelcomeCubit() : super(false);

  void togglePasswordVisibility() => emit(!state);
}
