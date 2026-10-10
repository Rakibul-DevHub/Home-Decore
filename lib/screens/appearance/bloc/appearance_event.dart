import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class AppearanceEvent extends Equatable {
  const AppearanceEvent();

  @override
  List<Object?> get props => [];
}

/// User picked a theme option (Light / Dark).
final class AppearanceModeChanged extends AppearanceEvent {
  const AppearanceModeChanged(this.mode);

  final ThemeMode mode;

  @override
  List<Object?> get props => [mode];
}