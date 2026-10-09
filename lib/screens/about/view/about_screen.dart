import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../bloc/about_bloc.dart';
import '../bloc/about_event.dart';
import '../data/about_data.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _AboutAppBar(),
            Divider(
              height: 1,
              thickness: 0.5,
              color: AppearancePage.line(context),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 32),
                children: const [
                  _HeroSection(),
                  SizedBox(height: 28),
                  _WhatYouCanDoSection(),
                  SizedBox(height: 28),
                  _MissionSection(),
                  SizedBox(height: 28),
                  _QuestionsSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// App bar — back arrow + "About Kolek" (left-aligned) + bell
// ─────────────────────────────────────────────────────────────────────────

class _AboutAppBar extends StatelessWidget {
  const _AboutAppBar();

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints:
            const BoxConstraints(minWidth: 40, minHeight: 40),
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back, size: 24, color: fg),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              AboutData.appBarTitle,
              style: KolekText.sans(
                size: 20,
                weight: FontWeight.w600,
                height: 1.0,
                color: fg,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Hero — big title + lead + body
// ─────────────────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AboutData.heroTitle,
          style: KolekText.sans(
            size: 32,
            weight: FontWeight.w600,
            height: 1.1,
            letterSpacing: -0.5,
            color: AppearancePage.foreground(context),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          AboutData.heroLead,
          style: KolekText.sans(
            size: 15,
            weight: FontWeight.w500,
            height: 1.4,
            color: AppearancePage.foreground(context),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          AboutData.heroBody,
          style: KolekText.sans(
            size: 13,
            weight: FontWeight.w400,
            height: 1.55,
            color: AppearancePage.muted(context),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Shared section header — small uppercase label + hairline above
// ─────────────────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          height: 1,
          thickness: 0.5,
          color: AppearancePage.line(context),
        ),
        const SizedBox(height: 16),
        Text(
          label,
          style: KolekText.mono(
            size: 11,
            weight: FontWeight.w500,
            height: 1.0,
            letterSpacing: 1.2,
            color: AppearancePage.muted(context),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// What You Can Do — list of features
// ─────────────────────────────────────────────────────────────────────────

class _WhatYouCanDoSection extends StatelessWidget {
  const _WhatYouCanDoSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(label: AboutData.whatYouCanDoLabel),
        const SizedBox(height: 16),
        for (var i = 0; i < AboutData.features.length; i++) ...[
          _FeatureItem(feature: AboutData.features[i]),
          if (i < AboutData.features.length - 1)
            const SizedBox(height: 16),
        ],
      ],
    );
  }
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem({required this.feature});

  final AboutFeature feature;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          feature.title,
          style: KolekText.sans(
            size: 14,
            weight: FontWeight.w600,
            height: 1.2,
            color: AppearancePage.foreground(context),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          feature.description,
          style: KolekText.sans(
            size: 12,
            weight: FontWeight.w400,
            height: 1.45,
            color: AppearancePage.muted(context),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Our Mission — heading + paragraphs
// ─────────────────────────────────────────────────────────────────────────

class _MissionSection extends StatelessWidget {
  const _MissionSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(label: AboutData.ourMissionLabel),
        const SizedBox(height: 16),
        for (var i = 0; i < AboutData.missionParagraphs.length; i++) ...[
          Text(
            AboutData.missionParagraphs[i],
            style: KolekText.sans(
              size: 13,
              weight: FontWeight.w500,
              height: 1.55,
              color: AppearancePage.foreground(context),
            ),
          ),
          if (i < AboutData.missionParagraphs.length - 1)
            const SizedBox(height: 14),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Questions — label + line + email link
// ─────────────────────────────────────────────────────────────────────────

class _QuestionsSection extends StatelessWidget {
  const _QuestionsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(label: AboutData.questionsLabel),
        const SizedBox(height: 16),
        Text(
          AboutData.questionsBody,
          style: KolekText.sans(
            size: 13,
            weight: FontWeight.w500,
            height: 1.45,
            color: AppearancePage.foreground(context),
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () =>
              context.read<AboutBloc>().add(const AboutEmailTapped()),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text(
              AboutData.supportEmail,
              style: KolekText.sans(
                size: 14,
                weight: FontWeight.w500,
                height: 1.3,
                color: KolekColors.blue600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}