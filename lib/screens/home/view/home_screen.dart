import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../routes/app_route.dart';
import '../../../screens/main_shell/cubit/main_shell_cubit.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../cubit/home_cubit.dart';
import '../data/home_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _showComments(BuildContext context, String postId) async {
    final cubit = context.read<HomeCubit>()..openComments(postId);
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _CommentsSheet(),
    );
    cubit.closeComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const _KolekHeader(),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => ListView.separated(
          itemCount: HomeData.posts.length,
          separatorBuilder: (_, _) =>
              const Divider(height: 1, thickness: 1, color: KolekColors.neutral200),
          itemBuilder: (context, index) {
            final post = HomeData.posts[index];
            return _FeedCard(
              post: post,
              saved: state.savedPostIds.contains(post.id),
              onSaved: () => context.read<HomeCubit>().toggleSaved(post.id),
              onComments: () => _showComments(context, post.id),
            );
          },
        ),
      ),
    );
  }
}

class _KolekHeader extends StatelessWidget implements PreferredSizeWidget {
  const _KolekHeader();

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: IconButton(
        onPressed: () async {
          final result = await Navigator.of(context).pushNamed(AppRoute.search);
          if (result == AppRoute.shop && context.mounted) {
            context.read<MainShellCubit>().switchTab(1);
          }
        },
        icon: SvgPicture.asset(
          'assets/icons/search.svg',
          width: 22,
          height: 22,
        ),
      ),
      title: const KolekTextLogo(height: 22),
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/icons/notification_active.svg',
            width: 24,
            height: 24,
          ),
        ),
        const SizedBox(width: 2),
      ],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(height: 1, thickness: 1, color: KolekColors.neutral200),
      ),
    );
  }
}

class _FeedCard extends StatelessWidget {
  const _FeedCard({
    required this.post,
    required this.saved,
    required this.onSaved,
    required this.onComments,
  });

  final HomePost post;
  final bool saved;
  final VoidCallback onSaved;
  final VoidCallback onComments;

  Future<void> _openMenu(BuildContext context) async {
    final button = context.findRenderObject() as RenderBox?;
    final overlayState = Overlay.of(context);
    final overlay =
        overlayState.context.findRenderObject() as RenderBox?;
    if (button == null || overlay == null) return;

    final offset = button.localToGlobal(Offset.zero, ancestor: overlay);
    final completer = Completer<HomeMenuAction?>();
    late OverlayEntry entry;

    void close([HomeMenuAction? action]) {
      if (!completer.isCompleted) {
        completer.complete(action);
      }
      entry.remove();
    }

    entry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: close,
                child: const ColoredBox(color: Colors.transparent),
              ),
            ),
            Positioned(
              top: offset.dy + button.size.height + 12,
              right: overlay.size.width - offset.dx - button.size.width - 4,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.scale(
                      scale: 0.94 + (0.06 * value),
                      alignment: Alignment.topRight,
                      child: child,
                    ),
                  );
                },
                child: _LiquidGlassMenu(onSelected: close),
              ),
            ),
          ],
        );
      },
    );

    overlayState.insert(entry);
    final selected = await completer.future;
    if (selected == HomeMenuAction.savePost) onSaved();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 6, 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.author,
                      style: KolekText.sans(
                        size: 14,
                        weight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      post.location,
                      style: KolekText.sans(
                        size: 11,
                        weight: FontWeight.w400,
                        color: KolekColors.neutral500,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onSaved,
                visualDensity: VisualDensity.compact,
                icon: SvgPicture.asset(
                  'assets/icons/save_post.svg',
                  width: 22,
                  height: 22,
                  colorFilter: ColorFilter.mode(
                    saved ? KolekColors.blue600 : KolekColors.neutral700,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              Builder(
                builder: (buttonContext) => IconButton(
                  onPressed: () => _openMenu(buttonContext),
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(
                    Icons.more_horiz,
                    size: 22,
                    color: KolekColors.neutral900,
                  ),
                ),
              ),
            ],
          ),
        ),
        AspectRatio(
          aspectRatio: 1.15,
          child: Image.asset(
            post.image,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    post.title,
                    style: KolekText.sans(
                      size: 13,
                      weight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  _StatIcon(
                    asset: 'assets/icons/react_border.svg',
                    value: post.likes,
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: onComments,
                    child: _StatIcon(
                      asset: 'assets/icons/comment.svg',
                      value: post.commentCount,
                    ),
                  ),
                  const SizedBox(width: 10),
                  _StatIcon(
                    asset: 'assets/icons/share.svg',
                    value: post.shareCount,
                  ),
                  const SizedBox(width: 10),
                  SvgPicture.asset(
                    'assets/icons/cart.svg',
                    width: 18,
                    height: 18,
                    colorFilter: const ColorFilter.mode(
                      KolekColors.neutral700,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: post.description,
                      style: KolekText.mono(
                        size: 11,
                        color: KolekColors.neutral600,
                        height: 1.45,
                      ),
                    ),
                    TextSpan(
                      text: ' ...more',
                      style: KolekText.mono(
                        size: 11,
                        color: KolekColors.neutral400,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatIcon extends StatelessWidget {
  const _StatIcon({required this.asset, required this.value});

  final String asset;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          asset,
          width: 18,
          height: 18,
          colorFilter: const ColorFilter.mode(
            KolekColors.neutral700,
            BlendMode.srcIn,
          ),
        ),
        if (value != null) ...[
          const SizedBox(width: 4),
          Text(
            value!,
            style: KolekText.mono(size: 10, color: KolekColors.neutral600),
          ),
        ],
      ],
    );
  }
}

class _LiquidGlassMenu extends StatelessWidget {
  const _LiquidGlassMenu({required this.onSelected});

  final ValueChanged<HomeMenuAction> onSelected;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.75),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.10),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.42),
                Colors.white.withValues(alpha: 0.18),
              ],
            ),
          ),
          child: SizedBox(
            width: 168,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i = 0; i < HomeData.menuItems.length; i++) ...[
                  if (i > 0)
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.white.withValues(alpha: 0.55),
                    ),
                  _LiquidGlassMenuItem(
                    item: HomeData.menuItems[i],
                    onTap: () => onSelected(HomeData.menuItems[i].action),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LiquidGlassMenuItem extends StatelessWidget {
  const _LiquidGlassMenuItem({required this.item, required this.onTap});

  final HomeMenuItem item;
  final VoidCallback onTap;

  String? get _asset => switch (item.action) {
    HomeMenuAction.savePost => 'assets/icons/save_post.svg',
    HomeMenuAction.message => 'assets/icons/message.svg',
    HomeMenuAction.report => null,
  };

  @override
  Widget build(BuildContext context) {
    final asset = _asset;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 46,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                if (asset != null)
                  SvgPicture.asset(
                    asset,
                    width: 18,
                    height: 18,
                    colorFilter: const ColorFilter.mode(
                      KolekColors.neutral900,
                      BlendMode.srcIn,
                    ),
                  )
                else
                  const Icon(
                    Icons.report_outlined,
                    size: 18,
                    color: KolekColors.neutral900,
                  ),
                const SizedBox(width: 12),
                Text(
                  item.label,
                  style: KolekText.mono(
                    size: 12,
                    weight: FontWeight.w500,
                    color: KolekColors.neutral900,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CommentsSheet extends StatelessWidget {
  const _CommentsSheet();

  static const _composerAvatar = 'assets/images/demo_user.png';
  static const _generalSans = 'GeneralSans-Regular';
  static const _ibmPlexMono = 'IBMPlexMono-Regular';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 0.72;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        height: height,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: KolekColors.neutral300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Comments',
                style: const TextStyle(
                  fontFamily: _ibmPlexMono,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: KolekColors.neutral900,
                ),
              ),
              const SizedBox(height: 14),
              const Divider(
                height: 1,
                thickness: 1,
                color: KolekColors.neutral200,
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
                  itemCount: HomeData.comments.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 22),
                  itemBuilder: (_, index) {
                    return _CommentTile(comment: HomeData.comments[index]);
                  },
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1,
                color: KolekColors.neutral200,
              ),
              const _CommentComposer(avatarAsset: _composerAvatar),
            ],
          ),
        ),
      ),
    );
  }
}

