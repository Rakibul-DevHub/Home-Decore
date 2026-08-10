class OnboardingPageData {
  const OnboardingPageData({
    required this.title,
    required this.description,
    required this.image,
  });

  final String title;
  final String description;
  final String image;
}

abstract final class OnboardingData {
  static const skip = 'Skip';
  static const getStarted = 'Get Started';
  static const arrowAsset = 'assets/icons/arrow_right.svg';

  static const pages = [
    OnboardingPageData(
      title: 'Discover\nwhat\nmoves\nyou.',
      description: 'REAL PEOPLE.\nREAL FINDS.\nFREOM ALL OVER.',
      image: 'assets/images/onboarding_1.png',
    ),
    OnboardingPageData(
      title: 'Buy\ndirectly\nfrom\ncreators.',
      description: 'NO MIDDLEMEN.\nJUST REAL CONNECTIONS.',
      image: 'assets/images/onboarding_2.png',
    ),
    OnboardingPageData(
      title: 'Sell\nanything\nInstantly.',
      description: 'LIST IN SECONDS.\nREACH THOUSAND OF\nCOLLECTORS.',
      image: 'assets/images/onboarding_3.png',
    ),
    OnboardingPageData(
      title: 'Connect.\nChat.\nMake it\nYours',
      description: 'MESSAGE. NEGOTIATE.\nBUILD COMMUNITY.',
      image: 'assets/images/onboarding_4.png',
    ),
    OnboardingPageData(
      title: 'This is\nkolek.',
      description: 'A CURATED WORLD OF\nCREATORS AND COLLECTORS.\nWELCOME IN.',
      image: 'assets/images/onboarding_5.png',
    ),
  ];
}
