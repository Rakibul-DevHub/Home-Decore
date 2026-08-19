class OnboardingPageData {
  const OnboardingPageData({required this.image});

  final String image;
}

abstract final class OnboardingData {
  static const skip = 'Skip';
  static const getStarted = 'Get Started';
  static const arrowAsset = 'assets/icons/arrow_right.svg';

  static const fontFamily = 'IBMPlexMono-Regular';
  static const getStartedFontFamily = 'GeneralSans-Regular';

  static const pages = [
    OnboardingPageData(image: 'assets/images/onboarding_1.png'),
    OnboardingPageData(image: 'assets/images/onboarding_2.png'),
    OnboardingPageData(image: 'assets/images/onboarding_3.png'),
    OnboardingPageData(image: 'assets/images/onboarding_4.png'),
    OnboardingPageData(image: 'assets/images/onboarding_5.png'),
  ];
}
