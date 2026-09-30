// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import '../../../routes/app_route.dart';
// import '../../../screens/appearance/appearance_page.dart';
// import '../../../screens/main_shell/cubit/main_shell_cubit.dart';
// import '../../../theme/kolek_colors.dart';
// import '../bloc/home_bloc.dart';
// import '../bloc/home_event.dart';
// import '../bloc/home_state.dart';
// import '../data/home_data.dart';
//
// part 'home_colors.dart';
// part 'home_anchored_menu.dart';
// part 'home_comment_body.dart';
// part 'home_comment_composer.dart';
// part 'home_comment_thread.dart';
// part 'home_comments_sheet.dart';
// part 'home_feed_card.dart';
// part 'home_header.dart';
// part 'home_post_menu.dart';
// part 'home_share_sheet.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   Future<void> _showComments(BuildContext context, HomePost post) async {
//     final bloc = context.read<HomeBloc>()..add(HomeCommentsOpened(post.id));
//     await showModalBottomSheet<void>(
//       context: context,
//       isScrollControlled: true,
//       enableDrag: false,
//       backgroundColor: Colors.transparent,
//       sheetAnimationStyle: const AnimationStyle(
//         duration: Duration(milliseconds: 240),
//         reverseDuration: Duration(milliseconds: 180),
//         curve: Curves.easeOutCubic,
//         reverseCurve: Curves.easeInCubic,
//       ),
//       builder: (_) => _CommentsSheet(isPostOwner: post.ownedByViewer),
//     );
//     bloc.add(const HomeCommentsClosed());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final colors = _HomeColors.of(context);
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: colors.overlay,
//       child: Scaffold(
//         backgroundColor: colors.canvas,
//         appBar: const _KolekHeader(),
//         body: BlocBuilder<HomeBloc, HomeState>(
//           builder: (context, state) => ListView.separated(
//             itemCount: HomeData.posts.length,
//             separatorBuilder: (_, _) =>
//                 Divider(height: 1, thickness: 1, color: colors.line),
//             itemBuilder: (context, index) {
//               final post = HomeData.posts[index];
//               return _FeedCard(
//                 post: post,
//                 saved: state.savedPostIds.contains(post.id),
//                 liked: state.likedPostIds.contains(post.id),
//                 onSaved: () =>
//                     context.read<HomeBloc>().add(HomeSavedToggled(post.id)),
//                 onReact: () =>
//                     context.read<HomeBloc>().add(HomeReactToggled(post.id)),
//                 onComments: () => _showComments(context, post),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }



///
///
///
/// todo:: hiding the header while scroll
///
///
///




import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../routes/app_route.dart';
import '../../../screens/appearance/appearance_page.dart';
import '../../../screens/main_shell/cubit/main_shell_cubit.dart';
import '../../../theme/kolek_colors.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../data/home_data.dart';

part 'home_colors.dart';
part 'home_anchored_menu.dart';
part 'home_comment_body.dart';
part 'home_comment_composer.dart';
part 'home_comment_thread.dart';
part 'home_comments_sheet.dart';
part 'home_feed_card.dart';
part 'home_header.dart';
part 'home_post_menu.dart';
part 'home_share_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _showComments(BuildContext context, HomePost post) async {
    final bloc = context.read<HomeBloc>()..add(HomeCommentsOpened(post.id));
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      sheetAnimationStyle: const AnimationStyle(
        duration: Duration(milliseconds: 240),
        reverseDuration: Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      ),
      builder: (_) => _CommentsSheet(isPostOwner: post.ownedByViewer),
    );
    bloc.add(const HomeCommentsClosed());
  }

  @override
  Widget build(BuildContext context) {
    final colors = _HomeColors.of(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: colors.overlay,
      child: Scaffold(
        backgroundColor: colors.canvas,
        // No `appBar:` here anymore — the header is now a sliver.
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) => CustomScrollView(
            slivers: [
              const _KolekHeader(),
              SliverList.separated(
                itemCount: HomeData.posts.length,
                separatorBuilder: (_, _) =>
                    Divider(height: 1, thickness: 1, color: colors.line),
                itemBuilder: (context, index) {
                  final post = HomeData.posts[index];
                  return _FeedCard(
                    post: post,
                    saved: state.savedPostIds.contains(post.id),
                    liked: state.likedPostIds.contains(post.id),
                    onSaved: () => context
                        .read<HomeBloc>()
                        .add(HomeSavedToggled(post.id)),
                    onReact: () => context
                        .read<HomeBloc>()
                        .add(HomeReactToggled(post.id)),
                    onComments: () => _showComments(context, post),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}