class _CommentTile extends StatelessWidget {
  const _CommentTile({required this.comment});

  final HomeComment comment;

  static const _generalSans = _CommentsSheet._generalSans;
  static const _ibmPlexMono = _CommentsSheet._ibmPlexMono;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: Image.asset(
            comment.avatarAsset,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    comment.author,
                    style: const TextStyle(
                      fontFamily: _generalSans, // only username
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: KolekColors.neutral900,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    comment.age,
                    style: const TextStyle(
                      fontFamily: _ibmPlexMono,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: KolekColors.neutral400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                comment.message.replaceAll('\n', ' '),
                style: const TextStyle(
                  fontFamily: _ibmPlexMono,
                  fontSize: 12,
                  height: 1.45,
                  color: KolekColors.neutral500,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Reply',
                style: TextStyle(
                  fontFamily: _ibmPlexMono,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: KolekColors.neutral900,
                ),
              ),
              if (comment.replyCount > 0) ...[
                const SizedBox(height: 10),
                Text(
                  '———  View ${comment.replyCount} more replies',
                  style: const TextStyle(
                    fontFamily: _ibmPlexMono,
                    fontSize: 11,
                    color: KolekColors.neutral400,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _CommentComposer extends StatelessWidget {
  const _CommentComposer({required this.avatarAsset});

  final String avatarAsset;

  static const _ibmPlexMono = _CommentsSheet._ibmPlexMono;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              avatarAsset,
              width: 36,
              height: 36,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SizedBox(
              height: 44,
              child: TextField(
                style: const TextStyle(
                  fontFamily: _ibmPlexMono,
                  fontSize: 12,
                  color: KolekColors.neutral900,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'What do you think of this?',
                  hintStyle: const TextStyle(
                    fontFamily: _ibmPlexMono,
                    fontSize: 12,
                    color: KolekColors.neutral400,
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(16, 12, 48, 12),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(999),
                    borderSide: const BorderSide(
                      color: KolekColors.neutral300,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(999),
                    borderSide: const BorderSide(
                      color: KolekColors.neutral400,
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Material(
                      color: KolekColors.blue600,
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () {},
                        child: const SizedBox(
                          width: 34,
                          height: 34,
                          child: Icon(
                            Icons.arrow_upward,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
