import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../cubit/profile_cubit.dart';
import '../data/profile_data.dart';

/// ============================================================
/// FONT CHOOSER — every property is overridable per-call.
/// To modify any text, just pass the property you want to change
/// where the style is used (e.g. _ProfileFonts.name(fontSize: 50)).
/// ============================================================
abstract final class _ProfileFonts {
  static const generalSans = 'GeneralSans-Regular';
  static const generalSansSemibold = 'GeneralSans-Semibold';
  static const generalSansMedium = 'GeneralSans-Medium';
  static const ibmPlexMono = 'IBMPlexMono-Regular';
  static const ibmPlexMonoMedium = 'IBMPlexMono-Medium';

  // ── Location: "LOS ANGELES, CA" ──
  static TextStyle location({
    String? fontFamily,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
    Color? color,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    Color? decorationColor,
    double? decorationThickness,
  }) =>
      TextStyle(
        fontFamily: fontFamily ?? ibmPlexMono,
        fontSize: fontSize ?? 10,
        fontWeight: fontWeight ?? FontWeight.w400,
        letterSpacing: letterSpacing ?? 0.8,
        height: height,
        color: color ?? KolekColors.blue600,
        fontStyle: fontStyle,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationThickness: decorationThickness,
      );

  // ── Name: "Nova Styles" ──
  static TextStyle name({
    String? fontFamily,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
    Color? color,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    Color? decorationColor,
    double? decorationThickness,
  }) =>
      TextStyle(
        // Matches: font-family GeneralSans, font-weight 500, font-style Medium,
        // font-size 50px, line-height 53px, letter-spacing 0px.
        fontFamily: fontFamily ?? generalSansMedium,
        fontSize: fontSize ?? 50,
        fontWeight: fontWeight ?? FontWeight.w500,
        height: height ?? (53 / 50), // 1.06
        letterSpacing: letterSpacing ?? 0,
        color: color ?? KolekColors.neutral900,
        fontStyle: fontStyle,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationThickness: decorationThickness,
      );

  // ── Role line 1: "CONTEMPORARY PAINTER" ──
  static TextStyle roleLine1({
    String? fontFamily,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
    Color? color,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    Color? decorationColor,
    double? decorationThickness,
  }) =>
      TextStyle(
        fontFamily: fontFamily ?? ibmPlexMono,
        fontSize: fontSize ?? 10,
        fontWeight: fontWeight ?? FontWeight.w400,
        letterSpacing: letterSpacing ?? 0.8,
        height: height ?? 1.5,
        color: color ?? KolekColors.neutral600,
        fontStyle: fontStyle,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationThickness: decorationThickness,
      );

  // ── Role line 2: "5 MIXED MEDIA ARTIST" ──
  static TextStyle roleLine2({
    String? fontFamily,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
    Color? color,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    Color? decorationColor,
    double? decorationThickness,
  }) =>
      TextStyle(
        fontFamily: fontFamily ?? ibmPlexMono,
        fontSize: fontSize ?? 10,
        fontWeight: fontWeight ?? FontWeight.w400,
        letterSpacing: letterSpacing ?? 0.8,
        height: height ?? 1.5,
        color: color ?? KolekColors.neutral600,
        fontStyle: fontStyle,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationThickness: decorationThickness,
      );

  // ── Stat value: "16.1K" / "500" / "150" ──
  static TextStyle statValue({
    String? fontFamily,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
    Color? color,
    FontStyle? fontStyle,
  }) =>
      TextStyle(
        fontFamily: fontFamily ?? generalSansMedium,
        fontSize: fontSize ?? 16,
        fontWeight: fontWeight ?? FontWeight.w500,
        // line-height: 100% => multiplier 1.0
        height: height ?? 1.0,
        letterSpacing: letterSpacing ?? 0,
        color: color ?? KolekColors.neutral900,
        fontStyle: fontStyle,
      );

  // ── Stat label: "FOLLOWERS" / "FOLLOWING" / "WORKS" ──
  static TextStyle statLabel({
    String? fontFamily,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
    Color? color,
    FontStyle? fontStyle,
  }) =>
      TextStyle(
        fontFamily: fontFamily ?? ibmPlexMono,
        fontSize: fontSize ?? 12,
        fontWeight: fontWeight ?? FontWeight.w400,
        // line-height: 20px with font-size 12px => 20/12
        height: height ?? (20 / 12),
        letterSpacing: letterSpacing ?? 0,
        color: color ?? KolekColors.neutral500,
        fontStyle: fontStyle,
      );

