import 'package:equatable/equatable.dart';

final class CreateAccountState extends Equatable {
  const CreateAccountState({this.hasProfilePhoto = false});

  final bool hasProfilePhoto;

  CreateAccountState copyWith({bool? hasProfilePhoto}) {
    return CreateAccountState(
      hasProfilePhoto: hasProfilePhoto ?? this.hasProfilePhoto,
    );
  }

  @override
  List<Object?> get props => [hasProfilePhoto];
}
