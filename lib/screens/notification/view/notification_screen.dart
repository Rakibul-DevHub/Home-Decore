import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../theme/kolek_colors.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_event.dart';
import '../bloc/notification_state.dart';
import '../data/notification_data.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KolekColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back,
            size: 22,
            color: KolekColors.neutral900,
          ),
        ),
        centerTitle: true,
        title: const Text(
          NotificationData.title,
          style: TextStyle(
            fontFamily: 'GeneralSans-Medium',
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: KolekColors.blue600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: KolekColors.neutral900, width: 1.2),
              ),
              child: const Icon(
                Icons.more_horiz,
                size: 18,
                color: KolekColors.neutral900,
              ),
            ),
          ),
          const SizedBox(width: 6),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: KolekColors.neutral200,
          ),
        ),
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          return ListView(
            children: [
              const _SectionHeader(label: NotificationData.todayLabel),
              for (var i = 0; i < state.today.length; i++) ...[
                _NotificationTile(notification: state.today[i]),
                if (i != state.today.length - 1) Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: const _RowDivider(),
                ),
              ],
              // const _RowDivider(),
              const _SectionHeader(label: NotificationData.thisWeekLabel),
              for (var i = 0; i < state.thisWeek.length; i++) ...[
                _NotificationTile(notification: state.thisWeek[i]),
                if (i != state.thisWeek.length - 1) const _RowDivider(),
              ],
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'GeneralSans-Medium',
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
          color: KolekColors.neutral900,
        ),
      ),
    );
  }
}

class _RowDivider extends StatelessWidget {
  const _RowDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      thickness: 1,
      color: KolekColors.neutral200,
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.notification});

  final AppNotification notification;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 16, 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: notification.isUnread
                      ? KolekColors.blue600
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(width: 10),
            ClipOval(
              child: Image.asset(
                notification.avatarAsset,
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
                    notification.author,
                    style: const TextStyle(
                      fontFamily: 'GeneralSans-Medium',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: KolekColors.neutral900,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    notification.action,
                    style: const TextStyle(
                      fontFamily: 'GeneralSans-Regular',
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: KolekColors.neutral500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    notification.timeLabel,
                    style: const TextStyle(
                      fontFamily: 'IBMPlexMono-Regular',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: KolekColors.neutral400,
                    ),
                  ),
                  if (notification.commentPreview != null) ...[
                    const SizedBox(height: 10),
                    _CommentPreview(
                      text: notification.commentPreview!,
                      onReply: () {},
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            _Trailing(notification: notification),
          ],
        ),
      ),
    );
  }
}

class _CommentPreview extends StatelessWidget {
  const _CommentPreview({
    required this.text,
    required this.onReply,
  });

  final String text;
  final VoidCallback onReply;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 2,
          height: 34,
          color: KolekColors.neutral300,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: text,
                  style: const TextStyle(
                    fontFamily: 'GeneralSans-Regular',
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: KolekColors.neutral500,
                    height: 1.35,
                  ),
                ),
                const TextSpan(text: '  '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: GestureDetector(
                    onTap: onReply,
                    child: const Text(
                      'Reply',
                      style: TextStyle(
                        fontFamily: 'GeneralSans-Medium',
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
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

class _Trailing extends StatelessWidget {
  const _Trailing({required this.notification});

  final AppNotification notification;

  @override
  Widget build(BuildContext context) {
    switch (notification.kind) {
      case NotificationKind.follow:
      case NotificationKind.following:
        return _FollowButton(
          following: notification.isFollowing,
          onPressed: () =>
              context
                  .read<NotificationBloc>()
                  .add(NotificationFollowToggled(notification.id)),
        );
      case NotificationKind.like:
      case NotificationKind.comment:
        final thumb = notification.thumbnailAsset;
        if (thumb == null) return const SizedBox.shrink();
        return ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.asset(
            thumb,
            width: 48,
            height: 48,
            fit: BoxFit.cover,
          ),
        );
    }
  }
}

class _FollowButton extends StatelessWidget {
  const _FollowButton({
    required this.following,
    required this.onPressed,
  });

  final bool following;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    if (following) {
      return SizedBox(
        height: 34,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: KolekColors.blue600,
            side: const BorderSide(color: KolekColors.blue600, width: 1.2),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            minimumSize: const Size(0, 34),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: const Text(
            'Following',
            style: TextStyle(
              fontFamily: 'GeneralSans-Medium',
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: KolekColors.blue600,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: 34,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: KolekColors.blue600,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          minimumSize: const Size(0, 34),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: const Text(
          'Follow',
          style: TextStyle(
            fontFamily: 'GeneralSans-Medium',
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
