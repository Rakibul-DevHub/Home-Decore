/// A single entry under the "What You Can Do" section.
class AboutFeature {
  const AboutFeature({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;
}

abstract final class AboutData {
  static const appBarTitle = 'About Kolek';

  // ── Hero ───────────────────────────────────────────────────────────
  static const heroTitle = 'Kolek';
  static const heroLead =
      'A new way to discover, collect, and connect\nthrough art.';
  static const heroBody =
      'Kolek is a social marketplace built around art and\n'
      'the people who love it. Discover artists and\n'
      'artwork, follow people whose taste inspires you,\n'
      'share what you find, build your collection, and buy\n'
      'or sell work directly through the community.';

  // ── Sections ───────────────────────────────────────────────────────
  static const whatYouCanDoLabel = 'WHAT YOU CAN DO';
  static const ourMissionLabel = 'OUR MISSION';
  static const questionsLabel = 'QUESTIONS ABOUT KOLEK?';

  static const features = <AboutFeature>[
    AboutFeature(
      title: 'Discover',
      description:
      'Find artwork, artists, and collections from across the kolek community.',
    ),
    AboutFeature(
      title: 'Connect',
      description:
      'Follow artists, collectors, and people whose taste inspires you.',
    ),
    AboutFeature(
      title: 'Collect',
      description:
      'Save your favorite work and build a collection that reflects your taste',
    ),
    AboutFeature(
      title: 'Buy',
      description:
      'Purchase artwork directly or participate in auctions.',
    ),
    AboutFeature(
      title: 'Sell',
      description:
      'List artwork for sale and connect with collectors.',
    ),
    AboutFeature(
      title: 'Share',
      description:
      'Post artwork, discoveries, and inspiration with the community.',
    ),
  ];

  static const missionParagraphs = <String>[
    'Kolek exists to make discovering and collecting\n'
        'art more accessible, social, and connected.',
    'We believe finding art should feel personal—not\n'
        'intimidating—and that artists and collectors\n'
        'should have a better way to find each other.',
  ];

  static const questionsBody = 'For more information or support, email:';
  static const supportEmail = 'help@kolek.io';
}