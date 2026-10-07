import 'package:equatable/equatable.dart';

import '../data/invite_friends_data.dart';

sealed class InviteFriendsEvent extends Equatable {
  const InviteFriendsEvent();

  @override
  List<Object?> get props => [];
}

/// User tapped the Copy button next to the invite link.
final class InviteLinkCopyRequested extends InviteFriendsEvent {
  const InviteLinkCopyRequested();
}

/// User tapped "Contact Support".
final class ContactSupportRequested extends InviteFriendsEvent {
  const ContactSupportRequested();
}

/// User tapped a "Share With" row (Messages / Email).
final class ShareChannelRequested extends InviteFriendsEvent {
  const ShareChannelRequested(this.channel);

  final ShareChannel channel;

  @override
  List<Object?> get props => [channel];
}