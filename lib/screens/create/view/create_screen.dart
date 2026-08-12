import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_route.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  void _goToCreatePost(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoute.newPost);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _CreateAppBar(),
              const _HeroSection(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _CreateActionCard(
                      title: 'Create Post',
                      subtitle:
                      'Share photos or videos\nwith your followers.',
                      onTap: () => _goToCreatePost(context),
                    ),
                    const SizedBox(height: 12),
                    _CreateActionCard(
                      title: 'List a Product',
                      subtitle:
                      'Sell your art or collectibles\nto the kolek community.',
                      onTap: () {
                        // TODO: Replace with real navigation when ready
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('List a Product coming soon'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _CreateAppBar extends StatelessWidget {
  const _CreateAppBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 0),
      child: Row(
        children: [
          const KolekTextLogo(height: 30),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 34,
              height: 34,
              decoration: const BoxDecoration(
                color: Color(0xFF1F1F1F),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                size: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  static const String _heroAsset = 'assets/images/one_eye_mini_hand.png';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 16,
            top: 22,
            child: Text(
              'Make\nsomething\nworth\nsharing.',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 49,
                height: 0.92,
                fontWeight: FontWeight.w900,
                color: KolekColors.neutral900,
                letterSpacing: -2.0,
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: 265,
            child: Text(
              'Post your art, process,\nor inspiration.\nThe world is watching.',
              style: GoogleFonts.ibmPlexMono(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: KolekColors.neutral900,
              ),
            ),
          ),
          Positioned(
            right: -22,
            top: 116,
            width: 200,
            child: Image.asset(
              _heroAsset,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}

class _CreateActionCard extends StatelessWidget {
  const _CreateActionCard({
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
          decoration: BoxDecoration(
            border: Border.all(color: KolekColors.neutral900, width: 1),
            color: Colors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        height: 1.0,
                        fontWeight: FontWeight.w700,
                        color: KolekColors.neutral900,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontFamily: 'Courier',
                        fontSize: 13,
                        height: 1.55,
                        color: KolekColors.neutral900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              const Icon(
                Icons.arrow_forward,
                size: 26,
                color: KolekColors.neutral900,
              ),
            ],
          ),
        ),
      ),
    );
  }
}