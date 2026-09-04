enum NotificationKind {
  like,
  follow,
  comment,
  following,
}

class AppNotification {
  const AppNotification({
    required this.id,
    required this.author,
    required this.action,
    required this.timeLabel,
    required this.kind,
    this.avatarAsset = NotificationData.avatarAsset,
    this.thumbnailAsset,
    this.commentPreview,
    this.isUnread = true,
    this.isFollowing = false,
  });

  final String id;
  final String author;
  final String action;
  final String timeLabel;
  final NotificationKind kind;
  final String avatarAsset;
  final String? thumbnailAsset;
  final String? commentPreview;
  final bool isUnread;
  final bool isFollowing;

  AppNotification copyWith({
    bool? isFollowing,
    bool? isUnread,
  }) {
    return AppNotification(
      id: id,
      author: author,
      action: action,
      timeLabel: timeLabel,
      kind: kind,
      avatarAsset: avatarAsset,
      thumbnailAsset: thumbnailAsset,
      commentPreview: commentPreview,
      isUnread: isUnread ?? this.isUnread,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }
}

abstract final class NotificationData {
  static const title = 'Notifications';
  static const todayLabel = 'TODAY';
  static const thisWeekLabel = 'This Week';
  static const avatarAsset = 'assets/images/demo_user.png';
  static const thumbnailAsset = 'assets/images/nordic_vase.png';

  static const today = <AppNotification>[
    AppNotification(
      id: 't1',
      author: 'Alex Morgan',
      action: 'Liked your artwork.',
      timeLabel: '2m',
      kind: NotificationKind.like,
      thumbnailAsset: thumbnailAsset,
    ),
    AppNotification(
      id: 't2',
      author: 'Alex Morgan',
      action: 'Started following you.',
      timeLabel: '2m',
      kind: NotificationKind.follow,
    ),
    AppNotification(
      id: 't3',
      author: 'Alex Morgan',
      action: 'Liked your artwork.',
      timeLabel: '2m',
      kind: NotificationKind.comment,
      thumbnailAsset: thumbnailAsset,
      commentPreview: 'Beautiful composition & Texture.',
    ),
    AppNotification(
      id: 't4',
      author: 'Alex Morgan',
      action: 'Liked your artwork.',
      timeLabel: '2m',
      kind: NotificationKind.like,
      thumbnailAsset: thumbnailAsset,
    ),
    AppNotification(
      id: 't5',
      author: 'Alex Morgan',
      action: 'Liked your artwork.',
      timeLabel: '2m',
      kind: NotificationKind.like,
      thumbnailAsset: thumbnailAsset,
    ),
  ];

  static const thisWeek = <AppNotification>[
    AppNotification(
      id: 'w1',
      author: 'Alex Morgan',
      action: 'Liked your artwork.',
      timeLabel: '2m',
      kind: NotificationKind.like,
      thumbnailAsset: thumbnailAsset,
    ),
    AppNotification(
      id: 'w2',
      author: 'Alex Morgan',
      action: 'Started following you.',
      timeLabel: '2m',
      kind: NotificationKind.following,
      isFollowing: true,
    ),
    AppNotification(
      id: 'w3',
      author: 'Alex Morgan',
      action: 'Liked your artwork.',
      timeLabel: '2m',
      kind: NotificationKind.like,
      thumbnailAsset: thumbnailAsset,
    ),
  ];
}
