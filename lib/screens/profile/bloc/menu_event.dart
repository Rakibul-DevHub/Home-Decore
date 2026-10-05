import 'package:equatable/equatable.dart';

sealed class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object?> get props => [];
}

/// User tapped a menu row.
final class MenuItemTapped extends MenuEvent {
  const MenuItemTapped(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

/// User tapped Log Out.
final class MenuLogoutRequested extends MenuEvent {
  const MenuLogoutRequested();
}