  // ── "EDIT PROFILE" ──
  static TextStyle editProfile({
    String? fontFamily,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
    Color? color,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    Color? decorationColor,
    double? decorationThickness,
  }) =>
      TextStyle(
        fontFamily: fontFamily ?? ibmPlexMonoMedium,
        fontSize: fontSize ?? 11,
        fontWeight: fontWeight ?? FontWeight.w500,
        letterSpacing: letterSpacing ?? 0.4,
        height: height,
        color: color ?? KolekColors.neutral900,
        fontStyle: fontStyle,
        decoration: decoration ?? TextDecoration.underline,
        decorationColor: decorationColor ?? KolekColors.neutral900,
        decorationThickness: decorationThickness ?? 1.5,
      );

  // ── "SHARE PROFILE" ──
  static TextStyle shareProfile({
    String? fontFamily,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
    Color? color,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    Color? decorationColor,
    double? decorationThickness,
  }) =>
      TextStyle(
        fontFamily: fontFamily ?? ibmPlexMonoMedium,
        fontSize: fontSize ?? 11,
        fontWeight: fontWeight ?? FontWeight.w500,
        letterSpacing: letterSpacing ?? 0.4,
        height: height,
        color: color ?? KolekColors.neutral900,
        fontStyle: fontStyle,
        decoration: decoration ?? TextDecoration.underline,
        decorationColor: decorationColor ?? KolekColors.neutral900,
        decorationThickness: decorationThickness ?? 1.5,
      );

  // ── Tab: selected ──
  static TextStyle tabSelected({
    String? fontFamily,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
    Color? color,
    FontStyle? fontStyle,
  }) =>
      TextStyle(
        fontFamily: fontFamily ?? ibmPlexMono,
        fontSize: fontSize ?? 11,
        fontWeight: fontWeight ?? FontWeight.w600,
        letterSpacing: letterSpacing ?? 0.6,
        height: height,
        color: color ?? KolekColors.neutral900,
        fontStyle: fontStyle,
      );

  // ── Tab: unselected ──
  static TextStyle tabUnselected({
    String? fontFamily,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
    Color? color,
    FontStyle? fontStyle,
  }) =>
      TextStyle(
        fontFamily: fontFamily ?? ibmPlexMono,
        fontSize: fontSize ?? 11,
        fontWeight: fontWeight ?? FontWeight.w400,
        letterSpacing: letterSpacing ?? 0.6,
        height: height,
        color: color ?? KolekColors.neutral400,
        fontStyle: fontStyle,
      );

  // ── "Featured Work" ──
  static TextStyle featuredLabel({
    String? fontFamily,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
    Color? color,
    FontStyle? fontStyle,
  }) =>
      TextStyle(
        fontFamily: fontFamily ?? ibmPlexMono,
        fontSize: fontSize ?? 12,
        fontWeight: fontWeight ?? FontWeight.w400,
        letterSpacing: letterSpacing,
        height: height,
        color: color ?? KolekColors.blue600,
        fontStyle: fontStyle ?? FontStyle.italic,
      );

  // ── "Blue Depths" ──
  static TextStyle featuredTitle({
    String? fontFamily,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
    Color? color,
    FontStyle? fontStyle,
  }) =>
      TextStyle(
        fontFamily: fontFamily ?? generalSansSemibold,
        fontSize: fontSize ?? 22,
        fontWeight: fontWeight ?? FontWeight.w600,
        height: height ?? 1.1,
        letterSpacing: letterSpacing,
        color: color ?? KolekColors.neutral900,
        fontStyle: fontStyle,
      );

  // ── "$2,800" ──
  static TextStyle featuredPrice({
    String? fontFamily,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
    Color? color,
    FontStyle? fontStyle,
  }) =>
      TextStyle(
        fontFamily: fontFamily ?? generalSans,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.w400,
        letterSpacing: letterSpacing,
        height: height,
        color: color ?? KolekColors.neutral600,
        fontStyle: fontStyle,
      );

  // ── "ACRYLIC ON CANVAS, 2024" ──
  static TextStyle featuredMedium({
    String? fontFamily,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
    Color? color,
    FontStyle? fontStyle,
  }) =>
      TextStyle(
        fontFamily: fontFamily ?? ibmPlexMono,
        fontSize: fontSize ?? 10,
        fontWeight: fontWeight ?? FontWeight.w400,
        letterSpacing: letterSpacing ?? 0.3,
        height: height ?? 1.4,
        color: color ?? KolekColors.neutral500,
        fontStyle: fontStyle,
      );

  // ── '48" x 60"' ──
  static TextStyle featuredSize({
    String? fontFamily,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
    Color? color,
    FontStyle? fontStyle,
  }) =>
      TextStyle(
        fontFamily: fontFamily ?? ibmPlexMono,
        fontSize: fontSize ?? 10,
        fontWeight: fontWeight ?? FontWeight.w400,
        letterSpacing: letterSpacing ?? 0.3,
        height: height ?? 1.4,
        color: color ?? KolekColors.neutral500,
        fontStyle: fontStyle,
      );

