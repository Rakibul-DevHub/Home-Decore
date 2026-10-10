class BlockedUser {
  const BlockedUser({
    required this.id,
    required this.name,
    required this.blockedOnLabel,
    required this.avatarAsset,
  });

  final String id;
  final String name;

  /// Human-readable date, e.g. "Sep 18, 2026".
  final String blockedOnLabel;

  final String avatarAsset;
}

abstract final class BlockedAccountsData {
  static const appBarTitle = 'Blocked Accounts';
  static const heading = 'Manage accounts you\'ve blocked on Kolek';
  static const description =
      'Review and manage the people you\'ve blocked. Blocked accounts '
      'can\'t view your profile, message you, or interact with your posts.';

  static const searchHint = 'Search';
  static const sectionLabel = 'BLOCKED ACCOUNTS';
  static const unblockLabel = 'Unblock';
  static const blockedOnPrefix = 'Blocked on : ';

  static const emptyMessage = 'No blocked accounts';
  static const noResultsMessage = 'No matches';

  /// Seed list — a batch of the same demo user, matching the design.
  static const users = <BlockedUser>[
    BlockedUser(
      id: 'u1',
      name: 'Courtney Henry',
      blockedOnLabel: 'Sep 18, 2026',
      avatarAsset: 'assets/images/demo_user.png',
    ),
    BlockedUser(
      id: 'u2',
      name: 'Courtney Henry',
      blockedOnLabel: 'Sep 18, 2026',
      avatarAsset: 'assets/images/demo_user.png',
    ),
    BlockedUser(
      id: 'u3',
      name: 'Courtney Henry',
      blockedOnLabel: 'Sep 18, 2026',
      avatarAsset: 'assets/images/demo_user.png',
    ),
    BlockedUser(
      id: 'u4',
      name: 'Courtney Henry',
      blockedOnLabel: 'Sep 18, 2026',
      avatarAsset: 'assets/images/demo_user.png',
    ),
    BlockedUser(
      id: 'u5',
      name: 'Courtney Henry',
      blockedOnLabel: 'Sep 18, 2026',
      avatarAsset: 'assets/images/demo_user.png',
    ),
    BlockedUser(
      id: 'u6',
      name: 'Courtney Henry',
      blockedOnLabel: 'Sep 18, 2026',
      avatarAsset: 'assets/images/demo_user.png',
    ),
    BlockedUser(
      id: 'u7',
      name: 'Courtney Henry',
      blockedOnLabel: 'Sep 18, 2026',
      avatarAsset: 'assets/images/demo_user.png',
    ),
  ];
}