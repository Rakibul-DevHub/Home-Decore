import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../bloc/blocked_accounts_bloc.dart';
import '../bloc/blocked_accounts_event.dart';
import '../bloc/blocked_accounts_state.dart';
import '../data/blocked_accounts_data.dart';

class BlockedAccountsScreen extends StatelessWidget {
  const BlockedAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _BlockedAccountsAppBar(),
            Expanded(
              child: BlocBuilder<BlockedAccountsBloc, BlockedAccountsState>(
                builder: (context, state) {
                  return ListView(
                    padding: const EdgeInsets.fromLTRB(18, 8, 18, 32),
                    children: [
                      // ── Heading ────────────────────────────────
                      Text(
                        BlockedAccountsData.heading,
                        style: KolekText.sans(
                          size: 18,
                          weight: FontWeight.w600,
                          height: 1.3,
                          color: AppearancePage.foreground(context),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        BlockedAccountsData.description,
                        style: KolekText.sans(
                          size: 13,
                          weight: FontWeight.w400,
                          height: 1.5,
                          color: AppearancePage.muted(context),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ── Search ─────────────────────────────────
                      const _SearchField(),
                      const SizedBox(height: 20),

                      // ── Body ───────────────────────────────────
                      if (state.isEmpty)
                        const _EmptyState(
                          message: BlockedAccountsData.emptyMessage,
                        )
                      else if (state.hasNoMatches)
                        const _EmptyState(
                          message: BlockedAccountsData.noResultsMessage,
                        )
                      else ...[
                          Text(
                            BlockedAccountsData.sectionLabel,
                            style: KolekText.mono(
                              size: 11,
                              weight: FontWeight.w500,
                              height: 1.0,
                              letterSpacing: 1.2,
                              color: AppearancePage.muted(context),
                            ),
                          ),
                          const SizedBox(height: 12),
                          for (final user in state.visibleUsers) ...[
                            _BlockedUserRow(user: user),
                            const SizedBox(height: 12),
                          ],
                        ],
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// App bar
// ─────────────────────────────────────────────────────────────────────────

class _BlockedAccountsAppBar extends StatelessWidget {
  const _BlockedAccountsAppBar();

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
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
            BlockedAccountsData.appBarTitle,
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
// Search field
// ─────────────────────────────────────────────────────────────────────────

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppearancePage.field(context),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppearancePage.line(context)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 20,
            color: AppearancePage.muted(context),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              onChanged: (v) => context
                  .read<BlockedAccountsBloc>()
                  .add(BlockedSearchChanged(v)),
              textInputAction: TextInputAction.search,
              style: KolekText.sans(
                size: 14,
                color: AppearancePage.foreground(context),
              ),
              cursorColor: KolekColors.blue600,
              decoration: InputDecoration(
                isDense: true,
                hintText: BlockedAccountsData.searchHint,
                hintStyle: KolekText.sans(
                  size: 14,
                  color: AppearancePage.muted(context),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Blocked user row — avatar + name + blocked-on + Unblock button
// ─────────────────────────────────────────────────────────────────────────

class _BlockedUserRow extends StatelessWidget {
  const _BlockedUserRow({required this.user});

  final BlockedUser user;

  @override
  Widget build(BuildContext context) {
    final line = AppearancePage.line(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: AppearancePage.field(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: line),
      ),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              user.avatarAsset,
              width: 44,
              height: 44,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: KolekText.sans(
                    size: 14,
                    weight: FontWeight.w600,
                    height: 1.2,
                    color: AppearancePage.foreground(context),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${BlockedAccountsData.blockedOnPrefix}'
                      '${user.blockedOnLabel}',
                  style: KolekText.sans(
                    size: 12,
                    weight: FontWeight.w400,
                    height: 1.2,
                    color: AppearancePage.muted(context),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _UnblockButton(userId: user.id),
        ],
      ),
    );
  }
}

class _UnblockButton extends StatelessWidget {
  const _UnblockButton({required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);
    final line = AppearancePage.line(context);

    return SizedBox(
      height: 34,
      child: OutlinedButton(
        onPressed: () => context
            .read<BlockedAccountsBloc>()
            .add(BlockedUserUnblocked(userId)),
        style: OutlinedButton.styleFrom(
          foregroundColor: fg,
          side: BorderSide(color: line),
          padding: const EdgeInsets.symmetric(horizontal: 18),
          minimumSize: const Size(0, 34),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          textStyle: KolekText.sans(
            size: 13,
            weight: FontWeight.w500,
          ),
        ),
        child: const Text(BlockedAccountsData.unblockLabel),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Empty / no-matches state
// ─────────────────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Center(
        child: Text(
          message,
          style: KolekText.sans(
            size: 14,
            weight: FontWeight.w500,
            color: AppearancePage.muted(context),
          ),
        ),
      ),
    );
  }
}