import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../cubit/profile_cubit.dart';
import '../data/profile_data.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: _ProfileAppBar()),
            const SliverToBoxAdapter(child: _ProfileHeader()),
            const SliverToBoxAdapter(child: _ProfileActions()),
            const SliverToBoxAdapter(child: SizedBox(height: 18)),
            const SliverToBoxAdapter(child: _ProfileTabs()),
            SliverToBoxAdapter(
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state.tabIndex == 3) {
                    return const _AboutSection();
                  }
                  return const _WorksGrid();
                },
              ),
            ),
            SliverToBoxAdapter(
              child: BlocBuilder<ProfileCubit, ProfileState>(
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

class _ProfileAppBar extends StatelessWidget {
  const _ProfileAppBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 10, 8, 8),
      child: Row(
        children: [
          const KolekTextLogo(height: 22),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings_outlined,
              size: 22,
              color: KolekColors.neutral900,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              size: 24,
              color: KolekColors.neutral900,
            ),
          ),
        ],
      ),
    );
  }
}

// class _ProfileHeader extends StatelessWidget {
//   const _ProfileHeader();
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(18, 8, 18, 0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ClipOval(
//                   child: Image.asset(
//                     ProfileData.avatarAsset,
//                     width: 56,
//                     height: 56,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 const SizedBox(height: 14),
//                 Text(
//                   ProfileData.name,
//                   style: KolekText.sans(
//                     size: 28,
//                     weight: FontWeight.w700,
//                     height: 1.05,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   ProfileData.roleLine1,
//                   style: KolekText.mono(
//                     size: 10,
//                     color: KolekColors.neutral500,
//                     letterSpacing: 0.4,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   ProfileData.roleLine2,
//                   style: KolekText.mono(
//                     size: 10,
//                     color: KolekColors.neutral500,
//                     letterSpacing: 0.4,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(width: 12),
//           const _StatsColumn(),
//         ],
//       ),
//     );
//   }
// }



class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(
                  child: Image.asset(
                    ProfileData.avatarAsset,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  ProfileData.name,
                  style: KolekText.sans(
                    size: 28,
                    weight: FontWeight.w700,
                    height: 1.05,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  ProfileData.roleLine1,
                  style: KolekText.mono(
                    size: 10,
                    color: KolekColors.neutral500,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  ProfileData.roleLine2,
                  style: KolekText.mono(
                    size: 10,
                    color: KolekColors.neutral500,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // ✅ Push stats down so "16.1K / Followers" aligns with the name top
          const Padding(
            padding: EdgeInsets.only(top: 70), // 56 (avatar) + 14 (gap)
            child: _StatsColumn(),
          ),
        ],
      ),
    );
  }
}


// class _StatsColumn extends StatelessWidget {
//   const _StatsColumn();
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 88,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           _StatItem(value: ProfileData.followers, label: 'Followers'),
//           const Divider(height: 20, thickness: 1, color: KolekColors.neutral200),
//           _StatItem(value: ProfileData.following, label: 'Following'),
//           const Divider(height: 20, thickness: 1, color: KolekColors.neutral200),
//           _StatItem(value: ProfileData.works, label: 'Works'),
//         ],
//       ),
//     );
//   }
// }


// class _StatItem extends StatelessWidget {
//   const _StatItem({required this.value, required this.label});
//
//   final String value;
//   final String label;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         Text(
//           value,
//           style: KolekText.sans(size: 16, weight: FontWeight.w700),
//         ),
//         const SizedBox(height: 2),
//         Text(
//           label,
//           style: KolekText.sans(
//             size: 11,
//             weight: FontWeight.w400,
//             color: KolekColors.neutral500,
//           ),
//         ),
//       ],
//     );
//   }
// }

class _StatsColumn extends StatelessWidget {
  const _StatsColumn();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // ✅ was .end
        children: [
          _StatItem(value: ProfileData.followers, label: 'Followers'),
          const Divider(height: 20, thickness: 1, color: KolekColors.neutral200),
          _StatItem(value: ProfileData.following, label: 'Following'),
          const Divider(height: 20, thickness: 1, color: KolekColors.neutral200),
          _StatItem(value: ProfileData.works, label: 'Works'),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // ✅ was .end
      children: [
        Text(
          value,
          style: KolekText.sans(size: 16, weight: FontWeight.w700),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: KolekText.sans(
            size: 11,
            weight: FontWeight.w400,
            color: KolekColors.neutral500,
          ),
        ),
      ],
    );
  }
}




class _ProfileActions extends StatelessWidget {
  const _ProfileActions();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
      child: Row(
        children: [
          _UnderlineLink(label: 'Edit Profile', onTap: () {}),
          const SizedBox(width: 22),
          _UnderlineLink(label: 'Share Profile', onTap: () {}),
        ],
      ),
    );
  }
}

class _UnderlineLink extends StatelessWidget {
  const _UnderlineLink({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: KolekText.sans(size: 13, weight: FontWeight.w500).copyWith(
          decoration: TextDecoration.underline,
          decorationColor: KolekColors.neutral900,
        ),
      ),
    );
  }
}

class _ProfileTabs extends StatelessWidget {
  const _ProfileTabs();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  for (var i = 0; i < ProfileData.tabs.length; i++)
                    Expanded(
                      child: _TabItem(
                        label: ProfileData.tabs[i],
                        selected: state.tabIndex == i,
                        onTap: () => context.read<ProfileCubit>().selectTab(i),
                      ),
                    ),
                ],
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              color: KolekColors.neutral200,
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: KolekText.sans(
                size: 11,
                weight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected
                    ? KolekColors.neutral900
                    : KolekColors.neutral500,
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            height: 2.5,
            color: selected ? KolekColors.neutral900 : Colors.transparent,
          ),
        ],
      ),
    );
  }
}

