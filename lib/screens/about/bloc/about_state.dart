import 'package:equatable/equatable.dart';

/// About is a static-content screen, so there's no meaningful state to
/// carry. The bloc still exists for consistency with the rest of the
/// app, and to give the email tap a place to live.
final class AboutState extends Equatable {
  const AboutState();

  @override
  List<Object?> get props => [];
}