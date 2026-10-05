// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:kolek/routes/app_routes.dart';
//
// import '../../../screens/appearance/appearance_page.dart';
// import '../../../theme/kolek_colors.dart';
// import '../../../widgets/kolek_widgets.dart';
// import '../bloc/profile_bloc.dart';
// import '../bloc/profile_event.dart';
// import '../bloc/profile_state.dart';
// import '../data/profile_data.dart';
//
// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppearancePage.background(context),
//       body: SafeArea(
//         child: CustomScrollView(
//           slivers: [
//             const SliverToBoxAdapter(child: _ProfileAppBar()),
//             const SliverToBoxAdapter(child: _ProfileHeader()),
//             const SliverToBoxAdapter(child: _ProfileActions()),
//             const SliverToBoxAdapter(child: SizedBox(height: 16)),
//             const SliverToBoxAdapter(child: SizedBox(height: 6)),
//             const SliverToBoxAdapter(child: _ProfileTabs()),
//             SliverToBoxAdapter(
//               child: BlocBuilder<ProfileBloc, ProfileState>(
//                 builder: (context, state) {
//                   if (state.tabIndex == 3) {
//                     return const _AboutSection();
//                   }
//                   return const _WorksGrid();
//                 },
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: BlocBuilder<ProfileBloc, ProfileState>(
//                 builder: (context, state) {
//                   if (state.tabIndex == 3) {
//                     return const SizedBox(height: 24);
//                   }
//                   return const _FeaturedWork();
//                 },
//               ),
//             ),
//             const SliverToBoxAdapter(child: SizedBox(height: 24)),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────────────────────────────────
// // App bar
// // ─────────────────────────────────────────────────────────────────────────
//
// class _ProfileAppBar extends StatelessWidget {
//   const _ProfileAppBar();
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(18, 10, 6, 4),
//       child: Row(
//         children: [
//           const KolekTextLogo(height: 22),
//           const Spacer(),
//           IconButton(
//             padding: EdgeInsets.zero,
//             constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
//             onPressed: () {
//               Navigator.pushNamed(context, AppRoutes.menu);
//             },
//             icon: Icon(
//               Icons.menu,
//               size: 22,
//               color: AppearancePage.icon(context),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────────────────────────────────
// // Header — avatar, name, role, stats
// // ─────────────────────────────────────────────────────────────────────────
//
// class _ProfileHeader extends StatelessWidget {
//   const _ProfileHeader();
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(18, 6, 18, 0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     ClipOval(
//                       child: Image.asset(
//                         ProfileData.avatarAsset,
//                         width: 46,
//                         height: 46,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     const SizedBox(width: 20),
//                     Row(
//                       children: [
//                         Container(
//                           width: 6,
//                           height: 6,
//                           decoration: const BoxDecoration(
//                             color: KolekColors.blue600,
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//                         const SizedBox(width: 5),
//                         Text(
//                           ProfileData.location,
//                           style: TextStyle(
//                             fontFamily: 'IBMPlexMono-Regular',
//                             fontSize: 10,
//                             fontWeight: FontWeight.w400,
//                             letterSpacing: 0.8,
//                             color: AppearancePage.secondary(context),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   ProfileData.name,
//                   style: TextStyle(
//                     fontFamily: 'GeneralSans-Medium',
//                     fontSize: 50,
//                     fontWeight: FontWeight.w500,
//                     height: 53 / 50,
//                     letterSpacing: 0,
//                     color: AppearancePage.foreground(context),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   ProfileData.roleLine1,
//                   style: TextStyle(
//                     fontFamily: 'IBMPlexMono-Regular',
//                     fontSize: 10,
//                     fontWeight: FontWeight.w400,
//                     letterSpacing: 0.8,
//                     height: 1.5,
//                     color: AppearancePage.secondary(context),
//                   ),
//                 ),
//                 Text(
//                   ProfileData.roleLine2,
//                   style: TextStyle(
//                     fontFamily: 'IBMPlexMono-Regular',
//                     fontSize: 10,
//                     fontWeight: FontWeight.w400,
//                     letterSpacing: 0.8,
//                     height: 1.5,
//                     color: AppearancePage.secondary(context),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const Padding(
//             padding: EdgeInsets.only(top: 60),
//             child: _StatsColumn(),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _StatsColumn extends StatelessWidget {
//   const _StatsColumn();
//
//   @override
//   Widget build(BuildContext context) {
//     final valueStyle = TextStyle(
//       fontFamily: 'GeneralSans-Medium',
//       fontSize: 16,
//       fontWeight: FontWeight.w500,
//       height: 1.0,
//       letterSpacing: 0,
//       color: AppearancePage.foreground(context),
//     );
//     final labelStyle = TextStyle(
//       fontFamily: 'IBMPlexMono-Regular',
//       fontSize: 12,
//       fontWeight: FontWeight.w400,
//       height: 20 / 12,
//       letterSpacing: 0,
//       color: AppearancePage.muted(context),
//     );
//
//     return SizedBox(
//       width: 78,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _StatItem(
//             value: ProfileData.followers,
//             label: 'FOLLOWERS',
//             valueStyle: valueStyle,
//             labelStyle: labelStyle,
//           ),
//           const SizedBox(height: 4),
//           Divider(
//             height: 12,
//             thickness: 0.5,
//             color: AppearancePage.line(context),
//           ),
//           const SizedBox(height: 2),
//           _StatItem(
//             value: ProfileData.following,
//             label: 'FOLLOWING',
//             valueStyle: valueStyle,
//             labelStyle: labelStyle,
//           ),
//           const SizedBox(height: 4),
//           Divider(
//             height: 12,
//             thickness: 0.5,
//             color: AppearancePage.line(context),
//           ),
//           const SizedBox(height: 2),
//           _StatItem(
//             value: ProfileData.works,
//             label: 'WORKS',
//             valueStyle: valueStyle,
//             labelStyle: labelStyle,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _StatItem extends StatelessWidget {
//   const _StatItem({
//     required this.value,
//     required this.label,
//     required this.valueStyle,
//     required this.labelStyle,
//   });
//
//   final String value;
//   final String label;
//   final TextStyle valueStyle;
//   final TextStyle labelStyle;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(value, style: valueStyle),
//         const SizedBox(height: 1),
//         Text(label, style: labelStyle),
//       ],
//     );
//   }
// }
//
// // ─────────────────────────────────────────────────────────────────────────
// // Actions — Edit Profile / Share Profile
// // ─────────────────────────────────────────────────────────────────────────
//
// class _ProfileActions extends StatelessWidget {
//   const _ProfileActions();
//
//   @override
//   Widget build(BuildContext context) {
//     final style = TextStyle(
//       fontFamily: 'GeneralSans-Medium',
//       fontSize: 12,
//       fontWeight: FontWeight.w500,
//       height: 1.0,
//       letterSpacing: 0,
//       decoration: TextDecoration.underline,
//       decorationStyle: TextDecorationStyle.solid,
//       decorationColor: AppearancePage.foreground(context),
//       color: AppearancePage.foreground(context),
//     );
//
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(18, 14, 18, 0),
//       child: Row(
//         children: [
//           GestureDetector(
//             onTap: () {},
//             child: Text('EDIT PROFILE', style: style),
//           ),
//           const SizedBox(width: 18),
//           GestureDetector(
//             onTap: () {},
//             child: Text('SHARE PROFILE', style: style),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────────────────────────────────
// // Tabs
// // ─────────────────────────────────────────────────────────────────────────
//
// class _ProfileTabs extends StatelessWidget {
//   const _ProfileTabs();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProfileBloc, ProfileState>(
//       builder: (context, state) {
//         return Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: ProfileData.tabHorizontalPadding,
//               ),
//               child: Row(
//                 spacing: ProfileData.tabGap,
//                 children: [
//                   for (var i = 0; i < ProfileData.tabs.length; i++)
//                     _TabItem(
//                       label: ProfileData.tabs[i],
//                       selected: state.tabIndex == i,
//                       onTap: () => context
//                           .read<ProfileBloc>()
//                           .add(ProfileTabSelected(i)),
//                     ),
//                 ],
//               ),
//             ),
//             Divider(
//               height: 1,
//               thickness: 0.5,
//               color: AppearancePage.line(context),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
//
// class _TabItem extends StatelessWidget {
//   const _TabItem({
//     required this.label,
//     required this.selected,
//     required this.onTap,
//   });
//
//   final String label;
//   final bool selected;
//   final VoidCallback onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: SizedBox(
//         height: 40,
//         child: Center(
//           child: IntrinsicWidth(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 10),
//                   child: Text(
//                     label,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontFamily: 'IBMPlexMono-Medium',
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                       height: 1.0,
//                       letterSpacing: 0,
//                       color: selected
//                           ? AppearancePage.foreground(context)
//                           : AppearancePage.muted(context),
//                     ),
//                   ),
//                 ),
//                 AnimatedContainer(
//                   duration: const Duration(milliseconds: 180),
//                   height: 2,
//                   color: selected
//                       ? AppearancePage.foreground(context)
//                       : Colors.transparent,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────────────────────────────────
// // Works grid
// // ─────────────────────────────────────────────────────────────────────────
//
// class _GridTile {
//   const _GridTile({
//     required this.col,
//     required this.colSpan,
//     required this.top,
//     required this.height,
//     required this.imageIndex,
//   });
//
//   final int col;
//   final int colSpan;
//   final double top;
//   final double height;
//   final int imageIndex;
// }
//
// class _WorksGrid extends StatelessWidget {
//   const _WorksGrid();
//
//   static const List<_GridTile> _tiles = [
//     _GridTile(col: 0, colSpan: 2, top: 0.0000, height: 0.3699, imageIndex: 0),
//     _GridTile(col: 2, colSpan: 1, top: 0.0000, height: 0.4274, imageIndex: 1),
//     _GridTile(col: 2, colSpan: 1, top: 0.4411, height: 0.2603, imageIndex: 4),
//     _GridTile(col: 0, colSpan: 3, top: 0.7123, height: 0.2877, imageIndex: 5),
//     _GridTile(col: 0, colSpan: 1, top: 0.3836, height: 0.3918, imageIndex: 2),
//     _GridTile(col: 1, colSpan: 1, top: 0.3836, height: 0.3918, imageIndex: 3),
//   ];
//
//   static const double _gridAspectRatio = 365 / 343;
//
//   @override
//   Widget build(BuildContext context) {
//     const gap = ProfileData.gridGap;
//     final images = ProfileData.gridImages;
//
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           final width = constraints.maxWidth;
//           final cell = (width - gap * 2) / 3;
//           final totalH = width * _gridAspectRatio;
//
//           double x(int col) => col * (cell + gap);
//           double colSpanWidth(int span) => span * cell + (span - 1) * gap;
//
//           return SizedBox(
//             height: totalH,
//             child: Stack(
//               children: [
//                 for (final tile in _tiles)
//                   Positioned(
//                     left: x(tile.col),
//                     top: tile.top * totalH,
//                     width: colSpanWidth(tile.colSpan),
//                     height: tile.height * totalH,
//                     child: _GridImage(asset: images[tile.imageIndex]),
//                   ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class _GridImage extends StatelessWidget {
//   const _GridImage({required this.asset});
//
//   final String asset;
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(ProfileData.cardRadius),
//       child: Image.asset(
//         asset,
//         fit: BoxFit.cover,
//         alignment: Alignment.center,
//         width: double.infinity,
//         height: double.infinity,
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────────────────────────────────
// // Featured work + About
// // ─────────────────────────────────────────────────────────────────────────
//
// class _FeaturedWork extends StatelessWidget {
//   const _FeaturedWork();
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             ProfileData.featuredLabel,
//             style: TextStyle(
//               fontFamily: 'IBMPlexMono-Medium',
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//               color: KolekColors.blue600,
//               fontStyle: FontStyle.normal,
//             ),
//           ),
//           const SizedBox(height: 6),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Expanded(
//                 child: Text(
//                   ProfileData.featuredTitle,
//                   style: TextStyle(
//                     fontFamily: 'GeneralSans-Regular',
//                     fontSize: 20,
//                     fontWeight: FontWeight.w400,
//                     height: 1.1,
//                     color: AppearancePage.foreground(context),
//                   ),
//                 ),
//               ),
//               Text(
//                 ProfileData.featuredPrice,
//                 style: TextStyle(
//                   fontFamily: 'GeneralSans-Regular',
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                   color: AppearancePage.foreground(context),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 6),
//           Text(
//             ProfileData.featuredMedium,
//             style: TextStyle(
//               fontFamily: 'IBMPlexMono-Regular',
//               fontSize: 12,
//               fontWeight: FontWeight.w400,
//               letterSpacing: 0.3,
//               height: 1.4,
//               color: AppearancePage.secondary(context),
//             ),
//           ),
//           const SizedBox(height: 2),
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   ProfileData.featuredSize,
//                   style: TextStyle(
//                     fontFamily: 'IBMPlexMono-Regular',
//                     fontSize: 12,
//                     fontWeight: FontWeight.w400,
//                     letterSpacing: 0.3,
//                     height: 1.4,
//                     color: AppearancePage.secondary(context),
//                   ),
//                 ),
//               ),
//               SvgPicture.asset(
//                 'assets/icons/arrow_forward.svg',
//                 colorFilter: AppearancePage.iconFilter(context),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _AboutSection extends StatelessWidget {
//   const _AboutSection();
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(18, 20, 18, 8),
//       child: Text(
//         ProfileData.aboutBody,
//         style: TextStyle(
//           fontFamily: 'IBMPlexMono-Regular',
//           fontSize: 12,
//           fontWeight: FontWeight.w400,
//           height: 1.5,
//           color: AppearancePage.secondary(context),
//         ),
//       ),
//     );
//   }
// }













import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kolek/routes/app_route.dart';

import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../data/profile_data.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: _ProfileAppBar()),
            const SliverToBoxAdapter(child: _ProfileHeader()),
            const SliverToBoxAdapter(child: _ProfileActions()),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            const SliverToBoxAdapter(child: SizedBox(height: 6)),
            const SliverToBoxAdapter(child: _ProfileTabs()),
            SliverToBoxAdapter(
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state.tabIndex == 3) {
                    return const _AboutSection();
                  }
                  return const _WorksGrid();
                },
              ),
            ),
            SliverToBoxAdapter(
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state.tabIndex == 3) {
                    return const SizedBox(height: 24);
                  }
                  return const _FeaturedWork();
                },
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// App bar
// ─────────────────────────────────────────────────────────────────────────