  // ── About body ──
  static TextStyle about({
    String? fontFamily,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? height,
    Color? color,
    FontStyle? fontStyle,
  }) =>
      TextStyle(
        fontFamily: fontFamily ?? ibmPlexMono,
        fontSize: fontSize ?? 12,
        fontWeight: fontWeight ?? FontWeight.w400,
        letterSpacing: letterSpacing,
        height: height ?? 1.5,
        color: color ?? KolekColors.neutral600,
        fontStyle: fontStyle,
      );
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KolekColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: _ProfileAppBar()),
            const SliverToBoxAdapter(child: _ProfileHeader()),
            const SliverToBoxAdapter(child: _ProfileActions()),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            const SliverToBoxAdapter(child: _ThinDivider()),
            const SliverToBoxAdapter(child: SizedBox(height: 6)),
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

class _ThinDivider extends StatelessWidget {
  const _ThinDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      thickness: 0.5,
      color: KolekColors.neutral300,
      indent: 18,
      endIndent: 18,
    );
  }
}

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
            onPressed: () {},
            icon: const Icon(
              Icons.settings_outlined,
              size: 20,
              color: KolekColors.neutral900,
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              size: 22,
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
      padding: const EdgeInsets.fromLTRB(18, 6, 18, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: avatar + name + role
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar row with location
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
                          decoration: BoxDecoration(
                            color: KolekColors.blue600,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          ProfileData.location,
                          style: _ProfileFonts.location(),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Name
                Text(
                  ProfileData.name,
                  style: _ProfileFonts.name(),
                ),
                const SizedBox(height: 8),
                // Role line 1
                Text(
                  ProfileData.roleLine1,
                  style: _ProfileFonts.roleLine1(),
                ),
                // Role line 2
                Text(
                  ProfileData.roleLine2,
                  style: _ProfileFonts.roleLine2(),
                ),
              ],
            ),
          ),
          // Right: stats
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
    return SizedBox(
      width: 78,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Followers
          _StatItem(
            value: ProfileData.followers,
            label: 'FOLLOWERS',
            valueStyle: _ProfileFonts.statValue(),
            labelStyle: _ProfileFonts.statLabel(),
          ),
          const SizedBox(height: 4),
          const Divider(height: 12, thickness: 0.5, color: KolekColors.neutral300),
          const SizedBox(height: 2),
          // Following
          _StatItem(
            value: ProfileData.following,
            label: 'FOLLOWING',
            valueStyle: _ProfileFonts.statValue(),
            labelStyle: _ProfileFonts.statLabel(),
          ),
          const SizedBox(height: 4),
          const Divider(height: 12, thickness: 0.5, color: KolekColors.neutral300),
          const SizedBox(height: 2),
          // Works
          _StatItem(
            value: ProfileData.works,
            label: 'WORKS',
            valueStyle: _ProfileFonts.statValue(),
            labelStyle: _ProfileFonts.statLabel(),
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

class _ProfileActions extends StatelessWidget {
  const _ProfileActions();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Text(
              'EDIT PROFILE',
              style: _ProfileFonts.editProfile(),
            ),
          ),
          const SizedBox(width: 18),
          GestureDetector(
            onTap: () {},
            child: Text(
              'SHARE PROFILE',
              style: _ProfileFonts.shareProfile(),
            ),
          ),
        ],
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
                      onTap: () =>
                          context.read<ProfileCubit>().selectTab(i),
                    ),
                ],
              ),
            ),
            const Divider(
              height: 1,
              thickness: 0.5,
              color: KolekColors.neutral300,
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
                    style: selected
                        ? _ProfileFonts.tabSelected()
                        : _ProfileFonts.tabUnselected(),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  height: 2,
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

// ─── Image grid (UNTOUCHED) ───────────────────────────────────

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
    _GridTile(col: 0, colSpan: 2, top: 0.0000, height: 0.3699, imageIndex: 0),
    _GridTile(col: 2, colSpan: 1, top: 0.0000, height: 0.4274, imageIndex: 1),
    _GridTile(col: 2, colSpan: 1, top: 0.4411, height: 0.2603, imageIndex: 4),
    _GridTile(col: 0, colSpan: 3, top: 0.7123, height: 0.2877, imageIndex: 5),
    _GridTile(col: 0, colSpan: 1, top: 0.3836, height: 0.3918, imageIndex: 2),
    _GridTile(col: 1, colSpan: 1, top: 0.3836, height: 0.3918, imageIndex: 3),
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

// ─── Featured work + About ─────────────────────────────────────

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
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
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
          const SizedBox(height: 6),
          Text(
            ProfileData.featuredMedium,
            style: _ProfileFonts.featuredMedium(),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Expanded(
                child: Text(
                  ProfileData.featuredSize,
                  style: _ProfileFonts.featuredSize(),
                ),
              ),
              const Icon(
                Icons.arrow_forward,
                size: 16,
                color: KolekColors.neutral400,
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
