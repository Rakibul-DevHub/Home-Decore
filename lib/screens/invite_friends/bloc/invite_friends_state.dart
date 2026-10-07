import 'package:equatable/equatable.dart';

import '../data/invite_friends_data.dart';

final class InviteFriendsState extends Equatable {
  const InviteFriendsState({
    this.link = InviteFriendsData.inviteLink,
    this.copied = false,
  });

  final String link;

  /// True for ~2 seconds after a successful copy — lets the UI swap the
  /// button label from "Copy" to "Copied".
  final bool copied;

  InviteFriendsState copyWith({
    String? link,
    bool? copied,
  }) {
    return InviteFriendsState(
      link: link ?? this.link,
      copied: copied ?? this.copied,
    );
  }

  @override
  List<Object?> get props => [link, copied];
}