class _ProfileAppBar extends StatelessWidget {
  const _ProfileAppBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 10, 6, 4),
      child: Row(
        children: [
          const KolekTextLogo(height: 22),
          const Spacer(),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.menu);
            },
            icon: Icon(
              Icons.menu,
              size: 22,
              color: AppearancePage.icon(context),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Header — avatar, name, role, stats
// ─────────────────────────────────────────────────────────────────────────

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 6, 18, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        ProfileData.avatarAsset,
                        width: 46,
                        height: 46,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: KolekColors.blue600,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          ProfileData.location,
                          style: TextStyle(
                            fontFamily: 'IBMPlexMono-Regular',
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.8,
                            color: AppearancePage.secondary(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  ProfileData.name,
                  style: TextStyle(
                    fontFamily: 'GeneralSans-Medium',
                    fontSize: 50,
                    fontWeight: FontWeight.w500,
                    height: 53 / 50,
                    letterSpacing: 0,
                    color: AppearancePage.foreground(context),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  ProfileData.roleLine1,
                  style: TextStyle(
                    fontFamily: 'IBMPlexMono-Regular',
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.8,
                    height: 1.5,
                    color: AppearancePage.secondary(context),
                  ),
                ),
                Text(
                  ProfileData.roleLine2,
                  style: TextStyle(
                    fontFamily: 'IBMPlexMono-Regular',
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.8,
                    height: 1.5,
                    color: AppearancePage.secondary(context),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 60),
            child: _StatsColumn(),
          ),
        ],
      ),
    );
  }
}

