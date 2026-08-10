import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        onPressed: () {},
        icon: SvgPicture.asset(
          'assets/icons/search.svg',
          width: 22,
          height: 22,
        ),
      ),
      title: Text(
        'kolek',
        style: KolekText.mono(
          size: 24,
          weight: FontWeight.w500,
          color: KolekColors.blue600,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Badge(
            smallSize: 7,
            backgroundColor: KolekColors.blue600,
            child: Icon(
              Icons.notifications_none_rounded,
              size: 24,
              color: KolekColors.neutral900,
            ),
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
    final overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox?;
    if (button == null || overlay == null) return;

    final offset = button.localToGlobal(Offset.zero, ancestor: overlay);
    final selected = await showGeneralDialog<HomeMenuAction>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Post menu',
      barrierColor: Colors.black.withValues(alpha: 0.08),
      transitionDuration: const Duration(milliseconds: 180),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return Stack(
          children: [
            Positioned(
              top: offset.dy + button.size.height - 4,
              right: overlay.size.width - offset.dx - button.size.width + 4,
              child: FadeTransition(
                opacity: curved,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.94, end: 1).animate(curved),
                  alignment: Alignment.topRight,
                  child: _LiquidGlassMenu(
                    onSelected: (action) => Navigator.of(context).pop(action),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

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
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: Container(
          width: 168,
          decoration: BoxDecoration(
            color: const Color(0x99A8A8A8),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.85),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.14),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < HomeData.menuItems.length; i++) ...[
                if (i > 0)
                  Divider(
                    height: 1,
                    thickness: 0.8,
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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * .62;
    return Container(
      height: height,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            const SizedBox(height: 9),
            Container(
              width: 34,
              height: 3,
              decoration: BoxDecoration(
                color: KolekColors.neutral400,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 9),
            Text('Comments', style: KolekText.sans(size: 15)),
            const Divider(height: 1, color: KolekColors.neutral200),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                itemCount: HomeData.comments.length,
                separatorBuilder: (_, _) => const SizedBox(height: 14),
                itemBuilder: (_, index) {
                  final comment = HomeData.comments[index];
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: KolekColors.neutral300,
                        child: Text('D', style: KolekText.sans(size: 13)),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  comment.author,
                                  style: KolekText.sans(
                                    size: 12,
                                    weight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  comment.age,
                                  style: KolekText.mono(
                                    size: 9,
                                    color: KolekColors.neutral400,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              comment.message,
                              style: KolekText.mono(
                                size: 10,
                                color: KolekColors.neutral600,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text('Reply', style: KolekText.mono(size: 10)),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                14,
                10,
                14,
                10 + MediaQuery.viewInsetsOf(context).bottom,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'What do you think of this?',
                  hintStyle: KolekText.mono(
                    size: 11,
                    color: KolekColors.neutral400,
                  ),
                  filled: true,
                  fillColor: KolekColors.neutral100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: const CircleAvatar(
                    backgroundColor: KolekColors.blue600,
                    child: Icon(
                      Icons.arrow_upward,
                      size: 17,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
