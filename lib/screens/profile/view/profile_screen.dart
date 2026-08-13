import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../cubit/profile_cubit.dart';
import '../data/profile_data.dart';

/// ============================================================
/// FONT CHOOSER — pick per text from ProfileScreen.
/// Families (must match pubspec.yaml):
///   'GeneralSans-Regular'  -> assets/font/GeneralSans-Regular.otf
///   'IBMPlexMono-Regular'  -> assets/font/IBMPlexMono-Regular.ttf
/// Change only `fontFamily` / `fontWeight` on each style.
/// ============================================================
abstract final class _ProfileFonts {
  static const generalSans = 'GeneralSans-Regular';
  static const ibmPlexMono = 'IBMPlexMono-Regular';

  // Name: "Avayah Blanchard"
  static TextStyle name({Color color = KolekColors.neutral900}) => TextStyle(
        fontFamily: generalSans, // <-- choose: generalSans | ibmPlexMono
        fontSize: 40,
        fontWeight: FontWeight.w900,
        height: 1.1,
        color: color,
      );

  // Role: "CONTEMPORARY PAINTER" / "& MIXED MEDIA ARTIST"
  static TextStyle role({Color color = KolekColors.neutral500}) => TextStyle(
        fontFamily: ibmPlexMono, // <-- choose
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.6,
        height: 1.4,
        color: color,
      );

  // Stat value: "16.1K", "500", "150"
  static TextStyle statValue({Color color = KolekColors.neutral900}) =>
      TextStyle(
        fontFamily: generalSans, // <-- choose
        fontSize: 18,
        fontWeight: FontWeight.w700,
        height: 1.1,
        color: color,
      );

  // Stat label: "Followers", "Following", "Works"
  static TextStyle statLabel({Color color = KolekColors.neutral500}) =>
      TextStyle(
        fontFamily: ibmPlexMono, // <-- choose
        fontSize: 11,
        fontWeight: FontWeight.w400,
        height: 1.2,
        color: color,
      );

  // "Edit Profile" / "Share Profile"
  static TextStyle actionLink({Color color = KolekColors.neutral900}) =>
      TextStyle(
        fontFamily: generalSans, // <-- choose
        fontSize: 14,
        fontWeight: FontWeight.w400,
        decoration: TextDecoration.underline,
        decorationColor: color,
        decorationThickness: 1.2,
        color: color,
      );

  // Tabs: WORKS / FOR SALE / SAVED / ABOUT
  static TextStyle tab({
    required bool selected,
    Color selectedColor = KolekColors.neutral900,
    Color unselectedColor = KolekColors.neutral500,
  }) =>
      TextStyle(
        fontFamily: generalSans, // <-- choose
        fontSize: 12,
        fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
        letterSpacing: 0.4,
        color: selected ? selectedColor : unselectedColor,
      );

  // "Featured Work"
  static TextStyle featuredLabel({Color color = KolekColors.blue600}) =>
      TextStyle(
        fontFamily: ibmPlexMono, // <-- choose
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: color,
      );

  // "Blue Depths"
  static TextStyle featuredTitle({Color color = KolekColors.neutral900}) =>
      TextStyle(
        fontFamily: generalSans, // <-- choose
        fontSize: 22,
        fontWeight: FontWeight.w700,
        height: 1.1,
        color: color,
      );

  // "$2,800"
  static TextStyle featuredPrice({Color color = KolekColors.neutral900}) =>
      TextStyle(
        fontFamily: generalSans, // <-- choose
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: color,
      );

  // "ACRYLIC ON CANVAS, 2024" / '48" x 60"'
  static TextStyle featuredMeta({Color color = KolekColors.neutral500}) =>
      TextStyle(
        fontFamily: ibmPlexMono, // <-- choose
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.3,
        color: color,
      );

  // About body
  static TextStyle about({Color color = KolekColors.neutral600}) => TextStyle(
        fontFamily: ibmPlexMono, // <-- choose
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: color,
      );
}

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
            const SliverToBoxAdapter(child: _FadedDivider()),
            const SliverToBoxAdapter(child: _ProfileHeader()),
            const SliverToBoxAdapter(child: _ProfileActions()),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
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

class _FadedDivider extends StatelessWidget {
  const _FadedDivider();