/// A single tile in the works masonry grid, expressed entirely in
/// fractions (0..1) of the grid's own width/height. This mirrors the
/// dxPct/dyPct/widthPct pattern used for the BOL signature overlay so the
/// layout stays correct at any screen width without re-deriving pixel math.
///
/// Measured directly off the design reference — 6 images total, each used
/// exactly once (imageIndex 0-5). No 7th tile, no reused asset.
///
/// The only non-obvious part: pi6 (the bottom panorama) is ONE full-width
/// rectangle whose top edge starts higher than pi3/pi4's bottom edge.
/// pi3/pi4 are painted on top of it afterward, so they visually cover
/// pi6's top-left corner for about 23px — that's the "overlap" you're
/// seeing, not a crop and not a separate image:
/// ```
/// [   pi1   ][   pi1   ][  pi2  ]
/// [   pi1   ][   pi1   ][  pi2  ]
/// [   pi3   ][   pi4   ][  pi2  ]
/// [ pi3/pi6 ][ pi4/pi6 ][  pi5  ]   <- pi3/pi4 sit on top of pi6 here
/// [       pi6 (full width)      ]
/// ```
/// Stack paint order therefore matters: pi6 must be added to the Stack
/// BEFORE pi3/pi4 so it sits underneath in the overlap zone.
class _GridTile {
  const _GridTile({
    required this.col,
    required this.colSpan,
    required this.top,
    required this.height,
    required this.imageIndex,
  });

  final int col; // starting column, 0-2
  final int colSpan; // how many of the 3 columns this tile occupies
  final double top; // fraction of total grid height
  final double height; // fraction of total grid height
  final int imageIndex;
}

class _WorksGrid extends StatelessWidget {
  const _WorksGrid();

  // Fractions derived from pixel-measuring the design screenshot
  // (grid content region was 348px-713px tall == 365px reference height).
  //
  // NOTE: list order = paint order (Stack paints later children on top).
  // pi6 (panorama) is listed BEFORE pi3/pi4 (purple/warm) on purpose, so
  // that purple/warm paint over its top-left corner in the overlap zone.
  static const List<_GridTile> _tiles = [
    _GridTile(col: 0, colSpan: 2, top: 0.0000, height: 0.3699, imageIndex: 0), // colorful
    _GridTile(col: 2, colSpan: 1, top: 0.0000, height: 0.4274, imageIndex: 1), // gray brushstrokes
    _GridTile(col: 2, colSpan: 1, top: 0.4411, height: 0.2603, imageIndex: 4), // teal/orange
    _GridTile(col: 0, colSpan: 3, top: 0.7123, height: 0.2877, imageIndex: 5), // panorama — starts high, full width
    _GridTile(col: 0, colSpan: 1, top: 0.3836, height: 0.3918, imageIndex: 2), // purple circles — overlaps panorama
    _GridTile(col: 1, colSpan: 1, top: 0.3836, height: 0.3918, imageIndex: 3), // warm abstract — overlaps panorama
  ];

  // Reference aspect ratio of the whole grid block (height / width),
  // measured from the design so the grid scales correctly on other widths.
  static const double _gridAspectRatio = 365 / 343;

  @override
  Widget build(BuildContext context) {
    const gap = ProfileData.gridGap;
    final images = ProfileData.gridImages; // unchanged, still 6 entries

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final cell = (width - gap * 2) / 3;
          final totalH = width * _gridAspectRatio;

          double x(int col) => col * (cell + gap);
          double colSpanWidth(int span) => span * cell + (span - 1) * gap;

          return SizedBox(
            height: totalH,
            child: Stack(
              children: [
                for (final tile in _tiles)
                  Positioned(
                    left: x(tile.col),
                    top: tile.top * totalH,
                    width: colSpanWidth(tile.colSpan),
                    height: tile.height * totalH,
                    child: _GridImage(asset: images[tile.imageIndex]),
                  ),
              ],
            ),
          );
        },
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
        errorBuilder: (_, _, _) => ColoredBox(
          color: KolekColors.neutral200,
          child: Center(
            child: Icon(
              Icons.image_outlined,
              color: KolekColors.neutral400,
            ),
          ),
        ),
      ),
    );
  }
}

class _FeaturedWork extends StatelessWidget {
  const _FeaturedWork();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ProfileData.featuredLabel,
            style: KolekText.sans(
              size: 12,
              weight: FontWeight.w500,
              color: KolekColors.blue600,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  ProfileData.featuredTitle,
                  style: KolekText.sans(
                    size: 22,
                    weight: FontWeight.w700,
                    height: 1.1,
                  ),
                ),
              ),
              Text(
                ProfileData.featuredPrice,
                style: KolekText.sans(
                  size: 16,
                  weight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            ProfileData.featuredMedium,
            style: KolekText.mono(
              size: 10,
              color: KolekColors.neutral500,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  ProfileData.featuredSize,
                  style: KolekText.mono(
                    size: 10,
                    color: KolekColors.neutral500,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward,
                size: 18,
                color: KolekColors.neutral900,
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
        style: KolekText.mono(
          size: 12,
          color: KolekColors.neutral600,
          height: 1.5,
        ),
      ),
    );
  }
}