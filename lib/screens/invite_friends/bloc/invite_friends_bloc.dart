import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/invite_friends_data.dart';
import 'invite_friends_event.dart';
import 'invite_friends_state.dart';

class InviteFriendsBloc extends Bloc<InviteFriendsEvent, InviteFriendsState> {
  InviteFriendsBloc() : super(const InviteFriendsState()) {
    on<InviteLinkCopyRequested>(_onCopy);
    on<ContactSupportRequested>(_onContactSupport);
    on<ShareChannelRequested>(_onShareChannel);
  }

  Future<void> _onCopy(
      InviteLinkCopyRequested event,
      Emitter<InviteFriendsState> emit,
      ) async {
    // Write the current link to the system clipboard.
    await Clipboard.setData(ClipboardData(text: state.link));
    if (isClosed) return;

    emit(state.copyWith(copied: true));

    // Revert the label after 2 seconds. Guard against the bloc being
    // closed mid-wait so we don't emit into a dead stream.
    await Future<void>.delayed(const Duration(seconds: 2));
    if (isClosed) return;
    emit(state.copyWith(copied: false));
  }

  void _onContactSupport(
      ContactSupportRequested event,
      Emitter<InviteFriendsState> emit,
      ) {
    // TODO: open the support screen / external link.
  }

  void _onShareChannel(
      ShareChannelRequested event,
      Emitter<InviteFriendsState> emit,
      ) {
    // TODO: hook the platform share sheet:
    //   messages → share_plus with channel hint / SMS deep link
    //   email    → url_launcher mailto: with prefilled body
  }
}