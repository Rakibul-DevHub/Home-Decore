// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../routes/app_route.dart';
// import '../../../screens/appearance/appearance_page.dart';
// import '../../../theme/kolek_colors.dart';
// import '../../../widgets/kolek_widgets.dart';
// import '../bloc/new_post_bloc.dart';
// import '../bloc/new_post_event.dart';
// import '../bloc/new_post_state.dart';
// import '../data/new_post_data.dart';
// import 'new_post_details_screen.dart';
//
// class NewPostMediaScreen extends StatefulWidget {
//   const NewPostMediaScreen({super.key});
//
//   @override
//   State<NewPostMediaScreen> createState() => _NewPostMediaScreenState();
// }
//
// class _NewPostMediaScreenState extends State<NewPostMediaScreen> {
//   bool _isFullScreen = false;
//
//   @override
//   void dispose() {
//     _restoreSystemUi();
//     super.dispose();
//   }
//
//   Future<void> _enterFullScreen() async {
//     setState(() => _isFullScreen = true);
//     // Hand system-bar control back to the native layer.
//     await _restoreSystemUi();
//   }
//
//   Future<void> _exitFullScreen() async {
//     setState(() => _isFullScreen = false);
//     await _restoreSystemUi();
//   }
//
//   /// Refreshes layout bounds back to the app default (edge-to-edge), which
//   /// lets MainActivity.kt enforce its native nav-bar auto-hide behavior.
//   Future<void> _restoreSystemUi() async {
//     await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
//   }
//
//   void _openDetails(BuildContext context) {
//     final bloc = context.read<NewPostBloc>();
//     Navigator.of(context).push(
//       MaterialPageRoute<void>(
//         settings: const RouteSettings(name: AppRoute.newPostDetails),
//         builder: (_) => BlocProvider.value(
//           value: bloc,
//           child: const NewPostDetailsScreen(),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: !_isFullScreen,
//       onPopInvokedWithResult: (didPop, _) {
//         if (!didPop && _isFullScreen) {
//           _exitFullScreen();
//         }
//       },
//       child: Scaffold(
//         backgroundColor: AppearancePage.background(context),
//         appBar: _isFullScreen
//             ? null
//             : AppBar(
//           backgroundColor: AppearancePage.background(context),
//           scrolledUnderElevation: 0,
//           systemOverlayStyle: AppearancePage.overlay(context),
//           leading: IconButton(
//             onPressed: () => Navigator.of(context).pop(),
//             icon: Icon(
//               Icons.cancel,
//               size: 28,
//               color: AppearancePage.foreground(context),
//             ),
//           ),
//           centerTitle: true,
//           title: Text(
//             'New Post',
//             style: KolekText.sans(
//               size: 16,
//               weight: FontWeight.w700,
//               color: AppearancePage.foreground(context),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => _openDetails(context),
//               child: Text(
//                 'Next',
//                 style: KolekText.sans(
//                   size: 14,
//                   weight: FontWeight.w600,
//                   color: KolekColors.blue600,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         body: BlocBuilder<NewPostBloc, NewPostState>(
//           builder: (context, state) {
//             final preview = NewPostData.gallery[state.previewIndex];
//
//             if (_isFullScreen) {
//               return _FullScreenPreview(
//                 imagePath: preview,
//                 onClose: _exitFullScreen,
//               );
//             }
//
//             return Column(
//               children: [
//                 AspectRatio(
//                   aspectRatio: 1,
//                   child: Stack(
//                     fit: StackFit.expand,
//                     children: [
//                       Image.asset(preview, fit: BoxFit.cover),
//                       Positioned(
//                         right: 12,
//                         bottom: 12,
//                         child: Material(
//                           color: AppearancePage.menu(context),
//                           shape: const CircleBorder(),
//                           child: InkWell(
//                             customBorder: const CircleBorder(),
//                             onTap: _enterFullScreen,
//                             child: SizedBox(
//                               width: 32,
//                               height: 32,
//                               child: Icon(
//                                 Icons.open_in_full,
//                                 size: 16,
//                                 color: AppearancePage.foreground(context),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
//                   child: Row(
//                     children: [
//                       Text(
//                         'Recent',
//                         style: KolekText.sans(
//                           size: 14,
//                           color: AppearancePage.foreground(context),
//                         ),
//                       ),
//                       Icon(
//                         Icons.keyboard_arrow_down,
//                         size: 18,
//                         color: AppearancePage.icon(context),
//                       ),
//                       const Spacer(),
//                       Icon(
//                         Icons.photo_camera_outlined,
//                         size: 22,
//                         color: AppearancePage.icon(context),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: GridView.builder(
//                     padding: const EdgeInsets.symmetric(horizontal: 2),
//                     itemCount: NewPostData.gallery.length,
//                     gridDelegate:
//                     const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       crossAxisSpacing: 2,
//                       mainAxisSpacing: 2,
//                     ),
//                     itemBuilder: (context, index) {
//                       final selected = state.selectedIndexes.contains(index);
//                       final badge = selected
//                           ? state.selectedIndexes.indexOf(index) + 1
//                           : null;
//                       return GestureDetector(
//                         onTap: () {
//                           context
//                               .read<NewPostBloc>()
//                               .add(NewPostImageToggled(index));
//                           context
//                               .read<NewPostBloc>()
//                               .add(NewPostPreviewSet(index));
//                         },
//                         child: Stack(
//                           fit: StackFit.expand,
//                           children: [
//                             Image.asset(
//                               NewPostData.gallery[index],
//                               fit: BoxFit.cover,
//                             ),
//                             if (selected)
//                               Container(
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                     color: KolekColors.blue600,
//                                     width: 3,
//                                   ),
//                                 ),
//                               ),
//                             if (badge != null)
//                               Positioned(
//                                 top: 6,
//                                 right: 6,
//                                 child: CircleAvatar(
//                                   radius: 11,
//                                   backgroundColor: KolekColors.blue600,
//                                   child: Text(
//                                     '$badge',
//                                     style: KolekText.sans(
//                                       size: 11,
//                                       color: Colors.white,
//                                       weight: FontWeight.w700,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class _FullScreenPreview extends StatelessWidget {
//   const _FullScreenPreview({
//     required this.imagePath,
//     required this.onClose,
//   });
//
//   final String imagePath;
//   final VoidCallback onClose;
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       fit: StackFit.expand,
//       children: [
//         Container(color: Colors.black),
//         Center(child: Image.asset(imagePath, fit: BoxFit.contain)),
//         Positioned(
//           top: MediaQuery.paddingOf(context).top + 12,
//           left: 12,
//           child: IconButton(
//             onPressed: onClose,
//             icon: const Icon(
//               Icons.arrow_back,
//               color: Colors.white,
//               size: 28,
//             ),
//           ),
//         ),
//       ],
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

  IconData _iconFor(String label) => switch (label) {
    'Add Location' => Icons.location_on_outlined,
    'Add Hashtags' => Icons.tag,
    _ => Icons.tune,
  };

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
          icon: const Icon(
            Icons.arrow_back,
            size: 22,
            color: Colors.black,
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
              ...NewPostData.settings.map(
                    (label) => Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      minLeadingWidth: 28,
                      visualDensity: const VisualDensity(vertical: -1),
                      leading: Icon(
                        _iconFor(label),
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
                ),
              ),
              const SizedBox(height: 20),
              const _FooterBrandCard(),
            ],
          );
        },
      ),
    );
  }
}

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