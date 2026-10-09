import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../bloc/help_support_bloc.dart';
import '../bloc/help_support_event.dart';
import '../bloc/help_support_state.dart';
import '../data/help_support_data.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _HelpSupportAppBar(),
            Expanded(
              child: BlocBuilder<HelpSupportBloc, HelpSupportState>(
                builder: (context, state) {
                  return ListView(
                    padding: const EdgeInsets.fromLTRB(18, 8, 18, 32),
                    children: [
                      const _SearchField(),
                      const SizedBox(height: 20),
                      if (state.hasNoMatches)
                        const _NoMatches()
                      else ...[
                        if (state.visibleTopics.isNotEmpty) ...[
                          const _SectionLabel(
                            label: HelpSupportData.helpTopicsLabel,
                          ),
                          const SizedBox(height: 8),
                          for (final topic in state.visibleTopics)
                            _TopicRow(topic: topic),
                          const SizedBox(height: 24),
                        ],
                        if (state.visibleFaqs.isNotEmpty) ...[
                          const _SectionLabel(
                            label: HelpSupportData.commonQuestionsLabel,
                          ),
                          const SizedBox(height: 8),
                          for (final faq in state.visibleFaqs)
                            _FaqRow(faq: faq),
                          const SizedBox(height: 24),
                        ],
                        if (state.visibleReports.isNotEmpty) ...[
                          const _SectionLabel(
                            label: HelpSupportData.stillNeedHelpLabel,
                          ),
                          const SizedBox(height: 12),
                          const _ContactCard(),
                          const SizedBox(height: 12),
                          for (final report in state.visibleReports) ...[
                            _ReportCard(report: report),
                            const SizedBox(height: 12),
                          ],
                        ],
                      ],
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// App bar — back arrow + "Help & Support" (no bell)
// ─────────────────────────────────────────────────────────────────────────

class _HelpSupportAppBar extends StatelessWidget {
  const _HelpSupportAppBar();

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
          Text(
            HelpSupportData.appBarTitle,
            style: KolekText.sans(
              size: 20,
              weight: FontWeight.w600,
              height: 1.0,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Search field
// ─────────────────────────────────────────────────────────────────────────

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppearancePage.field(context),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Uses the search SVG for consistency with the app bar elsewhere.
          SvgPicture.asset(
            'assets/icons/search.svg',
            width: 20,
            height: 20,
            colorFilter: AppearancePage.iconFilter(context),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              onChanged: (value) => context
                  .read<HelpSupportBloc>()
                  .add(HelpSupportSearchChanged(value)),
              textInputAction: TextInputAction.search,
              style: KolekText.sans(
                size: 14,
                color: AppearancePage.foreground(context),
              ),
              cursorColor: KolekColors.blue600,
              decoration: InputDecoration(
                isDense: true,
                hintText: HelpSupportData.searchHint,
                hintStyle: KolekText.sans(
                  size: 14,
                  color: AppearancePage.muted(context),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Section label
// ─────────────────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        label,
        style: KolekText.mono(
          size: 11,
          weight: FontWeight.w500,
          height: 1.0,
          letterSpacing: 1.2,
          color: AppearancePage.muted(context),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Topic row — SVG icon + title + subtitle + chevron
// ─────────────────────────────────────────────────────────────────────────

class _TopicRow extends StatelessWidget {
  const _TopicRow({required this.topic});

  final HelpTopic topic;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context
          .read<HelpSupportBloc>()
          .add(HelpSupportTopicTapped(topic.id)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            SvgPicture.asset(
              topic.iconAsset,
              width: 22,
              height: 22,
              colorFilter: AppearancePage.iconFilter(context),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    topic.title,
                    style: KolekText.sans(
                      size: 14,
                      weight: FontWeight.w600,
                      height: 1.2,
                      color: AppearancePage.foreground(context),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    topic.subtitle,
                    style: KolekText.sans(
                      size: 12,
                      weight: FontWeight.w400,
                      height: 1.3,
                      color: AppearancePage.muted(context),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right,
              size: 22,
              color: AppearancePage.icon(context),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// FAQ row — chat SVG + question + chevron
// ─────────────────────────────────────────────────────────────────────────

class _FaqRow extends StatelessWidget {
  const _FaqRow({required this.faq});

  final HelpFaq faq;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context
          .read<HelpSupportBloc>()
          .add(HelpSupportFaqTapped(faq.id)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/faq.svg',   // ← swap to your chat SVG
              width: 22,
              height: 22,
              colorFilter: AppearancePage.iconFilter(context),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                faq.question,
                style: KolekText.sans(
                  size: 14,
                  weight: FontWeight.w500,
                  height: 1.3,
                  color: AppearancePage.foreground(context),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right,
              size: 22,
              color: AppearancePage.icon(context),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Contact card — body copy + blue CTA
// ─────────────────────────────────────────────────────────────────────────

class _ContactCard extends StatelessWidget {
  const _ContactCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        color: AppearancePage.field(context),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppearancePage.line(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            HelpSupportData.contactBody,
            style: KolekText.sans(
              size: 13,
              weight: FontWeight.w400,
              height: 1.5,
              color: AppearancePage.muted(context),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 46,
            child: FilledButton(
              onPressed: () => context
                  .read<HelpSupportBloc>()
                  .add(const HelpSupportContactRequested()),
              style: FilledButton.styleFrom(
                backgroundColor: KolekColors.blue600,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                textStyle: KolekText.sans(
                  size: 15,
                  weight: FontWeight.w600,
                ),
              ),
              child: const Text(HelpSupportData.contactButtonLabel),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Report card — bordered tile with SVG icon + title + subtitle + chevron
// ─────────────────────────────────────────────────────────────────────────

class _ReportCard extends StatelessWidget {
  const _ReportCard({required this.report});

  final HelpReport report;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context
          .read<HelpSupportBloc>()
          .add(HelpSupportReportTapped(report.id)),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
        decoration: BoxDecoration(
          color: AppearancePage.field(context),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppearancePage.line(context)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              report.iconAsset,
              width: 22,
              height: 22,
              colorFilter: AppearancePage.iconFilter(context),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    report.title,
                    style: KolekText.sans(
                      size: 14,
                      weight: FontWeight.w600,
                      height: 1.2,
                      color: AppearancePage.foreground(context),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    report.subtitle,
                    style: KolekText.sans(
                      size: 12,
                      weight: FontWeight.w400,
                      height: 1.3,
                      color: AppearancePage.muted(context),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right,
              size: 22,
              color: AppearancePage.icon(context),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// No matches state
// ─────────────────────────────────────────────────────────────────────────

class _NoMatches extends StatelessWidget {
  const _NoMatches();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          Icon(
            Icons.search_off,
            size: 42,
            color: AppearancePage.muted(context),
          ),
          const SizedBox(height: 12),
          Text(
            'No results found',
            style: KolekText.sans(
              size: 15,
              weight: FontWeight.w500,
              color: AppearancePage.muted(context),
            ),
          ),
        ],
      ),
    );
  }
}