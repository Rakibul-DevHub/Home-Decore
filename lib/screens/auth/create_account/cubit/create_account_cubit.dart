import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccountCubit extends Cubit<bool> {
  CreateAccountCubit() : super(false);

  void selectProfilePhoto() => emit(true);
}
