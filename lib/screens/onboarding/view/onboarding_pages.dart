part of 'onboarding_screen.dart';

class _Page1Text extends StatelessWidget {
  const _Page1Text();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Positioned(
          left: 20,
          top: 125,
          width: 400,
          child: Text(
            'Discover\nwhat\nmoves\nyou.',
            style: TextStyle(
              fontFamily: 'IBMPlexMono-Medium',
              fontSize: 40,
              fontWeight: FontWeight.w500,
              color: KolekColors.neutral900,
              height: 52 / 40,
              letterSpacing: 2 / 40,
            ),
          ),
        ),
        Positioned(
          left: 20,
          top: 361,
          width: 400,
          child: Text(
            'REAL PEOPLE.\nREAL FINDS.\nFREOM ALL OVER.',
            style: TextStyle(
              fontFamily: 'IBMPlexMono-Medium',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: KolekColors.neutral700,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}

class _Page1Image extends StatelessWidget {
  const _Page1Image();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _ImageBox(
          top: 492,
          left: 94.5,
          width: 251,
          height: 284,
          path: OnboardingData.pages[0].image,
        ),
      ],
    );
  }
}

class _Page2Text extends StatelessWidget {
  const _Page2Text();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        _PageDivider(top: 519),
        Positioned(
          left: 20,
          top: 536,
          width: 400,
          child: Text(
            'Buy\ndirectly\nfrom\ncreators.',
            style: TextStyle(
              fontFamily: 'IBMPlexMono-Medium',
              fontSize: 40,
              fontWeight: FontWeight.w500,
              color: KolekColors.neutral900,
              height: 1.2,
              letterSpacing: 1.5,
            ),
          ),
        ),
        Positioned(
          left: 20,
          top: 744,
          width: 400,
          child: Text(
            'NO MIDDLEMEN.\nJUST REAL CONNECTIONS.',
            style: TextStyle(
              fontFamily: 'IBMPlexMono-Regular',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: KolekColors.neutral700,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}

class _Page2Image extends StatelessWidget {
  const _Page2Image();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _ImageBox(
          top: 138,
          left: 80.5,
          width: 279,
          height: 375,
          path: OnboardingData.pages[1].image,
        ),
      ],
    );
  }
}

class _Page3Text extends StatelessWidget {
  const _Page3Text();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Positioned(
          left: 20,
          top: 128,
          width: 400,
          child: Text(
            'Sell\nanything\nInstantly.',
            style: TextStyle(
              fontFamily: 'IBMPlexMono-Medium',
              fontSize: 40,
              fontWeight: FontWeight.w500,
              color: KolekColors.neutral900,
              height: 1.25,
              letterSpacing: 1.5,
            ),
          ),
        ),
        _PageDivider(top: 298),
        Positioned(
          left: 20,
          top: 326,
          width: 400,
          child: Text(
            'LIST IN SECONDS.\nREACH THOUSAND OF\nCOLLECTORS.',
            style: TextStyle(
              fontFamily: 'IBMPlexMono-Medium',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: KolekColors.neutral700,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}

class _Page3Image extends StatelessWidget {
  const _Page3Image();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _ImageBox(
          top: 429,
          left: 0,
          width: 440,
          height: 363,
          path: OnboardingData.pages[2].image,
        ),
      ],
    );
  }
}

class _Page4Text extends StatelessWidget {
  const _Page4Text();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        _PageDivider(top: 519),
        Positioned(
          left: 20,
          top: 536,
          width: 400,
          child: Text(
            'Connect.\nChat.\nMake it\nYours',
            style: TextStyle(
              fontFamily: 'IBMPlexMono-Medium',
              fontSize: 40,
              fontWeight: FontWeight.w500,
              color: KolekColors.neutral900,
              height: 1.2,
              letterSpacing: 1.5,
            ),
          ),
        ),
        Positioned(
          left: 20,
          top: 744,
          width: 400,
          child: Text(
            'MESSAGE. NEGOTIATE.\nBUILD COMMUNITY.',
            style: TextStyle(
              fontFamily: 'IBMPlexMono-Regular',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: KolekColors.neutral700,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}

class _Page4Image extends StatelessWidget {
  const _Page4Image();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _ImageBox(
          top: 138,
          left: 103.5,
          width: 233,
          height: 360,
          path: OnboardingData.pages[3].image,
        ),
      ],
    );
  }
}

class _Page5Text extends StatelessWidget {
  const _Page5Text();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Positioned(
          left: 20,
          top: 330,
          child: Text.rich(
            TextSpan(
              style: TextStyle(
                fontFamily: 'IBMPlexMono-Medium',
                fontSize: 40,
                fontWeight: FontWeight.w500,
                height: 1.32,
                letterSpacing: 2 / 40,
                color: KolekColors.neutral900,
              ),
              children: [
                TextSpan(text: 'This is\n'),
                TextSpan(
                  text: 'kolek.',
                  style: TextStyle(color: KolekColors.blue600),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 20,
          top: 450,
          width: 400,
          child: Text(
            'A CURATED WORLD OF\nCREATORS AND COLLECTORS.\nWELCOME IN.',
            style: TextStyle(
              fontFamily: 'IBMPlexMono-Regular',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: KolekColors.neutral700,
              height: 24 / 16,
            ),
          ),
        ),
      ],
    );
  }
}

class _Page5Image extends StatelessWidget {
  const _Page5Image();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          top: 80,
          width: 440,
          height: 697,
          child: Image.asset(
            OnboardingData.pages[4].image,
            width: 440,
            height: 697,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
        ),
      ],
    );
  }
}

class _ImageBox extends StatelessWidget {
  const _ImageBox({
    required this.top,
    required this.left,
    required this.width,
    required this.height,
    required this.path,
  });

  final double top;
  final double left;
  final double width;
  final double height;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      width: width,
      height: height,
      child: Image.asset(
        path,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}

class _PageDivider extends StatelessWidget {
  const _PageDivider({required this.top});

  final double top;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      right: 20,
      top: top,
      child: const Divider(
        height: 1,
        thickness: 1,
        color: KolekColors.neutral200,
      ),
    );
  }
}
