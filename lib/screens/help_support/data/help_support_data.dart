/// One row under "Help Topics".
class HelpTopic {
  const HelpTopic({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.iconAsset,
  });

  final String id;
  final String title;
  final String subtitle;

  /// Path to the SVG under `assets/icons/`.
  final String iconAsset;
}

/// One question under the FAQ section.
class HelpFaq {
  const HelpFaq({required this.id, required this.question});

  final String id;
  final String question;
}

/// One row under the "Still need help?" section.
class HelpReport {
  const HelpReport({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.iconAsset,
  });

  final String id;
  final String title;
  final String subtitle;
  final String iconAsset;
}

abstract final class HelpSupportData {
  static const appBarTitle = 'Help & Support';

  static const searchHint = 'Search for help';

  static const helpTopicsLabel = 'HELP TOPICS';
  static const commonQuestionsLabel = 'COMMON QUESTIONS';
  static const stillNeedHelpLabel = 'STILL NEED HELP?';

  static const contactBody =
      "Get in touch with Kolek Support and we'll help you with your issue.";
  static const contactButtonLabel = 'Contact Support';

  // ─────────────────────────────────────────────────────────────────
  // ⚠️  ICON PATHS ARE PLACEHOLDERS
  //
  //   Swap these for the actual filenames in your `assets/icons/`
  //   folder. If a path doesn't match a real file, the SVG renders as
  //   a blank box.
  // ─────────────────────────────────────────────────────────────────

  static const topics = <HelpTopic>[
    HelpTopic(
      id: 'buying',
      title: 'Buying on Kolek',
      subtitle: 'Purchases, orders, and payments',
      iconAsset: 'assets/icons/cart.svg',       // ← swap
    ),
    HelpTopic(
      id: 'selling',
      title: 'Selling on Kolek',
      subtitle: 'Listings, sales, shipping, and payouts',
      iconAsset: 'assets/icons/selling.svg',    // ← swap
    ),
    HelpTopic(
      id: 'auctions',
      title: 'Auctions & Bidding',
      subtitle: 'Bids, winning auctions, and auction rules',
      iconAsset: 'assets/icons/offer_bid.svg',  // ← swap
    ),
    HelpTopic(
      id: 'account',
      title: 'Account & Profile',
      subtitle: 'Account information, profiles, and security',
      iconAsset: 'assets/icons/profile.svg',    // ← swap
    ),
    HelpTopic(
      id: 'Bids',
      title: 'Bids',
      subtitle: 'Bids, and auction activity',
      iconAsset: 'assets/icons/card.svg',  // ← swap
    ),
    HelpTopic(
      id: 'safety',
      title: 'Safety & Trust',
      subtitle: 'Reporting, blocked accounts, and marketplace safety',
      iconAsset: 'assets/icons/shild.svg',     // ← swap
    ),
  ];

  static const faqs = <HelpFaq>[
    HelpFaq(id: 'track_order', question: 'How do I track my order?'),
    HelpFaq(
      id: 'after_win',
      question: 'What happens after I win an auction?',
    ),
    HelpFaq(id: 'payouts', question: 'How do seller payouts work?'),
    HelpFaq(
      id: 'report_purchase',
      question: 'How do I report a problem with a purchase?',
    ),
  ];

  static const reports = <HelpReport>[
    HelpReport(
      id: 'report_problem',
      title: 'Report a Problem',
      subtitle: "Let us know if something isn't working correctly.",
      iconAsset: 'assets/icons/report.svg',
    ),
    HelpReport(
      id: 'report_safety',
      title: 'Report a Safety Issue',
      subtitle: 'Report safety concerns or inappropriate behavior.',
      iconAsset: 'assets/icons/safety_report.svg',
    ),
  ];
}