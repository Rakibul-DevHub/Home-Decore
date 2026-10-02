// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../screens/appearance/appearance_page.dart';
// import '../../../theme/kolek_colors.dart';
// import '../bloc/notification_bloc.dart';
// import '../bloc/notification_event.dart';
// import '../bloc/notification_state.dart';
// import '../data/notification_data.dart';
//
// class NotificationScreen extends StatelessWidget {
//   const NotificationScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppearancePage.background(context),
//       appBar: AppBar(
//         backgroundColor: AppearancePage.menu(context),
//         scrolledUnderElevation: 0,
//         leading: IconButton(
//           onPressed: () => Navigator.of(context).pop(),
//           icon: Icon(
//             Icons.arrow_back,
//             size: 22,
//             color: AppearancePage.foreground(context),
//           ),
//         ),
//         centerTitle: true,
//         title: const Text(
//           NotificationData.title,
//           style: TextStyle(
//             fontFamily: 'GeneralSans-Medium',
//             fontSize: 20,
//             fontWeight: FontWeight.w500,
//             color: KolekColors.blue600,
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: Container(
//               width: 28,
//               height: 28,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: AppearancePage.foreground(context),
//                   width: 1.2,
//                 ),
//               ),
//               child: Icon(
//                 Icons.more_horiz,
//                 size: 18,
//                 color: AppearancePage.foreground(context),
//               ),
//             ),
//           ),
//           const SizedBox(width: 6),
//         ],
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(1),
//           child: Divider(
//             height: 1,
//             thickness: 1,
//             color: AppearancePage.line(context),
//           ),
//         ),
//       ),
//       body: BlocBuilder<NotificationBloc, NotificationState>(
//         builder: (context, state) {
//           return ListView(
//             children: [
//               const _SectionHeader(label: NotificationData.todayLabel),
//               for (var i = 0; i < state.today.length; i++) ...[
//                 _NotificationTile(notification: state.today[i]),
//                 if (i != state.today.length - 1)
//                   const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 8.0),
//                     child: _RowDivider(),
//                   ),
//               ],
//               const _SectionHeader(label: NotificationData.thisWeekLabel),
//               for (var i = 0; i < state.thisWeek.length; i++) ...[
//                 _NotificationTile(notification: state.thisWeek[i]),
//                 if (i != state.thisWeek.length - 1) const _RowDivider(),
//               ],
//               const SizedBox(height: 24),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
//
// class _SectionHeader extends StatelessWidget {
//   const _SectionHeader({required this.label});
//
//   final String label;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
//       child: Text(
//         label,
//         style: TextStyle(
//           fontFamily: 'GeneralSans-Medium',
//           fontSize: 13,
//           fontWeight: FontWeight.w600,
//           letterSpacing: 0.4,
//           color: AppearancePage.foreground(context),
//         ),
//       ),
//     );
//   }
// }
//
// class _RowDivider extends StatelessWidget {
//   const _RowDivider();
//
//   @override
//   Widget build(BuildContext context) {
//     return Divider(
//       height: 1,
//       thickness: 1,
//       color: AppearancePage.line(context),
//     );
//   }
// }
//
// class _NotificationTile extends StatelessWidget {
//   const _NotificationTile({required this.notification});
//
//   final AppNotification notification;
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: AppearancePage.menu(context),
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(14, 14, 16, 14),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 18),
//               child: Container(
//                 width: 8,
//                 height: 8,
//                 decoration: BoxDecoration(
//                   color: notification.isUnread
//                       ? KolekColors.blue600
//                       : Colors.transparent,
//                   shape: BoxShape.circle,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 10),
//             ClipOval(
//               child: Image.asset(
//                 notification.avatarAsset,
//                 width: 44,
//                 height: 44,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     notification.author,
//                     style: TextStyle(
//                       fontFamily: 'GeneralSans-Medium',
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                       color: AppearancePage.foreground(context),
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     notification.action,
//                     style: TextStyle(
//                       fontFamily: 'GeneralSans-Regular',
//                       fontSize: 13,
//                       fontWeight: FontWeight.w400,
//                       color: AppearancePage.secondary(context),
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     notification.timeLabel,
//                     style: TextStyle(
//                       fontFamily: 'IBMPlexMono-Regular',
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       color: AppearancePage.muted(context),
//                     ),
//                   ),
//                   if (notification.commentPreview != null) ...[
//                     const SizedBox(height: 10),
//                     _CommentPreview(
//                       text: notification.commentPreview!,
//                       onReply: () {},
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//             const SizedBox(width: 12),
//             _Trailing(notification: notification),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _CommentPreview extends StatelessWidget {
//   const _CommentPreview({
//     required this.text,
//     required this.onReply,
//   });
//
//   final String text;
//   final VoidCallback onReply;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           width: 2,
//           height: 34,
//           color: AppearancePage.line(context),
//         ),
//         const SizedBox(width: 8),
//         Expanded(
//           child: Text.rich(
//             TextSpan(
//               children: [
//                 TextSpan(
//                   text: text,
//                   style: TextStyle(
//                     fontFamily: 'GeneralSans-Regular',
//                     fontSize: 13,
//                     fontWeight: FontWeight.w400,
//                     color: AppearancePage.secondary(context),
//                     height: 1.35,
//                   ),
//                 ),
//                 const TextSpan(text: '  '),
//                 WidgetSpan(
//                   alignment: PlaceholderAlignment.baseline,
//                   baseline: TextBaseline.alphabetic,
//                   child: GestureDetector(
//                     onTap: onReply,
//                     child: const Text(
//                       'Reply',
//                       style: TextStyle(
//                         fontFamily: 'GeneralSans-Medium',
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                         color: KolekColors.blue600,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _Trailing extends StatelessWidget {
//   const _Trailing({required this.notification});
//
//   final AppNotification notification;
//
//   @override
//   Widget build(BuildContext context) {
//     switch (notification.kind) {
//       case NotificationKind.follow:
//       case NotificationKind.following:
//         return _FollowButton(
//           following: notification.isFollowing,
//           onPressed: () => context
//               .read<NotificationBloc>()
//               .add(NotificationFollowToggled(notification.id)),
//         );
//       case NotificationKind.like:
//       case NotificationKind.comment:
//         final thumb = notification.thumbnailAsset;
//         if (thumb == null) return const SizedBox.shrink();
//         return ClipRRect(
//           borderRadius: BorderRadius.circular(6),
//           child: Image.asset(
//             thumb,
//             width: 48,
//             height: 48,
//             fit: BoxFit.cover,
//           ),
//         );
//     }
//   }
// }
//
// class _FollowButton extends StatelessWidget {
//   const _FollowButton({
//     required this.following,
//     required this.onPressed,
//   });
//
//   final bool following;
//   final VoidCallback onPressed;
//
//   @override
//   Widget build(BuildContext context) {
//     if (following) {
//       return SizedBox(
//         height: 34,
//         child: OutlinedButton(
//           onPressed: onPressed,
//           style: OutlinedButton.styleFrom(
//             foregroundColor: KolekColors.blue600,
//             side: const BorderSide(color: KolekColors.blue600, width: 1.2),
//             padding: const EdgeInsets.symmetric(horizontal: 14),
//             minimumSize: const Size(0, 34),
//             tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(6),
//             ),
//           ),
//           child: const Text(
//             'Following',
//             style: TextStyle(
//               fontFamily: 'GeneralSans-Medium',
//               fontSize: 13,
//               fontWeight: FontWeight.w500,
//               color: KolekColors.blue600,
//             ),
//           ),
//         ),
//       );
//     }
//
//     return SizedBox(
//       height: 34,
//       child: FilledButton(
//         onPressed: onPressed,
//         style: FilledButton.styleFrom(
//           backgroundColor: KolekColors.blue600,
//           foregroundColor: Colors.white,
//           padding: const EdgeInsets.symmetric(horizontal: 18),
//           minimumSize: const Size(0, 34),
//           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(6),
//           ),
//         ),
//         child: const Text(
//           'Follow',
//           style: TextStyle(
//             fontFamily: 'GeneralSans-Medium',
//             fontSize: 13,
//             fontWeight: FontWeight.w500,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }




///
///
///
/// todO:: replay has teh comment input box
///
///
///



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_event.dart';
import '../bloc/notification_state.dart';
import '../data/notification_data.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  static const _composerAvatar = 'assets/images/demo_user.png';

  final _composer = TextEditingController();
  final _composerFocus = FocusNode();
  AppNotification? _replyTo;

  @override
  void dispose() {
    _composer.dispose();
    _composerFocus.dispose();
    super.dispose();
  }

  void _startReply(AppNotification notification) {
    setState(() => _replyTo = notification);
    // Request focus on the next frame so the composer widget is already
    // in the tree when the keyboard opens.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _composerFocus.requestFocus();
    });
  }

  void _clearReply() {
    setState(() => _replyTo = null);
  }

  void _submit() {
    final text = _composer.text.trim();
    if (text.isEmpty) return;
    // TODO: hook into a real handler (bloc event / API call) when available.
    _composer.clear();
    setState(() => _replyTo = null);
    _composerFocus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      appBar: AppBar(
        backgroundColor: AppearancePage.menu(context),
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back,
            size: 22,
            color: AppearancePage.foreground(context),
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
                border: Border.all(
                  color: AppearancePage.foreground(context),
                  width: 1.2,
                ),
              ),
              child: Icon(
                Icons.more_horiz,
                size: 18,
                color: AppearancePage.foreground(context),
              ),
            ),
          ),
          const SizedBox(width: 6),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: AppearancePage.line(context),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, state) {
                return ListView(
                  children: [
                    const _SectionHeader(label: NotificationData.todayLabel),
                    for (var i = 0; i < state.today.length; i++) ...[
                      _NotificationTile(
                        notification: state.today[i],
                        onReply: () => _startReply(state.today[i]),
                      ),
                      if (i != state.today.length - 1)
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: _RowDivider(),
                        ),
                    ],
                    const _SectionHeader(
                      label: NotificationData.thisWeekLabel,
                    ),
                    for (var i = 0; i < state.thisWeek.length; i++) ...[
                      _NotificationTile(
                        notification: state.thisWeek[i],
                        onReply: () => _startReply(state.thisWeek[i]),
                      ),
                      if (i != state.thisWeek.length - 1)
                        const _RowDivider(),
                    ],
                    const SizedBox(height: 24),
                  ],
                );
              },
            ),
          ),
          if (_replyTo != null)
            _NotificationComposer(
              avatarAsset: _composerAvatar,
              controller: _composer,
              focusNode: _composerFocus,
              replyToUsername: _replyTo!.author,
              onSubmit: _submit,
              onClearMention: _clearReply,
            ),
        ],
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
        style: TextStyle(
          fontFamily: 'GeneralSans-Medium',
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
          color: AppearancePage.foreground(context),
        ),
      ),
    );
  }
}

