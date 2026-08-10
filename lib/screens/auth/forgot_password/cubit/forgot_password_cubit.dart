import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordCubit extends Cubit<bool> {
  ForgotPasswordCubit() : super(false);

  void submit() => emit(true);
}
