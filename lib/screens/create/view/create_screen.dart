import 'package:flutter/material.dart';

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
              SizedBox(height: 20,),
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

  static const String _heroAsset = 'assets/images/one_eye_mini_hand2.png';
  static const double _heroAssetWidth = 229-30;
  static const double _heroAssetHeight = 231;

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
              style: KolekText.sans(
                size: 55,
                weight: FontWeight.w600,
                height: 1,
                letterSpacing: -2.0,
                // fontStyle: FontStyle.normal,
                fontFamily: KolekFonts.generalSansSemibold,
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: 260,
            child: Container(
              width: 28,
              height: 5,
              color: KolekColors.neutral900,
            ),
          ),
          Positioned(
            left: 16,
            top: 300,
            child: Text(
              'Post your art, process,\nor inspiration.\nThe world is watching.',
              style: KolekText.mono(
                size: 11,
                weight: FontWeight.w500,
                fontFamily: 'IBMPlexMono-Medium',
              ),
            ),
          ),
          Positioned(
            right: -03,
            top: 145,
            child: Image.asset(
              _heroAsset,
              width: _heroAssetWidth,
              height: _heroAssetHeight,
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
                      style: KolekText.sans(
                        size: 18,
                        weight: FontWeight.w700,
                        height: 1.0,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      subtitle,
                      style: KolekText.mono(
                        size: 13,
                        weight: FontWeight.w400,
                        height: 1.55,
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
