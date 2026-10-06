part of 'list_product_screen.dart';

/// Heading, dash, subtext on the left; illustration on the right.
class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);

    return SizedBox(
      height: 210,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 16,
            top: 12,
            right: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ListProductData.heading,
                  style: KolekText.sans(
                    size: 52,
                    weight: FontWeight.w600,
                    fontFamily: KolekFonts.generalSansSemibold,
                    height: 1.0,
                    letterSpacing: -2,
                    color: fg,
                  ),
                ),
                const SizedBox(height: 14),
                Container(width: 26, height: 4, color: fg),
                const SizedBox(height: 14),
                Text(
                  ListProductData.subtext,
                  style: KolekText.mono(
                    size: 14,
                    weight: FontWeight.w500,
                    fontFamily: KolekFonts.ibmPlexMono,
                    height: 22 / 14,
                    letterSpacing: -1,
                    color: fg,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: -8,
            top: 0,
            bottom: -4,
            child: Image.asset(
              ListProductData.heroAsset,
              height: 230,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}