class _RowDivider extends StatelessWidget {
  const _RowDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: AppearancePage.line(context),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({
    required this.notification,
    required this.onReply,
  });

  final AppNotification notification;
  final VoidCallback onReply;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppearancePage.menu(context),
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
                    style: TextStyle(
                      fontFamily: 'GeneralSans-Medium',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppearancePage.foreground(context),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    notification.action,
                    style: TextStyle(
                      fontFamily: 'GeneralSans-Regular',
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppearancePage.secondary(context),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    notification.timeLabel,
                    style: TextStyle(
                      fontFamily: 'IBMPlexMono-Regular',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppearancePage.muted(context),
                    ),
                  ),
                  if (notification.commentPreview != null) ...[
                    const SizedBox(height: 10),
                    _CommentPreview(
                      text: notification.commentPreview!,
                      onReply: onReply,
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
          color: AppearancePage.line(context),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: text,
                  style: TextStyle(
                    fontFamily: 'GeneralSans-Regular',
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: AppearancePage.secondary(context),
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
          onPressed: () => context
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

/// Bottom-pinned composer for replying to a notification's comment preview.
///
/// Visually mirrors the composer used in the comments modal, but lives in
/// its own file/screen. Shown only while [_NotificationScreenState._replyTo]
/// is non-null — tapping "Reply" on any comment preview reveals it and
/// focuses the field so the keyboard opens immediately.
class _NotificationComposer extends StatelessWidget {
  const _NotificationComposer({
    required this.avatarAsset,
    required this.controller,
    required this.focusNode,
    required this.onSubmit,
    required this.onClearMention,
    this.replyToUsername,
  });

  final String avatarAsset;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? replyToUsername;
  final VoidCallback onSubmit;
  final VoidCallback onClearMention;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;

    return Material(
      color: AppearancePage.menu(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: AppearancePage.line(context)),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 12, 20, 12 + bottom),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.asset(
                  avatarAsset,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.only(left: 16, right: 4),
                  decoration: BoxDecoration(
                    color: AppearancePage.field(context),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: AppearancePage.line(context)),
                  ),
                  child: Row(
                    children: [
                      if (replyToUsername != null) ...[
                        Text(
                          '@$replyToUsername',
                          style: TextStyle(
                            fontFamily: 'GeneralSans-Semibold',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppearancePage.foreground(context),
                          ),
                        ),
                        const SizedBox(width: 6),
                      ],
                      Expanded(
                        child: Focus(
                          onKeyEvent: (node, event) {
                            // Backspace on an empty field clears the @mention
                            // rather than deleting text.
                            if (replyToUsername != null &&
                                controller.text.isEmpty &&
                                event is KeyDownEvent &&
                                event.logicalKey ==
                                    LogicalKeyboardKey.backspace) {
                              onClearMention();
                              return KeyEventResult.handled;
                            }
                            return KeyEventResult.ignored;
                          },
                          child: TextField(
                            controller: controller,
                            focusNode: focusNode,
                            textInputAction: TextInputAction.send,
                            onSubmitted: (_) => onSubmit(),
                            cursorColor: AppearancePage.foreground(context),
                            style: TextStyle(
                              fontFamily: 'IBMPlexMono-Regular',
                              fontSize: 14,
                              color: AppearancePage.foreground(context),
                            ),
                            decoration: InputDecoration(
                              isCollapsed: true,
                              border: InputBorder.none,
                              hintText: replyToUsername == null
                                  ? 'Write a reply...'
                                  : 'Add a comment',
                              hintStyle: TextStyle(
                                fontFamily: 'IBMPlexMono-Regular',
                                fontSize: 14,
                                color: AppearancePage.muted(context),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Material(
                        color: const Color(0xFF2B7FFF),
                        shape: const CircleBorder(),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: onSubmit,
                          child: const SizedBox(
                            width: 32,
                            height: 32,
                            child: Icon(
                              Icons.arrow_upward,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}