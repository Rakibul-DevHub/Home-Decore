// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../routes/app_route.dart';
// import '../../../screens/appearance/appearance_page.dart';
// import '../../../theme/kolek_colors.dart';
// import '../../../widgets/kolek_widgets.dart';
// import '../bloc/new_post_bloc.dart';
// import '../bloc/new_post_event.dart';
// import '../bloc/new_post_state.dart';
// import '../data/new_post_data.dart';
//
// class NewPostDetailsScreen extends StatelessWidget {
//   const NewPostDetailsScreen({super.key});
//
//   IconData _iconFor(String label) => switch (label) {
//     'Add Location' => Icons.location_on_outlined,
//     'Add Hashtags' => Icons.tag,
//     _ => Icons.tune,
//   };
//
//   String _captionCountLabel(int length) {
//     final max = NewPostData.maxCaptionLength;
//     final maxLabel = max >= 1000
//         ? '${max ~/ 1000},${(max % 1000).toString().padLeft(3, '0')}'
//         : '$max';
//     return '$length/$maxLabel';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppearancePage.background(context),
//       appBar: AppBar(
//         backgroundColor: AppearancePage.background(context),
//         scrolledUnderElevation: 0,
//         systemOverlayStyle: AppearancePage.overlay(context),
//         leading: IconButton(
//           onPressed: () => Navigator.of(context).pop(),
//           icon: const Icon(
//             Icons.arrow_back,
//             size: 22,
//             color: Colors.black,
//           ),
//         ),
//         centerTitle: true,
//         title: Text(
//           'New Post',
//           style: KolekText.sans(
//             size: 16,
//             weight: FontWeight.w700,
//             color: AppearancePage.foreground(context),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).popUntil(
//                     (route) => route.settings.name == AppRoute.mainShell,
//               );
//             },
//             child: Text(
//               'Share',
//               style: KolekText.sans(
//                 size: 14,
//                 weight: FontWeight.w600,
//                 color: KolekColors.blue600,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: BlocBuilder<NewPostBloc, NewPostState>(
//         builder: (context, state) {
//           return ListView(
//             padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
//             children: [
//               SizedBox(
//                 height: 200,
//                 child: ListView.separated(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: state.selectedIndexes.length,
//                   separatorBuilder: (_, _) => const SizedBox(width: 8),
//                   itemBuilder: (context, index) {
//                     final galleryIndex = state.selectedIndexes[index];
//                     return Stack(
//                       clipBehavior: Clip.none,
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(6),
//                           child: Image.asset(
//                             NewPostData.gallery[galleryIndex],
//                             width: 130,
//                             height: 160,
//                             fit: BoxFit.fitHeight,
//                           ),
//                         ),
//                         Positioned(
//                           top: 1,
//                           right: 1,
//                           child: GestureDetector(
//                             onTap: () => context
//                                 .read<NewPostBloc>()
//                                 .add(NewPostImageRemoved(galleryIndex)),
//                             child: const CircleAvatar(
//                               radius: 14,
//                               backgroundColor: Colors.black,
//                               child: Icon(
//                                 Icons.close,
//                                 size: 14,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(height: 12),
//               TextField(
//                 maxLines: 4,
//                 minLines: 3,
//                 onChanged: (value) => context
//                     .read<NewPostBloc>()
//                     .add(NewPostCaptionChanged(value)),
//                 style: KolekText.sans(
//                   size: 14,
//                   color: AppearancePage.foreground(context),
//                 ),
//                 cursorColor: KolekColors.blue600,
//                 decoration: InputDecoration(
//                   hintText: 'Write a caption',
//                   hintStyle: KolekText.sans(
//                     size: 14,
//                     color: AppearancePage.muted(context),
//                   ),
//                   border: InputBorder.none,
//                   isDense: true,
//                   contentPadding: EdgeInsets.zero,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: Text(
//                   _captionCountLabel(state.caption.length),
//                   style: KolekText.mono(
//                     size: 10,
//                     color: AppearancePage.muted(context),
//                   ),
//                 ),
//               ),
//               Divider(
//                 height: 1,
//                 thickness: 1,
//                 color: AppearancePage.line(context),
//               ),
//               ...NewPostData.settings.map(
//                     (label) => Column(
//                   children: [
//                     ListTile(
//                       contentPadding: EdgeInsets.zero,
//                       minLeadingWidth: 28,
//                       visualDensity: const VisualDensity(vertical: -1),
//                       leading: Icon(
//                         _iconFor(label),
//                         size: 22,
//                         color: AppearancePage.icon(context),
//                       ),
//                       title: Text(
//                         label,
//                         style: KolekText.sans(
//                           size: 14,
//                           color: AppearancePage.foreground(context),
//                         ),
//                       ),
//                       trailing: Icon(
//                         Icons.chevron_right,
//                         size: 20,
//                         color: AppearancePage.icon(context),
//                       ),
//                       onTap: () {},
//                     ),
//                     Divider(
//                       height: 1,
//                       thickness: 1,
//                       color: AppearancePage.line(context),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const _FooterBrandCard(),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
//
// class _FooterBrandCard extends StatelessWidget {
//   const _FooterBrandCard();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 210,
//       decoration: BoxDecoration(
//         color: AppearancePage.menu(context),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: AppearancePage.line(context)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       clipBehavior: Clip.hardEdge,
//       child: Stack(
//         children: [
//           Positioned(
//             left: 16,
//             top: 18,
//             right: 130,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const KolekTextLogo(height: 20),
//                 const SizedBox(height: 30),
//                 Text(
//                   NewPostData.footerTagline,
//                   style: KolekText.sans(
//                     size: 13,
//                     weight: FontWeight.w600,
//                     height: 1.3,
//                     color: AppearancePage.foreground(context),
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Container(
//                   width: 26,
//                   height: 3,
//                   color: AppearancePage.foreground(context),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             right: 0,
//             bottom: -8,
//             child: Image.asset(
//               NewPostData.footerArt,
//               height: 180,
//               fit: BoxFit.contain,
//               alignment: Alignment.bottomRight,
//             ),
//           ),
//         ],
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
import '../bloc/new_post_bloc.dart';
import '../bloc/new_post_event.dart';
import '../bloc/new_post_state.dart';
import '../data/new_post_data.dart';

class NewPostDetailsScreen extends StatelessWidget {
  const NewPostDetailsScreen({super.key});

  String _captionCountLabel(int length) {
    final max = NewPostData.maxCaptionLength;
    final maxLabel = max >= 1000
        ? '${max ~/ 1000},${(max % 1000).toString().padLeft(3, '0')}'
        : '$max';
    return '$length/$maxLabel';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      appBar: AppBar(
        backgroundColor: AppearancePage.background(context),
        scrolledUnderElevation: 0,
        systemOverlayStyle: AppearancePage.overlay(context),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back,
            size: 22,
            color: AppearancePage.icon(context),
          ),
        ),
        centerTitle: true,
        title: Text(
          'New Post',
          style: KolekText.sans(
            size: 16,
            weight: FontWeight.w700,
            color: AppearancePage.foreground(context),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).popUntil(
                    (route) => route.settings.name == AppRoute.mainShell,
              );
            },
            child: Text(
              'Share',
              style: KolekText.sans(
                size: 14,
                weight: FontWeight.w600,
                color: KolekColors.blue600,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<NewPostBloc, NewPostState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              // ── Image strip ────────────────────────────────────────
              SizedBox(
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.selectedIndexes.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final galleryIndex = state.selectedIndexes[index];
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            NewPostData.gallery[galleryIndex],
                            width: 130,
                            height: 160,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Positioned(
                          top: 1,
                          right: 1,
                          child: GestureDetector(
                            onTap: () => context
                                .read<NewPostBloc>()
                                .add(NewPostImageRemoved(galleryIndex)),
                            child: const CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.black,
                              child: Icon(
                                Icons.close,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),

              // ── Caption ────────────────────────────────────────────
              TextField(
                maxLines: 4,
                minLines: 3,
                onChanged: (value) => context
                    .read<NewPostBloc>()
                    .add(NewPostCaptionChanged(value)),
                style: KolekText.sans(
                  size: 14,
                  color: AppearancePage.foreground(context),
                ),
                cursorColor: KolekColors.blue600,
                decoration: InputDecoration(
                  hintText: 'Write a caption',
                  hintStyle: KolekText.sans(
                    size: 14,
                    color: AppearancePage.muted(context),
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  _captionCountLabel(state.caption.length),
                  style: KolekText.mono(
                    size: 10,
                    color: AppearancePage.muted(context),
                  ),
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: AppearancePage.line(context),
              ),

              // ── Settings rows ──────────────────────────────────────
              ...NewPostData.settings.map((label) {
                if (label == 'Add Hashtags') {
                  return _HashtagsRow(
                    expanded: state.hashtagsExpanded,
                    hashtags: state.hashtags,
                  );
                }
                return _SimpleRow(
                  label: label,
                  icon: _iconFor(label),
                );
              }),

              const SizedBox(height: 20),
              const _FooterBrandCard(),
            ],
          );
        },
      ),
    );
  }

  IconData _iconFor(String label) => switch (label) {
    'Add Location' => Icons.location_on_outlined,
    'Add Hashtags' => Icons.tag,
    _ => Icons.tune,
  };
}

// ─────────────────────────────────────────────────────────────────────────
// Simple (non-expandable) row — Add Location
// ─────────────────────────────────────────────────────────────────────────

class _SimpleRow extends StatelessWidget {
  const _SimpleRow({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          minLeadingWidth: 28,
          visualDensity: const VisualDensity(vertical: -1),
          leading: Icon(
            icon,
            size: 22,
            color: AppearancePage.icon(context),
          ),
          title: Text(
            label,
            style: KolekText.sans(
              size: 14,
              color: AppearancePage.foreground(context),
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            size: 20,
            color: AppearancePage.icon(context),
          ),
          onTap: () {},
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: AppearancePage.line(context),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Expandable hashtag row
// ─────────────────────────────────────────────────────────────────────────

/// Header row for "Add Hashtags". Tapping the row toggles the input
/// section below it. The trailing chevron rotates from pointing right
/// (closed) to pointing down (open).
class _HashtagsRow extends StatefulWidget {
  const _HashtagsRow({
    required this.expanded,
    required this.hashtags,
  });

  final bool expanded;
  final List<String> hashtags;

  @override
  State<_HashtagsRow> createState() => _HashtagsRowState();
}

class _HashtagsRowState extends State<_HashtagsRow> {
  final _controller = TextEditingController();
  final _focus = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _submit() {
    final raw = _controller.text.trim();
    if (raw.isEmpty) return;
    context.read<NewPostBloc>().add(NewPostHashtagAdded(raw));
    _controller.clear();
    // Keep focus so the user can chain multiple tags without re-tapping.
    _focus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);
    final muted = AppearancePage.muted(context);
    final line = AppearancePage.line(context);

    return Column(
      children: [
        // ── Header row (always visible) ────────────────────────────
        ListTile(
          contentPadding: EdgeInsets.zero,
          minLeadingWidth: 28,
          visualDensity: const VisualDensity(vertical: -1),
          leading: Icon(
            Icons.tag,
            size: 22,
            color: AppearancePage.icon(context),
          ),
          title: Text(
            'Add Hashtags',
            style: KolekText.sans(size: 14, color: fg),
          ),
          trailing: AnimatedRotation(
            // Chevron starts pointing right (0 turns) and rotates 90°
            // clockwise (0.25 turns) to point down when expanded.
            turns: widget.expanded ? 0.25 : 0.0,
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            child: Icon(
              Icons.chevron_right,
              size: 20,
              color: AppearancePage.icon(context),
            ),
          ),
          onTap: () => context
              .read<NewPostBloc>()
              .add(const NewPostHashtagsToggled()),
        ),

        // ── Expandable section ─────────────────────────────────────
        AnimatedSize(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topCenter,
          child: widget.expanded
              ? _HashtagInput(
            controller: _controller,
            focusNode: _focus,
            hashtags: widget.hashtags,
            onSubmit: _submit,
            onRemove: (tag) => context
                .read<NewPostBloc>()
                .add(NewPostHashtagRemoved(tag)),
            fg: fg,
            muted: muted,
            line: line,
          )
              : const SizedBox.shrink(),
        ),

        Divider(height: 1, thickness: 1, color: line),
      ],
    );
  }
}

/// The input field + chips shown under the hashtags header when expanded.
class _HashtagInput extends StatelessWidget {
  const _HashtagInput({
    required this.controller,
    required this.focusNode,
    required this.hashtags,
    required this.onSubmit,
    required this.onRemove,
    required this.fg,
    required this.muted,
    required this.line,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final List<String> hashtags;
  final VoidCallback onSubmit;
  final ValueChanged<String> onRemove;
  final Color fg;
  final Color muted;
  final Color line;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Input + add button ───────────────────────────────────
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppearancePage.field(context),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: line),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '#',
                        style: KolekText.sans(
                          size: 14,
                          weight: FontWeight.w600,
                          color: muted,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: TextField(
                          controller: controller,
                          focusNode: focusNode,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => onSubmit(),
                          style: KolekText.sans(size: 14, color: fg),
                          cursorColor: KolekColors.blue600,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Add a hashtag',
                            hintStyle: KolekText.sans(
                              size: 14,
                              color: muted,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Material(
                color: KolekColors.blue600,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  onTap: onSubmit,
                  borderRadius: BorderRadius.circular(8),
                  child: const SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.add,
                      size: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ── Chips for added tags ─────────────────────────────────
          if (hashtags.isNotEmpty) ...[
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final tag in hashtags)
                  _HashtagChip(tag: tag, onRemove: () => onRemove(tag)),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// Small pill showing "#tag" with a ✕ to remove it.
class _HashtagChip extends StatelessWidget {
  const _HashtagChip({required this.tag, required this.onRemove});

  final String tag;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 6, 6, 6),
      decoration: BoxDecoration(
        color: KolekColors.blue600.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: KolekColors.blue600.withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '#$tag',
            style: KolekText.sans(
              size: 13,
              weight: FontWeight.w500,
              color: KolekColors.blue600,
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: onRemove,
            behavior: HitTestBehavior.opaque,
            child: const Padding(
              padding: EdgeInsets.all(2),
              child: Icon(
                Icons.close,
                size: 14,
                color: KolekColors.blue600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Footer brand card
// ─────────────────────────────────────────────────────────────────────────

class _FooterBrandCard extends StatelessWidget {
  const _FooterBrandCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      decoration: BoxDecoration(
        color: AppearancePage.menu(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppearancePage.line(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned(
            left: 16,
            top: 18,
            right: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const KolekTextLogo(height: 20),
                const SizedBox(height: 30),
                Text(
                  NewPostData.footerTagline,
                  style: KolekText.sans(
                    size: 13,
                    weight: FontWeight.w600,
                    height: 1.3,
                    color: AppearancePage.foreground(context),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: 26,
                  height: 3,
                  color: AppearancePage.foreground(context),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            bottom: -8,
            child: Image.asset(
              NewPostData.footerArt,
              height: 180,
              fit: BoxFit.contain,
              alignment: Alignment.bottomRight,
            ),
          ),
        ],
      ),
    );
  }
}