  static const double _fadeWidth = 80.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1,
      width: double.infinity,
      child: Stack(
        children: [
          const Positioned.fill(
            child: ColoredBox(color: KolekColors.neutral200),
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: _fadeWidth,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.white,
                    Colors.white.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: _fadeWidth,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.white.withValues(alpha: 0.0),
                    Colors.white,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileAppBar extends StatelessWidget {
  const _ProfileAppBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 10, 4, 8),
      child: Row(
        children: [
          const KolekTextLogo(height: 22),
          const Spacer(),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            onPressed: () {},
            icon: const Icon(
              Icons.settings_outlined,
              size: 22,
              color: KolekColors.neutral900,
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
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

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipOval(
                      child: Image.asset(
                        ProfileData.avatarAsset,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  ProfileData.name,
                  style: _ProfileFonts.name(),
                ),
                const SizedBox(height: 14),
                Text(
                  ProfileData.roleLine1,
                  style: _ProfileFonts.role(),
                ),
                Text(
                  ProfileData.roleLine2,
                  style: _ProfileFonts.role(),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Align stats with the name block (below avatar).
          const Padding(
            padding: EdgeInsets.only(top: 72),
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
    return SizedBox(
      width: 92,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _StatItem(value: ProfileData.followers, label: 'Followers'),
          const Divider(
            height: 22,
            thickness: 1,
            color: KolekColors.neutral200,
          ),
          _StatItem(value: ProfileData.following, label: 'Following'),
          const Divider(
            height: 22,
            thickness: 1,
            color: KolekColors.neutral200,
          ),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: _ProfileFonts.statValue()),
        const SizedBox(height: 2),
        Text(label, style: _ProfileFonts.statLabel()),
      ],
    );
  }
}

class _ProfileActions extends StatelessWidget {
  const _ProfileActions();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
      child: Row(
        children: [
          _UnderlineLink(label: 'Edit Profile', onTap: () {}),
          const SizedBox(width: 24),
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
      child: Text(label, style: _ProfileFonts.actionLink()),
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
              padding: const EdgeInsets.symmetric(
                horizontal: ProfileData.tabHorizontalPadding,
              ),
              child: Row(
                // Tabs hug their labels; gap is controlled by ProfileData.tabGap
                spacing: ProfileData.tabGap,
                children: [
                  for (var i = 0; i < ProfileData.tabs.length; i++)
                    _TabItem(
                      label: ProfileData.tabs[i],
                      selected: state.tabIndex == i,
                      onTap: () =>
                          context.read<ProfileCubit>().selectTab(i),
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
      child: SizedBox(
        height: 48,
        child: Center(
          // Underline only as wide as the label (matches design).
          child: IntrinsicWidth(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: _ProfileFonts.tab(selected: selected),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  height: 2.5,
                  color:
                      selected ? KolekColors.neutral900 : Colors.transparent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GridTile {
  const _GridTile({
    required this.col,
    required this.colSpan,
    required this.top,
    required this.height,
    required this.imageIndex,
  });

  final int col;
  final int colSpan;
  final double top;
  final double height;
  final int imageIndex;
}

class _WorksGrid extends StatelessWidget {
  const _WorksGrid();

  static const List<_GridTile> _tiles = [
    _GridTile(
      col: 0,
      colSpan: 2,
      top: 0.0000,
      height: 0.3699,
      imageIndex: 0,
    ),
    _GridTile(
      col: 2,
      colSpan: 1,
      top: 0.0000,
      height: 0.4274,
      imageIndex: 1,
    ),
    _GridTile(
      col: 2,
      colSpan: 1,
      top: 0.4411,
      height: 0.2603,
      imageIndex: 4,
    ),
    _GridTile(
      col: 0,
      colSpan: 3,
      top: 0.7123,
      height: 0.2877,
      imageIndex: 5,
    ),
    _GridTile(
      col: 0,
      colSpan: 1,
      top: 0.3836,
      height: 0.3918,
      imageIndex: 2,
    ),
    _GridTile(
      col: 1,
      colSpan: 1,
      top: 0.3836,
      height: 0.3918,
      imageIndex: 3,
    ),
  ];

  static const double _gridAspectRatio = 365 / 343;

  @override
  Widget build(BuildContext context) {
    const gap = ProfileData.gridGap;
    final images = ProfileData.gridImages;

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
            style: _ProfileFonts.featuredLabel(),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  ProfileData.featuredTitle,
                  style: _ProfileFonts.featuredTitle(),
                ),
              ),
              Text(
                ProfileData.featuredPrice,
                style: _ProfileFonts.featuredPrice(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            ProfileData.featuredMedium,
            style: _ProfileFonts.featuredMeta(),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  ProfileData.featuredSize,
                  style: _ProfileFonts.featuredMeta(),
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
        style: _ProfileFonts.about(),
      ),
    );
  }
}