class _StatsColumn extends StatelessWidget {
  const _StatsColumn();

  @override
  Widget build(BuildContext context) {
    final valueStyle = TextStyle(
      fontFamily: 'GeneralSans-Medium',
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.0,
      letterSpacing: 0,
      color: AppearancePage.foreground(context),
    );
    final labelStyle = TextStyle(
      fontFamily: 'IBMPlexMono-Regular',
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 20 / 12,
      letterSpacing: 0,
      color: AppearancePage.muted(context),
    );

    return SizedBox(
      width: 78,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _StatItem(
            value: ProfileData.followers,
            label: 'FOLLOWERS',
            valueStyle: valueStyle,
            labelStyle: labelStyle,
          ),
          const SizedBox(height: 4),
          Divider(
            height: 12,
            thickness: 0.5,
            color: AppearancePage.line(context),
          ),
          const SizedBox(height: 2),
          _StatItem(
            value: ProfileData.following,
            label: 'FOLLOWING',
            valueStyle: valueStyle,
            labelStyle: labelStyle,
          ),
          const SizedBox(height: 4),
          Divider(
            height: 12,
            thickness: 0.5,
            color: AppearancePage.line(context),
          ),
          const SizedBox(height: 2),
          _StatItem(
            value: ProfileData.works,
            label: 'WORKS',
            valueStyle: valueStyle,
            labelStyle: labelStyle,
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.value,
    required this.label,
    required this.valueStyle,
    required this.labelStyle,
  });

  final String value;
  final String label;
  final TextStyle valueStyle;
  final TextStyle labelStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: valueStyle),
        const SizedBox(height: 1),
        Text(label, style: labelStyle),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Actions — Edit Profile / Share Profile
// ─────────────────────────────────────────────────────────────────────────

class _ProfileActions extends StatelessWidget {
  const _ProfileActions();

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontFamily: 'GeneralSans-Medium',
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.0,
      letterSpacing: 0,
      decoration: TextDecoration.underline,
      decorationStyle: TextDecorationStyle.solid,
      decorationColor: AppearancePage.foreground(context),
      color: AppearancePage.foreground(context),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Text('EDIT PROFILE', style: style),
          ),
          const SizedBox(width: 18),
          GestureDetector(
            onTap: () {},
            child: Text('SHARE PROFILE', style: style),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Tabs
// ─────────────────────────────────────────────────────────────────────────

class _ProfileTabs extends StatelessWidget {
  const _ProfileTabs();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: ProfileData.tabHorizontalPadding,
              ),
              child: Row(
                spacing: ProfileData.tabGap,
                children: [
                  for (var i = 0; i < ProfileData.tabs.length; i++)
                    _TabItem(
                      label: ProfileData.tabs[i],
                      selected: state.tabIndex == i,
                      onTap: () => context
                          .read<ProfileBloc>()
                          .add(ProfileTabSelected(i)),
                    ),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 0.5,
              color: AppearancePage.line(context),
            ),
          ],
        );
      },
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 40,
        child: Center(
          child: IntrinsicWidth(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'IBMPlexMono-Medium',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 1.0,
                      letterSpacing: 0,
                      color: selected
                          ? AppearancePage.foreground(context)
                          : AppearancePage.muted(context),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  height: 2,
                  color: selected
                      ? AppearancePage.foreground(context)
                      : Colors.transparent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Works grid — staggered layout via flutter_staggered_grid_view
// ─────────────────────────────────────────────────────────────────────────

/// Placement spec for one tile: how many columns it spans, how many
/// "rows" (cells) it spans, and which image from the pool it shows.
class _GridTileSpec {
  const _GridTileSpec({
    required this.crossSpan,
    required this.mainSpan,
    required this.imageIndex,
  });

  final int crossSpan;
  final int mainSpan;
  final int imageIndex;
}

class _WorksGrid extends StatelessWidget {
  const _WorksGrid();

  /// Layout produced by this spec (3-column grid, square cells):
  ///
  ///   +---------+---------+---------+
  ///   |          T0       |   T1    |
  ///   +---------+---------+         |
  ///   |   T2    |   T3    |         |
  ///   |         |         +---------+
  ///   |         |         |   T4    |
  ///   +---------+---------+---------+
  ///   |            T5               |
  ///   +-----------------------------+
  ///
  /// Placement order matters — the staggered grid packs tiles in the order
  /// they appear here, filling the first available slot.
  static const _tiles = <_GridTileSpec>[
    _GridTileSpec(crossSpan: 2, mainSpan: 1, imageIndex: 0), // T0
    _GridTileSpec(crossSpan: 1, mainSpan: 2, imageIndex: 1), // T1
    _GridTileSpec(crossSpan: 1, mainSpan: 2, imageIndex: 2), // T2
    _GridTileSpec(crossSpan: 1, mainSpan: 2, imageIndex: 3), // T3
    _GridTileSpec(crossSpan: 1, mainSpan: 1, imageIndex: 4), // T4
    _GridTileSpec(crossSpan: 3, mainSpan: 1, imageIndex: 5), // T5
  ];

  @override
  Widget build(BuildContext context) {
    final images = ProfileData.gridImages;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      child: StaggeredGrid.count(
        crossAxisCount: 3,
        mainAxisSpacing: ProfileData.gridGap,
        crossAxisSpacing: ProfileData.gridGap,
        children: [
          for (final spec in _tiles)
            StaggeredGridTile.count(
              crossAxisCellCount: spec.crossSpan,
              mainAxisCellCount: spec.mainSpan,
              child: _GridImage(asset: images[spec.imageIndex]),
            ),
        ],
      ),
    );
  }
}

class _GridImage extends StatelessWidget {
  const _GridImage({required this.asset});

  final String asset;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(ProfileData.cardRadius),
      child: Image.asset(
        asset,
        fit: BoxFit.cover,
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Featured work + About
// ─────────────────────────────────────────────────────────────────────────

class _FeaturedWork extends StatelessWidget {
  const _FeaturedWork();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            ProfileData.featuredLabel,
            style: TextStyle(
              fontFamily: 'IBMPlexMono-Medium',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: KolekColors.blue600,
              fontStyle: FontStyle.normal,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  ProfileData.featuredTitle,
                  style: TextStyle(
                    fontFamily: 'GeneralSans-Regular',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    height: 1.1,
                    color: AppearancePage.foreground(context),
                  ),
                ),
              ),
              Text(
                ProfileData.featuredPrice,
                style: TextStyle(
                  fontFamily: 'GeneralSans-Regular',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppearancePage.foreground(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            ProfileData.featuredMedium,
            style: TextStyle(
              fontFamily: 'IBMPlexMono-Regular',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.3,
              height: 1.4,
              color: AppearancePage.secondary(context),
            ),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Expanded(
                child: Text(
                  ProfileData.featuredSize,
                  style: TextStyle(
                    fontFamily: 'IBMPlexMono-Regular',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.3,
                    height: 1.4,
                    color: AppearancePage.secondary(context),
                  ),
                ),
              ),
              SvgPicture.asset(
                'assets/icons/arrow_forward.svg',
                colorFilter: AppearancePage.iconFilter(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 8),
      child: Text(
        ProfileData.aboutBody,
        style: TextStyle(
          fontFamily: 'IBMPlexMono-Regular',
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: AppearancePage.secondary(context),
        ),
      ),
    );
  }
}