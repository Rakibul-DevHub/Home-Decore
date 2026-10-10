import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

final class AppearanceState extends Equatable {
  const AppearanceState({required this.mode});

  /// Currently selected theme mode.
  final ThemeMode mode;

  AppearanceState copyWith({ThemeMode? mode}) {
    return AppearanceState(mode: mode ?? this.mode);
  }

  @override
  List<Object?> get props => [mode];
}