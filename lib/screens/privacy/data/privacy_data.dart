/// Identifiers for every switch on the Privacy screen.
enum PrivacyToggleId {
  showActivityStatus,
  showSavedCollection,
  purchaseSaleActivity,
}

/// Identifiers for the tappable rows that navigate elsewhere.
enum PrivacyRowId {
  showActivityStatus,   // second one — "Show Activity Status" for artwork
  comments,
  messages,
  blockedAccounts,
  privacyPolicy,
}

class PrivacyToggle {
  const PrivacyToggle({
    required this.id,
    required this.title,
    required this.subtitle,
  });

  final PrivacyToggleId id;
  final String title;
  final String subtitle;
}

class PrivacyNavRow {
  const PrivacyNavRow({
    required this.id,
    required this.title,
    required this.subtitle,
  });

  final PrivacyRowId id;
  final String title;
  final String subtitle;
}

class PrivacySection {
  const PrivacySection({required this.label, required this.rows});

  final String label;

  /// Each entry is either a [PrivacyToggle] or a [PrivacyNavRow] —
  /// rendered accordingly.
  final List<Object> rows;
}

abstract final class PrivacyData {
  static const appBarTitle = 'Privacy';
  static const subtitle =
      'Control how your profile and activity appear on Kolek.';

  static const sections = <PrivacySection>[
    PrivacySection(
      label: 'ACTIVITY',
      rows: [
        PrivacyToggle(
          id: PrivacyToggleId.showActivityStatus,
          title: 'Show Activity Status',
          subtitle:
          'Allow people you message to see\nwhen you\'re active on Kolek.',
        ),
        PrivacyNavRow(
          id: PrivacyRowId.showActivityStatus,
          title: 'Show Activity Status',
          subtitle:
          'Allow others to see artwork and posts\nyou\'ve liked.',
        ),
        PrivacyToggle(
          id: PrivacyToggleId.showSavedCollection,
          title: 'Show Saved Collection',
          subtitle:
          'Allow others to see artwork you\'ve\npublicly saved or collected.',
        ),
      ],
    ),
    PrivacySection(
      label: 'INTERACTIONS',
      rows: [
        PrivacyNavRow(
          id: PrivacyRowId.comments,
          title: 'Comments',
          subtitle: 'Choose who can comment on your posts.',
        ),
        PrivacyNavRow(
          id: PrivacyRowId.messages,
          title: 'Messages',
          subtitle: 'Choose who can send you messages.',
        ),
      ],
    ),
    PrivacySection(
      label: 'BLOCKED ACCOUNTS',
      rows: [
        PrivacyNavRow(
          id: PrivacyRowId.blockedAccounts,
          title: 'Blocked Account',
          subtitle: 'Manage account you\'ve blocked on kolek',
        ),
      ],
    ),
    PrivacySection(
      label: 'MARKETPLACE',
      rows: [
        PrivacyToggle(
          id: PrivacyToggleId.purchaseSaleActivity,
          title: 'Purchase & Sale Activity',
          subtitle:
          'Control whether completed purchases and\nsales appear publicly on your profile.',
        ),
        PrivacyNavRow(
          id: PrivacyRowId.privacyPolicy,
          title: 'Privacy Policy',
          subtitle: '',
        ),
      ],
    ),
  ];

  static const initialToggleValues = <PrivacyToggleId, bool>{
    PrivacyToggleId.showActivityStatus: true,
    PrivacyToggleId.showSavedCollection: true,
    PrivacyToggleId.purchaseSaleActivity: true,
  };
}