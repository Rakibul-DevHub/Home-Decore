import 'package:equatable/equatable.dart';

import '../data/menu_data.dart';

final class MenuState extends Equatable {
  const MenuState({
    this.items = MenuData.items,
    this.lastTappedId,
    this.loggingOut = false,
  });

  final List<MenuItem> items;

  /// The most recently tapped row, if any. Cleared when the screen is
  /// rebuilt fresh. Used for future "recently visited" highlights.
  final String? lastTappedId;

  /// True while a logout is in progress — lets the UI show a spinner or
  /// disable the button.
  final bool loggingOut;

  MenuState copyWith({
    List<MenuItem>? items,
    String? lastTappedId,
    bool? loggingOut,
  }) {
    return MenuState(
      items: items ?? this.items,
      lastTappedId: lastTappedId ?? this.lastTappedId,
      loggingOut: loggingOut ?? this.loggingOut,
    );
  }

  @override
  List<Object?> get props => [items, lastTappedId, loggingOut];
}