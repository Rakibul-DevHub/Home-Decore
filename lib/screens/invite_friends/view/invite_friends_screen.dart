import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../bloc/invite_friends_bloc.dart';
import '../bloc/invite_friends_event.dart';
import '../bloc/invite_friends_state.dart';
import '../data/invite_friends_data.dart';

class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _InviteAppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 12),
                    const _HeroSection(),
                    const SizedBox(height: 36),
                    const _InviteLinkSection(),
                    const SizedBox(height: 14),
                    const _ContactSupportButton(),
                    const SizedBox(height: 32),
                    const _ShareWithSection(),
                    const SizedBox(height: 60),
                    const _SuggestedMessageSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// App bar — back arrow + title (left-aligned, no bell)
// ─────────────────────────────────────────────────────────────────────────

class _InviteAppBar extends StatelessWidget {
  const _InviteAppBar();

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints:
            const BoxConstraints(minWidth: 40, minHeight: 40),
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back, size: 24, color: fg),
          ),
          const SizedBox(width: 4),
          Text(
            InviteFriendsData.title,
            style: KolekText.sans(
              size: 20,
              weight: FontWeight.w600,
              height: 1.0,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Hero — centered headline + subtitle
// ─────────────────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          InviteFriendsData.heroTitle,
          textAlign: TextAlign.center,
          style: KolekText.sans(
            size: 30,
            weight: FontWeight.w600,
            height: 1.15,
            letterSpacing: -0.5,
            color: AppearancePage.foreground(context),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          InviteFriendsData.heroSubtitle,
          textAlign: TextAlign.center,
          style: KolekText.sans(
            size: 13,
            weight: FontWeight.w400,
            height: 1.5,
            color: AppearancePage.muted(context),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Invite link — bordered field with Copy button
// ─────────────────────────────────────────────────────────────────────────

class _InviteLinkSection extends StatelessWidget {
  const _InviteLinkSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          InviteFriendsData.inviteLinkLabel,
          style: KolekText.sans(
            size: 14,
            weight: FontWeight.w600,
            height: 1.0,
            color: AppearancePage.foreground(context),
          ),
        ),
        const SizedBox(height: 10),
        BlocSelector<InviteFriendsBloc, InviteFriendsState, bool>(
          selector: (s) => s.copied,
          builder: (context, copied) => Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: AppearancePage.field(context),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppearancePage.line(context)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    InviteFriendsData.inviteLink,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: KolekText.mono(
                      size: 14,
                      weight: FontWeight.w400,
                      height: 1.0,
                      letterSpacing: 0,
                      color: AppearancePage.foreground(context),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => context
                      .read<InviteFriendsBloc>()
                      .add(const InviteLinkCopyRequested()),
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 6,
                    ),
                    child: Text(
                      copied
                          ? InviteFriendsData.copiedLabel
                          : InviteFriendsData.copyLabel,
                      style: KolekText.sans(
                        size: 14,
                        weight: FontWeight.w600,
                        height: 1.0,
                        color: KolekColors.blue600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Contact Support button
// ─────────────────────────────────────────────────────────────────────────

class _ContactSupportButton extends StatelessWidget {
  const _ContactSupportButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: FilledButton(
        onPressed: () => context
            .read<InviteFriendsBloc>()
            .add(const ContactSupportRequested()),
        style: FilledButton.styleFrom(
          backgroundColor: KolekColors.blue600,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          textStyle: KolekText.sans(
            size: 16,
            weight: FontWeight.w600,
          ),
        ),
        child: const Text(InviteFriendsData.contactSupportLabel),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Share With — Messages / Email
// ─────────────────────────────────────────────────────────────────────────

class _ShareWithSection extends StatelessWidget {
  const _ShareWithSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          InviteFriendsData.shareWithLabel,
          style: KolekText.sans(
            size: 14,
            weight: FontWeight.w600,
            height: 1.0,
            color: AppearancePage.foreground(context),
          ),
        ),
        const SizedBox(height: 6),
        _ShareRow(
          icon: Icons.chat_bubble_outline,
          label: InviteFriendsData.messagesLabel,
          channel: ShareChannel.messages,
        ),
        Divider(
          height: 1,
          thickness: 0.5,
          color: AppearancePage.line(context),
        ),
        _ShareRow(
          icon: Icons.mail_outline,
          label: InviteFriendsData.emailLabel,
          channel: ShareChannel.email,
        ),
        Divider(
          height: 1,
          thickness: 0.5,
          color: AppearancePage.line(context),
        ),
      ],
    );
  }
}

class _ShareRow extends StatelessWidget {
  const _ShareRow({
    required this.icon,
    required this.label,
    required this.channel,
  });

  final IconData icon;
  final String label;
  final ShareChannel channel;

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);

    return InkWell(
      onTap: () => context
          .read<InviteFriendsBloc>()
          .add(ShareChannelRequested(channel)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Icon(icon, size: 22, color: fg),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: KolekText.sans(
                  size: 14,
                  weight: FontWeight.w500,
                  height: 1.0,
                  color: fg,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 20,
              color: AppearancePage.icon(context),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Suggested Invite Message
// ─────────────────────────────────────────────────────────────────────────

class _SuggestedMessageSection extends StatelessWidget {
  const _SuggestedMessageSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          InviteFriendsData.suggestedLabel,
          style: KolekText.sans(
            size: 14,
            weight: FontWeight.w600,
            height: 1.0,
            color: AppearancePage.foreground(context),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          decoration: BoxDecoration(
            color: AppearancePage.field(context),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppearancePage.line(context)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                InviteFriendsData.suggestedBody,
                style: KolekText.sans(
                  size: 13,
                  weight: FontWeight.w400,
                  height: 1.5,
                  color: AppearancePage.muted(context),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                InviteFriendsData.inviteLink,
                style: KolekText.mono(
                  size: 13,
                  weight: FontWeight.w400,
                  height: 1.0,
                  letterSpacing: 0,
                  color: AppearancePage.foreground(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}