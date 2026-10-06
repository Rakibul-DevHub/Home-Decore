// import 'package:flutter/material.dart';
//
// import '../../../routes/app_route.dart';
// import '../../../theme/kolek_colors.dart';
// import '../../../widgets/kolek_widgets.dart';
//
// class CreateScreen extends StatelessWidget {
//   const CreateScreen({super.key});
//
//   void _goToCreatePost(BuildContext context) {
//     Navigator.of(context).pushNamed(AppRoute.newPost);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const _CreateAppBar(),
//               SizedBox(height: 20,),
//               const _HeroSection(),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Column(
//                   children: [
//                     _CreateActionCard(
//                       title: 'Create Post',
//                       subtitle:
//                           'Share photos or videos\nwith your followers.',
//                       onTap: () => _goToCreatePost(context),
//                     ),
//                     const SizedBox(height: 12),
//                     _CreateActionCard(
//                       title: 'List a Product',
//                       subtitle:
//                           'Sell your art or collectibles\nto the kolek community.',
//                       onTap: () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('List a Product coming soon'),
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 24),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _CreateAppBar extends StatelessWidget {
//   const _CreateAppBar();
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(14, 8, 14, 0),
//       child: Row(
//         children: [
//           const KolekTextLogo(height: 30),
//           const Spacer(),
//           GestureDetector(
//             onTap: () => Navigator.of(context).pop(),
//             child: Container(
//               width: 34,
//               height: 34,
//               decoration: const BoxDecoration(
//                 color: Color(0xFF1F1F1F),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.close,
//                 size: 18,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _HeroSection extends StatelessWidget {
//   const _HeroSection();
//
//   static const String _heroAsset = 'assets/images/one_eye_mini_hand2.png';
//   static const double _heroAssetWidth = 229-30;
//   static const double _heroAssetHeight = 231;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 420,
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           Positioned(
//             left: 16,
//             top: 22,
//             child: Text(
//               'Make\nsomething\nworth\nsharing.',
//               style: KolekText.sans(
//                 size: 55,
//                 weight: FontWeight.w600,
//                 height: 1,
//                 letterSpacing: -2.0,
//                 // fontStyle: FontStyle.normal,
//                 fontFamily: KolekFonts.generalSansSemibold,
//               ),
//             ),
//           ),
//           Positioned(
//             left: 16,
//             top: 260,
//             child: Container(
//               width: 28,
//               height: 5,
//               color: KolekColors.neutral900,
//             ),
//           ),
//           Positioned(
//             left: 16,
//             top: 300,
//             child: Text(
//               'Post your art, process,\nor inspiration.\nThe world is watching.',
//               style: KolekText.mono(
//                 size: 11,
//                 weight: FontWeight.w500,
//                 fontFamily: 'IBMPlexMono-Medium',
//               ),
//             ),
//           ),
//           Positioned(
//             right: -03,
//             top: 145,
//             child: Image.asset(
//               _heroAsset,
//               width: _heroAssetWidth,
//               height: _heroAssetHeight,
//               fit: BoxFit.contain,
//               errorBuilder: (_, __, ___) => const SizedBox.shrink(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _CreateActionCard extends StatelessWidget {
//   const _CreateActionCard({
//     required this.title,
//     required this.subtitle,
//     this.onTap,
//   });
//
//   final String title;
//   final String subtitle;
//   final VoidCallback? onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onTap,
//         child: Container(
//           width: double.infinity,
//           padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
//           decoration: BoxDecoration(
//             border: Border.all(color: KolekColors.neutral900, width: 1),
//             color: Colors.white,
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       title,
//                       style: KolekText.sans(
//                         size: 18,
//                         weight: FontWeight.w700,
//                         height: 1.0,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Text(
//                       subtitle,
//                       style: KolekText.mono(
//                         size: 13,
//                         weight: FontWeight.w400,
//                         height: 1.55,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 14),
//               const Icon(
//                 Icons.arrow_forward,
//                 size: 26,
//                 color: KolekColors.neutral900,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
















import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/app_route.dart';
import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../bloc/create_bloc.dart';
import '../bloc/create_event.dart';
import '../bloc/create_state.dart';
import '../data/create_data.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: BlocListener<CreateBloc, CreateState>(
          listenWhen: (prev, next) => prev.lastAction != next.lastAction,
          listener: (context, state) {
            switch (state.lastAction) {
              case CreateAction.post:
                Navigator.of(context).pushNamed(AppRoute.newPost);
                context.read<CreateBloc>().add(const CreateActionHandled());
              // case CreateAction.product:
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     const SnackBar(
              //       content: Text(CreateData.listProductComingSoon),
              //     ),
              //   );

              case CreateAction.product:
                Navigator.of(context).pushNamed(AppRoutes.listProduct);
                context.read<CreateBloc>().add(const CreateActionHandled());

                context.read<CreateBloc>().add(const CreateActionHandled());
              case CreateAction.none:
                break;
            }
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _CreateAppBar(),
                const SizedBox(height: 20),
                const _HeroSection(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _CreateActionCard(
                        title: CreateData.createPostTitle,
                        subtitle: CreateData.createPostSubtitle,
                        onTap: () => context
                            .read<CreateBloc>()
                            .add(const CreatePostRequested()),
                      ),
                      const SizedBox(height: 12),
                      _CreateActionCard(
                        title: CreateData.listProductTitle,
                        subtitle: CreateData.listProductSubtitle,
                        onTap: () => context
                            .read<CreateBloc>()
                            .add(const CreateProductRequested()),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// App bar — logo + close circle
// ─────────────────────────────────────────────────────────────────────────

class _CreateAppBar extends StatelessWidget {
  const _CreateAppBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 0),
      child: Row(
        children: [
          const KolekLogoWithText(height: 35),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                // Inverts with the theme: near-black circle in light mode,
                // near-white circle in dark mode.
                color: AppearancePage.foreground(context),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                size: 18,
                color: AppearancePage.background(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Hero — headline, dash, subtext, decorative image
// ─────────────────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);

    return SizedBox(
      height: 420,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 16,
            top: 22,
            child: Text(
              CreateData.heroHeadline,
              style: KolekText.sans(
                size: 55,
                weight: FontWeight.w600,
                height: 1,
                letterSpacing: -2.0,
                fontFamily: KolekFonts.generalSansSemibold,
                color: fg,
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: 260,
            child: Container(
              width: 28,
              height: 5,
              color: fg,
            ),
          ),
          Positioned(
            left: 16,
            top: 300,
            child: Text(
              CreateData.heroBody,
              style: KolekText.mono(
                size: 11,
                weight: FontWeight.w500,
                fontFamily: 'IBMPlexMono-Medium',
                color: fg,
              ),
            ),
          ),
          Positioned(
            right: -3,
            top: 145,
            child: Image.asset(
              CreateData.heroAsset,
              width: CreateData.heroAssetWidth,
              height: CreateData.heroAssetHeight,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Action card — outlined, arrow on the right
// ─────────────────────────────────────────────────────────────────────────

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
    final fg = AppearancePage.foreground(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
          decoration: BoxDecoration(
            border: Border.all(color: fg, width: 1),
            color: AppearancePage.background(context),
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
                        color: fg,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      subtitle,
                      style: KolekText.mono(
                        size: 13,
                        weight: FontWeight.w400,
                        height: 1.55,
                        color: fg,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Icon(
                Icons.arrow_forward,
                size: 26,
                color: fg,
              ),
            ],
          ),
        ),
      ),
    );
  }
}