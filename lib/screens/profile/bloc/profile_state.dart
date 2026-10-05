import 'package:equatable/equatable.dart';

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