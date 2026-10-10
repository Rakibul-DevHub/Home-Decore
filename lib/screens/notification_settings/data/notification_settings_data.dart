/// Identifiers for each toggle row. Used as event payloads and map keys.
enum NotificationToggleId {
  // Activity
  likes,
  comments,
  newFollowers,
  mentions,
  // Buying & Selling
  offersAndBids,
  orders,
  priceAndListingUpdates,
  // Messages
  messages,
  // From Kolek
  kolekUpdates,
  recommendations,
  // Global
  pushNotifications,
}

class NotificationToggle {
  const NotificationToggle({
    required this.id,
    required this.title,
    required this.subtitle,
  });

  final NotificationToggleId id;
  final String title;
  final String subtitle;
}

class NotificationSection {
  const NotificationSection({
    required this.label,
    required this.toggles,
  });

  final String label;
  final List<NotificationToggle> toggles;
}

abstract final class NotificationSettingsData {
  static const appBarTitle = 'Notification';
  static const subtitle = 'Choose what you want to hear about from Kolek.';

  static const sections = <NotificationSection>[
    NotificationSection(
      label: 'ACTIVITY',
      toggles: [
        NotificationToggle(
          id: NotificationToggleId.likes,
          title: 'Likes',
          subtitle: 'When someone likes your post.',
        ),
        NotificationToggle(
          id: NotificationToggleId.comments,
          title: 'Comments',
          subtitle: 'When someone comments on your post.',
        ),
        NotificationToggle(
          id: NotificationToggleId.newFollowers,
          title: 'New Followers',
          subtitle: 'When someone starts following you.',
        ),
        NotificationToggle(
          id: NotificationToggleId.mentions,
          title: 'Mentions',
          subtitle: 'When someone mentions you.',
        ),
      ],
    ),
    NotificationSection(
      label: 'BUYING & SELLING',
      toggles: [
        NotificationToggle(
          id: NotificationToggleId.offersAndBids,
          title: 'Offers & Bids',
          subtitle: 'Updates about offers and auction activity.',
        ),
        NotificationToggle(
          id: NotificationToggleId.orders,
          title: 'Orders',
          subtitle: 'Updates about purchases, sales, and shipping.',
        ),
        NotificationToggle(
          id: NotificationToggleId.priceAndListingUpdates,
          title: 'Price & Listing Updates',
          subtitle:
          'Important updates about artwork you\'re interested in.',
        ),
      ],
    ),
    NotificationSection(
      label: 'MESSAGES',
      toggles: [
        NotificationToggle(
          id: NotificationToggleId.messages,
          title: 'Messages',
          subtitle: 'Notify me when I receive a new message.',
        ),
      ],
    ),
    NotificationSection(
      label: 'FROM KOLEK',
      toggles: [
        NotificationToggle(
          id: NotificationToggleId.kolekUpdates,
          title: 'Kolek Updates',
          subtitle: 'Important product and community updates.',
        ),
        NotificationToggle(
          id: NotificationToggleId.recommendations,
          title: 'Recommendations',
          subtitle: 'Artists and artwork you may be interested in.',
        ),
      ],
    ),
    // NOTE: the design shows "FROM KOLEK" a second time here, which
    // reads as a copy-paste slip. "GENERAL" is what this section
    // actually is — one global switch that gates all others.
    NotificationSection(
      label: 'GENERAL',
      toggles: [
        NotificationToggle(
          id: NotificationToggleId.pushNotifications,
          title: 'Push Notifications',
          subtitle: '',
        ),
      ],
    ),
  ];

  /// Every toggle starts ON, matching the design.
  static const initialValues = <NotificationToggleId, bool>{
    NotificationToggleId.likes: true,
    NotificationToggleId.comments: true,
    NotificationToggleId.newFollowers: true,
    NotificationToggleId.mentions: true,
    NotificationToggleId.offersAndBids: true,
    NotificationToggleId.orders: true,
    NotificationToggleId.priceAndListingUpdates: true,
    NotificationToggleId.messages: true,
    NotificationToggleId.kolekUpdates: true,
    NotificationToggleId.recommendations: true,
    NotificationToggleId.pushNotifications: true,
  };
}