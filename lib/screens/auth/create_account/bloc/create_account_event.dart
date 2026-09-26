import 'package:equatable/equatable.dart';

sealed class CreateAccountEvent extends Equatable {
  const CreateAccountEvent();

  @override
  List<Object?> get props => [];
}

final class CreateAccountProfilePhotoSelected extends CreateAccountEvent {
  const CreateAccountProfilePhotoSelected();
}
