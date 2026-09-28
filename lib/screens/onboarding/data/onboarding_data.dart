class OnboardingPageData {
  const OnboardingPageData({
    required this.image,
    required this.textTop,
    required this.imageTop,
  });

  final String image;

  /// Local Y of the title block (Figma "Test" layer, minus status bar).
  final double textTop;

  /// Local Y of the photo (Figma "Image" layer, minus status bar).
  final double imageTop;
}

abstract final class OnboardingData {
  static const skip = 'Skip';
  static const getStarted = 'Get Started';
  static const arrowAsset = 'assets/icons/arrow_right.svg';
  static const arrowAssetDark = 'assets/icons/arrow_right_dark.svg';

  static const fontFamily = 'IBMPlexMono-Regular';
  static const getStartedFontFamily = 'GeneralSans-Medium';

  /// Figma Smart Animate default between onboarding frames.
  static const transitionDuration = Duration(milliseconds: 300);

  static const pages = [
    OnboardingPageData(
      image: 'assets/images/onboarding_1.png',
      textTop: 125,
      imageTop: 492,
    ),
    OnboardingPageData(
      image: 'assets/images/onboarding_2.png',
      textTop: 536,
      imageTop: 138,
    ),
    OnboardingPageData(
      image: 'assets/images/onboarding_3.png',
      textTop: 128,
      imageTop: 429,
    ),
    OnboardingPageData(
      image: 'assets/images/onboarding_4.png',
      textTop: 536,
      imageTop: 138,
    ),
    OnboardingPageData(
      image: 'assets/images/onboarding_5.png',
      textTop: 330,
      imageTop: 80,
    ),
  ];
}
