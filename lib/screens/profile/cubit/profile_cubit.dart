import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/profile_data.dart';

final class ProfileState extends Equatable {
  const ProfileState({this.tabIndex = 0});

  final int tabIndex;

  String get tabLabel => ProfileData.tabs[tabIndex];

  ProfileState copyWith({int? tabIndex}) {
    return ProfileState(tabIndex: tabIndex ?? this.tabIndex);
  }

  @override
  List<Object?> get props => [tabIndex];
}

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  void selectTab(int index) {
    if (index < 0 || index >= ProfileData.tabs.length) return;
    if (index == state.tabIndex) return;
    emit(state.copyWith(tabIndex: index));
  }
}
