// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../../routes/app_route.dart';
// import '../../../screens/appearance/appearance_page.dart';
// import '../../../theme/kolek_colors.dart';
// import '../../../widgets/kolek_widgets.dart';
// import '../bloc/message_bloc.dart';
// import '../bloc/message_event.dart';
// import '../bloc/messages_state.dart';
// import '../data/messages_data.dart';
//
// class MessagesScreen extends StatelessWidget {
//   const MessagesScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppearancePage.background(context),
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const _MessagesHeader(),
//             Expanded(
//               child: BlocBuilder<MessagesBloc, MessagesState>(
//                 builder: (context, state) {
//                   final threads = state.visibleThreads;
//                   return ListView.separated(
//                     padding: const EdgeInsets.only(top: 4),
//                     itemCount: threads.length,
//                     separatorBuilder: (_, _) => Divider(
//                       height: 1,
//                       thickness: 1,
//                       color: AppearancePage.line(context),
//                       indent: 18,
//                       endIndent: 18,
//                     ),
//                     itemBuilder: (context, index) {
//                       final thread = threads[index];
//                       return _MessageTile(
//                         thread: thread,
//                         onTap: () => Navigator.of(context).pushNamed(
//                           AppRoute.inbox,
//                           arguments: thread,
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ─────────────────────────────────────────────────────────────────────────
// // Header: logo → search field → folder title row
// // ─────────────────────────────────────────────────────────────────────────
//
// class _MessagesHeader extends StatelessWidget {
//   const _MessagesHeader();
//
//   @override
//   Widget build(BuildContext context) {
//     return const Padding(
//       padding: EdgeInsets.fromLTRB(18, 12, 18, 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           KolekTextLogo(height: 22),
//           SizedBox(height: 18),
//           _MessagesSearchField(),
//           SizedBox(height: 18),
//           _FolderTitle(),
//         ],
//       ),
//     );
//   }
// }
//
// /// Search input bound to the bloc's query events.
// ///
// /// Typing dispatches [MessagesQueryChanged] so the list filters live.
// /// Tapping the clear icon dispatches [MessagesQueryCleared] and empties
// /// the field.
// class _MessagesSearchField extends StatefulWidget {
//   const _MessagesSearchField();
//
//   @override
//   State<_MessagesSearchField> createState() => _MessagesSearchFieldState();
// }
//
// class _MessagesSearchFieldState extends State<_MessagesSearchField> {
//   final _controller = TextEditingController();
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void _onChanged(String value) {
//     setState(() {}); // refresh the clear-icon visibility
//     context.read<MessagesBloc>().add(MessagesQueryChanged(value));
//   }
//
//   void _clear() {
//     _controller.clear();
//     setState(() {});
//     context.read<MessagesBloc>().add(const MessagesQueryCleared());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 46,
//       padding: const EdgeInsets.symmetric(horizontal: 14),
//       decoration: BoxDecoration(
//         color: AppearancePage.field(context),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Row(
//         children: [
//           SvgPicture.asset(
//             'assets/icons/search.svg',
//             width: 20,
//             height: 20,
//             colorFilter: AppearancePage.iconFilter(context),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: TextField(
//               controller: _controller,
//               onChanged: _onChanged,
//               textInputAction: TextInputAction.search,
//               style: KolekText.mono(
//                 size: 14,
//                 color: AppearancePage.foreground(context),
//               ),
//               cursorColor: KolekColors.blue600,
//               decoration: InputDecoration(
//                 isDense: true,
//                 hintText: 'Search Person',
//                 hintStyle: KolekText.mono(
//                   size: 14,
//                   color: AppearancePage.muted(context),
//                 ),
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.zero,
//               ),
//             ),
//           ),
//           if (_controller.text.isNotEmpty)
//             GestureDetector(
//               onTap: _clear,
//               behavior: HitTestBehavior.opaque,
//               child: Padding(
//                 padding: const EdgeInsets.all(4),
//                 child: Icon(
//                   Icons.close,
//                   size: 20,
//                   color: AppearancePage.icon(context),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
//
// /// "ALL MESSAGES ⌄" row — reads the folder title from the bloc.
// class _FolderTitle extends StatelessWidget {
//   const _FolderTitle();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocSelector<MessagesBloc, MessagesState, String>(
//       selector: (s) => s.folderTitle,
//       builder: (context, folderTitle) {
//         return GestureDetector(
//           onTap: () {},
//           behavior: HitTestBehavior.opaque,
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 folderTitle.toUpperCase(),
//                 style: KolekText.sans(
//                   size: 14,
//                   weight: FontWeight.w600,
//                   letterSpacing: 0.8,
//                   height: 1.0,
//                   color: AppearancePage.foreground(context),
//                 ),
//               ),
//               const SizedBox(width: 6),
//               Icon(
//                 Icons.keyboard_arrow_down,
//                 size: 20,
//                 color: AppearancePage.icon(context),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
// // ─────────────────────────────────────────────────────────────────────────
// // List tile
// // ─────────────────────────────────────────────────────────────────────────
//
// class _MessageTile extends StatelessWidget {
//   const _MessageTile({required this.thread, required this.onTap});
//
//   final MessageThread thread;
//   final VoidCallback onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
//         child: Row(
//           children: [
//             ClipOval(
//               child: Image.asset(
//                 thread.avatarAsset,
//                 width: 48,
//                 height: 48,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     thread.name,
//                     style: KolekText.sans(
//                       size: 15,
//                       weight: FontWeight.w700,
//                       color: AppearancePage.foreground(context),
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     thread.preview,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: KolekText.sans(
//                       size: 13,
//                       weight: FontWeight.w400,
//                       color: AppearancePage.secondary(context),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 10),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(
//                   thread.timeLabel,
//                   style: KolekText.sans(
//                     size: 12,
//                     weight: FontWeight.w400,
//                     color: AppearancePage.muted(context),
//                   ),
//                 ),
//                 if (thread.unreadCount > 0) ...[
//                   const SizedBox(height: 8),
//                   Container(
//                     width: 22,
//                     height: 22,
//                     alignment: Alignment.center,
//                     decoration: const BoxDecoration(
//                       color: KolekColors.blue600,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Text(
//                       '${thread.unreadCount}',
//                       style: KolekText.sans(
//                         size: 11,
//                         weight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }











import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../routes/app_route.dart';
import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../bloc/message_bloc.dart';
import '../bloc/message_event.dart';
import '../bloc/messages_state.dart';
import '../data/messages_data.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _MessagesHeader(),
            Expanded(
              child: BlocBuilder<MessagesBloc, MessagesState>(
                builder: (context, state) {
                  final threads = state.visibleThreads;
                  return ListView.separated(
                    padding: const EdgeInsets.only(top: 4),
                    itemCount: threads.length,
                    separatorBuilder: (_, _) => Divider(
                      height: 1,
                      thickness: 1,
                      color: AppearancePage.line(context),
                      indent: 18,
                      endIndent: 18,
                    ),
                    itemBuilder: (context, index) {
                      final thread = threads[index];
                      return _MessageTile(
                        thread: thread,
                        onTap: () => Navigator.of(context).pushNamed(
                          AppRoute.inbox,
                          arguments: thread,
                        ),
                      );
                    },
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
// Header: logo → search field → filter tabs
// ─────────────────────────────────────────────────────────────────────────

class _MessagesHeader extends StatelessWidget {
  const _MessagesHeader();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(18, 12, 18, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KolekTextLogo(height: 22),
          SizedBox(height: 18),
          _MessagesSearchField(),
          SizedBox(height: 16),
          _FilterTabs(),
        ],
      ),
    );
  }
}

/// Search input bound to the bloc's query events.
///
/// Typing dispatches [MessagesQueryChanged] so the list filters live.
/// Tapping the clear icon dispatches [MessagesQueryCleared] and empties
/// the field.
class _MessagesSearchField extends StatefulWidget {
  const _MessagesSearchField();

  @override
  State<_MessagesSearchField> createState() => _MessagesSearchFieldState();
}

class _MessagesSearchFieldState extends State<_MessagesSearchField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    setState(() {}); // refresh the clear-icon visibility
    context.read<MessagesBloc>().add(MessagesQueryChanged(value));
  }

  void _clear() {
    _controller.clear();
    setState(() {});
    context.read<MessagesBloc>().add(const MessagesQueryCleared());
  }

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
          SvgPicture.asset(
            'assets/icons/search.svg',
            width: 20,
            height: 20,
            colorFilter: AppearancePage.iconFilter(context),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: _onChanged,
              textInputAction: TextInputAction.search,
              style: KolekText.mono(
                size: 14,
                color: AppearancePage.foreground(context),
              ),
              cursorColor: KolekColors.blue600,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Search Person',
                hintStyle: KolekText.mono(
                  size: 14,
                  color: AppearancePage.muted(context),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (_controller.text.isNotEmpty)
            GestureDetector(
              onTap: _clear,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Icon(
                  Icons.close,
                  size: 20,
                  color: AppearancePage.icon(context),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Two filter tabs: "All Message" / "Unread".
///
/// Uses [MainAxisAlignment.spaceAround] so both tabs sit at equal distance
/// from the edges and from each other.
class _FilterTabs extends StatelessWidget {
  const _FilterTabs();

  static const _tabs = <_FilterTabData>[
    _FilterTabData(label: 'All Message', value: MessagesFilter.all),
    _FilterTabData(label: 'Unread', value: MessagesFilter.unread),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocSelector<MessagesBloc, MessagesState, MessagesFilter>(
      selector: (s) => s.filter,
      builder: (context, selected) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (final tab in _tabs)
              _FilterTab(
                data: tab,
                selected: selected == tab.value,
                onTap: () => context
                    .read<MessagesBloc>()
                    .add(MessagesFilterChanged(tab.value)),
              ),
          ],
        );
      },
    );
  }
}

class _FilterTabData {
  const _FilterTabData({required this.label, required this.value});

  final String label;
  final MessagesFilter value;
}

class _FilterTab extends StatelessWidget {
  const _FilterTab({
    required this.data,
    required this.selected,
    required this.onTap,
  });

  final _FilterTabData data;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = KolekColors.blue600;
    final fg = selected ? accent : AppearancePage.muted(context);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            data.label.toUpperCase(),
            style: KolekText.sans(
              size: 13,
              weight: FontWeight.w600,
              letterSpacing: 0.6,
              height: 1.0,
              color: fg,
            ),
          ),
          const SizedBox(height: 8),
          // 2px underline — transparent when unselected so layout doesn't
          // shift as the user switches tabs.
          Container(
            height: 2,
            width: 32,
            decoration: BoxDecoration(
              color: selected ? accent : Colors.transparent,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// List tile
// ─────────────────────────────────────────────────────────────────────────

class _MessageTile extends StatelessWidget {
  const _MessageTile({required this.thread, required this.onTap});

  final MessageThread thread;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                thread.avatarAsset,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    thread.name,
                    style: KolekText.sans(
                      size: 15,
                      weight: FontWeight.w700,
                      color: AppearancePage.foreground(context),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    thread.preview,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: KolekText.sans(
                      size: 13,
                      weight: FontWeight.w400,
                      color: AppearancePage.secondary(context),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  thread.timeLabel,
                  style: KolekText.sans(
                    size: 12,
                    weight: FontWeight.w400,
                    color: AppearancePage.muted(context),
                  ),
                ),
                if (thread.unreadCount > 0) ...[
                  const SizedBox(height: 8),
                  Container(
                    width: 22,
                    height: 22,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: KolekColors.blue600,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${thread.unreadCount}',
                      style: KolekText.sans(
                        size: 11,
                        weight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}