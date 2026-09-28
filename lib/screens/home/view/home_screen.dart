import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../routes/app_route.dart';
import '../../../screens/main_shell/cubit/main_shell_cubit.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../data/home_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _showComments(BuildContext context, HomePost post) async {
    final bloc = context.read<HomeBloc>()..add(HomeCommentsOpened(post.id));
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CommentsSheet(isPostOwner: post.ownedByViewer),
    );
    bloc.add(const HomeCommentsClosed());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KolekColors.neutral50,
      appBar: const _KolekHeader(),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) => ListView.separated(
          itemCount: HomeData.posts.length,
          separatorBuilder: (_, _) => const Divider(
            height: 1,
            thickness: 1,
            color: KolekColors.neutral200,
          ),
          itemBuilder: (context, index) {
            final post = HomeData.posts[index];
            return _FeedCard(
              post: post,
              saved: state.savedPostIds.contains(post.id),
              onSaved: () =>
                  context.read<HomeBloc>().add(HomeSavedToggled(post.id)),
              onComments: () => _showComments(context, post),
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
      backgroundColor: KolekColors.neutral50,
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
          onPressed: () =>
              Navigator.of(context).pushNamed(AppRoute.notifications),
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
    final overlay = overlayState.context.findRenderObject() as RenderBox?;
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
                child: _PostMenu(onSelected: close),
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
                      style: const TextStyle(
                        fontFamily: 'GeneralSans-Medium',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: KolekColors.neutral900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      post.location,
                      style: const TextStyle(
                        fontFamily: 'GeneralSans-Regular',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
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
        SizedBox(
          height: 300,
          width: double.infinity,
          child: Image.asset(post.image, fit: BoxFit.cover),
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
                    style: const TextStyle(
                      fontFamily: 'GeneralSans-Medium',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: KolekColors.neutral900,
                    ),
                  ),
                  if (post.year != null) ...[
                    const SizedBox(width: 16),
                    Text(
                      post.year!,
                      style: const TextStyle(
                        fontFamily: 'IBMPlexMono-Regular',
                        fontSize: 12,
                        color: KolekColors.neutral500,
                      ),
                    ),
                  ],
                  const Spacer(),
                  _StatIcon(
                    asset: 'assets/icons/react_border.svg',
                    value: post.likes,
                    valueStyle: const TextStyle(
                      fontFamily: 'IBMPlexMono-Regular',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: KolekColors.neutral600,
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: onComments,
                    child: _StatIcon(
                      asset: 'assets/icons/comment.svg',
                      value: post.commentCount,
                      valueStyle: const TextStyle(
                        fontFamily: 'IBMPlexMono-Regular',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: KolekColors.neutral600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  _StatIcon(
                    asset: 'assets/icons/share.svg',
                    value: post.shareCount,
                    valueStyle: const TextStyle(
                      fontFamily: 'IBMPlexMono-Regular',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: KolekColors.neutral600,
                    ),
                  ),
                  if (post.isAuction || post.showBag) ...[
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: post.showBag
                          ? () => Navigator.of(
                              context,
                            ).pushNamed(AppRoute.productDetails)
                          : null,
                      child: SvgPicture.asset(
                        post.isAuction
                            ? 'assets/icons/auction.svg'
                            : 'assets/icons/cart.svg',
                        width: 20,
                        height: 20,
                        colorFilter: const ColorFilter.mode(
                          KolekColors.neutral700,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),
              Text(
                post.description,
                style: const TextStyle(
                  fontFamily: 'IBMPlexMono-Regular',
                  fontSize: 12,
                  height: 20 / 12,
                  color: KolekColors.neutral500,
                ),
              ),
              const Text(
                '...more',
                style: TextStyle(
                  fontFamily: 'IBMPlexMono-Regular',
                  fontSize: 10,
                  height: 20 / 10,
                  color: KolekColors.neutral500,
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
  const _StatIcon({
    required this.asset,
    required this.value,
    required this.valueStyle,
  });

  final String asset;
  final String? value;
  final TextStyle valueStyle;

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
          Text(value!, style: valueStyle),
        ],
      ],
    );
  }
}

class _PostMenu extends StatelessWidget {
  const _PostMenu({required this.onSelected});

  final ValueChanged<HomeMenuAction> onSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF4F4F4),
      elevation: 10,
      shadowColor: Colors.black26,
      borderRadius: BorderRadius.circular(18),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < HomeData.menuItems.length; i++) ...[
              if (i > 0)
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFE4E4E4),
                ),
              _PostMenuRow(
                item: HomeData.menuItems[i],
                onTap: () => onSelected(HomeData.menuItems[i].action),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PostMenuRow extends StatelessWidget {
  const _PostMenuRow({required this.item, required this.onTap});

  final HomeMenuItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            _PostMenuIcon(action: item.action),
            const SizedBox(width: 12),
            Text(
              item.label,
              style: const TextStyle(
                fontFamily: 'GeneralSans-Medium',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: KolekColors.neutral900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostMenuIcon extends StatelessWidget {
  const _PostMenuIcon({required this.action});

  final HomeMenuAction action;

  @override
  Widget build(BuildContext context) {
    return switch (action) {
      HomeMenuAction.savePost => SvgPicture.asset(
        'assets/icons/save_post.svg',
        width: 22,
        height: 22,
        colorFilter: const ColorFilter.mode(
          KolekColors.neutral900,
          BlendMode.srcIn,
        ),
      ),
      HomeMenuAction.message => SvgPicture.string(
        _messageIcon,
        width: 22,
        height: 22,
      ),
      HomeMenuAction.report => SvgPicture.string(
        _reportIcon,
        width: 22,
        height: 22,
      ),
    };
  }
}

const _messageIcon = '''
<svg width="22" height="22" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M12 20.2C16.6 20.2 20.3 16.7 20.3 12.4C20.3 8.1 16.6 4.6 12 4.6C7.4 4.6 3.7 8.1 3.7 12.4C3.7 14.3 4.4 16.1 5.6 17.4L4.8 19.8L7.5 18.9C8.8 19.7 10.3 20.2 12 20.2Z" stroke="#171717" stroke-width="1.6" stroke-linejoin="round"/>
<circle cx="8.7" cy="12.4" r="1" fill="#171717"/>
<circle cx="12" cy="12.4" r="1" fill="#171717"/>
<circle cx="15.3" cy="12.4" r="1" fill="#171717"/>
</svg>
''';

const _reportIcon = '''
<svg width="22" height="22" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<circle cx="12" cy="12" r="8.15" stroke="#171717" stroke-width="1.6"/>
<path d="M12 8.1V12.8" stroke="#171717" stroke-width="1.6" stroke-linecap="round"/>
<circle cx="12" cy="15.6" r="0.95" fill="#171717"/>
</svg>
''';

enum _CommentAction { edit, delete, hide, report }

class _CommentsSheet extends StatefulWidget {
  const _CommentsSheet({required this.isPostOwner});

  final bool isPostOwner;

  @override
  State<_CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<_CommentsSheet> {
  static const _composerAvatar = 'assets/images/demo_user.png';
  static const _collapsed = 0.68;

  final _sheet = DraggableScrollableController();
  final _composer = TextEditingController();
  final _composerFocus = FocusNode();
  final _expanded = <String>{};
  HomeComment? _replyTo;
  late List<HomeComment> _comments = List.of(HomeData.comments);

  @override
  void dispose() {
    _sheet.dispose();
    _composer.dispose();
    _composerFocus.dispose();
    super.dispose();
  }

  void _startReply(HomeComment comment) {
    final rootId = _topLevelId(comment.id);
    setState(() {
      _replyTo = comment;
      if (rootId != null) _expanded.add(rootId);
    });
    if (rootId != null) _fitSheet();
    _composerFocus.requestFocus();
  }

  void _submit() {
    final text = _composer.text.trim();
    if (text.isEmpty) return;
    final replyTo = _replyTo;
    final reply = HomeComment(
      id: 'local-${DateTime.now().microsecondsSinceEpoch}',
      author: HomeData.viewerName,
      age: 'Just now',
      message: text,
      mention: replyTo?.author,
      isMine: true,
    );
    setState(() {
      if (replyTo == null) {
        _comments = [..._comments, reply];
      } else {
        _comments = _addReply(_comments, replyTo.id, reply);
        final rootId = _topLevelId(replyTo.id);
        if (rootId != null) _expanded.add(rootId);
      }
      _composer.clear();
      _replyTo = null;
    });
    _fitSheet();
    _composerFocus.unfocus();
  }

  String? _topLevelId(String id) {
    for (final comment in _comments) {
      if (comment.id == id || _contains(comment, id)) return comment.id;
    }
    return null;
  }

  bool _contains(HomeComment comment, String id) {
    for (final reply in comment.replies) {
      if (reply.id == id || _contains(reply, id)) return true;
    }
    return false;
  }

  List<HomeComment> _addReply(
    List<HomeComment> items,
    String parentId,
    HomeComment reply,
  ) {
    return [
      for (final item in items)
        if (item.id == parentId)
          item.copyWith(replies: [...item.replies, reply])
        else
          item.copyWith(replies: _addReply(item.replies, parentId, reply)),
    ];
  }

  void _remove(String id) {
    setState(() {
      _comments = _withoutId(_comments, id);
      _expanded.remove(id);
    });
    _fitSheet();
  }

  void _toggleReplies(String id) {
    setState(() {
      if (!_expanded.add(id)) _expanded.remove(id);
    });
    _fitSheet();
  }

  void _fitSheet() {
    if (!_sheet.isAttached) return;
    _sheet.animateTo(
      _expanded.isEmpty ? _collapsed : 1,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  List<HomeComment> _withoutId(List<HomeComment> items, String id) {
    return [
      for (final item in items)
        if (item.id != id) item.copyWith(replies: _withoutId(item.replies, id)),
    ];
  }

  Future<void> _openCommentMenu(
    BuildContext buttonContext,
    HomeComment comment,
  ) async {
    final action = await _showAnchoredMenu(
      buttonContext,
      _commentMenuEntries(comment),
    );
    if (!mounted || action == null) return;
    switch (action) {
      case _CommentAction.delete:
      case _CommentAction.hide:
        _remove(comment.id);
      case _CommentAction.edit:
      case _CommentAction.report:
        break;
    }
  }

  List<_AnchoredMenuEntry<_CommentAction>> _commentMenuEntries(
    HomeComment comment,
  ) {
    if (comment.isMine) {
      return const [
        _AnchoredMenuEntry('Edit', _CommentAction.edit),
        _AnchoredMenuEntry('Delete', _CommentAction.delete, destructive: true),
      ];
    }
    if (widget.isPostOwner) {
      return const [
        _AnchoredMenuEntry('Hide', _CommentAction.hide),
        _AnchoredMenuEntry('Report', _CommentAction.report),
        _AnchoredMenuEntry('Delete', _CommentAction.delete, destructive: true),
      ];
    }
    return const [_AnchoredMenuEntry('Report', _CommentAction.report)];
  }

  @override
  Widget build(BuildContext context) {
    final view = View.of(context);
    final topInset = view.viewPadding.top / view.devicePixelRatio;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(top: topInset, bottom: bottomInset),
      child: DraggableScrollableSheet(
        controller: _sheet,
        expand: false,
        snap: true,
        initialChildSize: _collapsed,
        minChildSize: 0.45,
        maxChildSize: 1,
        snapSizes: const [_collapsed],
        builder: (context, scrollController) {
          return ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            child: ColoredBox(
              color: KolekColors.neutral50,
              child: Column(
                children: [
                  Expanded(
                    child: CustomScrollView(
                      controller: scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        const SliverPersistentHeader(
                          pinned: true,
                          delegate: _CommentsHeaderDelegate(),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                if (index.isOdd) {
                                  return const SizedBox(height: 12);
                                }
                                final comment = _comments[index ~/ 2];
                                return _CommentThread(
                                  comment: comment,
                                  expanded: _expanded.contains(comment.id),
                                  onToggle: () => _toggleReplies(comment.id),
                                  onMenu: (context, target) =>
                                      _openCommentMenu(context, target),
                                  onReply: _startReply,
                                );
                              },
                              childCount: _comments.isEmpty
                                  ? 0
                                  : _comments.length * 2 - 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _CommentComposer(
                    avatarAsset: _composerAvatar,
                    controller: _composer,
                    focusNode: _composerFocus,
                    mention: _replyTo?.author,
                    onSubmit: _submit,
                    onClearMention: () => setState(() => _replyTo = null),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CommentsHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _CommentsHeaderDelegate();

  static const _extent = 65.0;

  @override
  double get minExtent => _extent;

  @override
  double get maxExtent => _extent;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return const ColoredBox(
      color: KolekColors.neutral50,
      child: Column(
        children: [
          SizedBox(height: 30),
          Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: KolekColors.neutral500,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: SizedBox(width: 40, height: 2),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Comments',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'GeneralSans-Medium',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1,
              color: KolekColors.neutral900,
            ),
          ),
          SizedBox(height: 8),
          Divider(height: 1, thickness: 1, color: KolekColors.neutral200),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _CommentsHeaderDelegate oldDelegate) => false;
}

class _CommentThread extends StatelessWidget {
  const _CommentThread({
    required this.comment,
    required this.expanded,
    required this.onToggle,
    required this.onMenu,
    required this.onReply,
  });

  final HomeComment comment;
  final bool expanded;
  final VoidCallback onToggle;
  final void Function(BuildContext context, HomeComment comment) onMenu;
  final ValueChanged<HomeComment> onReply;

  @override
  Widget build(BuildContext context) {
    final replies = comment.replies;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CommentTile(
          comment: comment,
          onMenu: onMenu,
          onReply: () => onReply(comment),
          replyLabel: replies.isEmpty
              ? null
              : (expanded ? 'Collapse' : 'View ${replies.length} more replies'),
          onReplies: replies.isEmpty ? null : onToggle,
        ),
        if (expanded)
          for (final reply in replies)
            Padding(
              padding: const EdgeInsets.only(left: 36, top: 12),
              child: _NestedReply(
                comment: reply,
                onMenu: onMenu,
                onReply: onReply,
              ),
            ),
      ],
    );
  }
}

class _NestedReply extends StatelessWidget {
  const _NestedReply({
    required this.comment,
    required this.onMenu,
    required this.onReply,
  });

  final HomeComment comment;
  final void Function(BuildContext context, HomeComment comment) onMenu;
  final ValueChanged<HomeComment> onReply;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CommentTile(
          comment: comment,
          nested: true,
          onMenu: onMenu,
          onReply: () => onReply(comment),
        ),
        for (final reply in comment.replies)
          Padding(
            padding: const EdgeInsets.only(left: 36, top: 12),
            child: _NestedReply(
              comment: reply,
              onMenu: onMenu,
              onReply: onReply,
            ),
          ),
      ],
    );
  }
}

class _CommentTile extends StatelessWidget {
  const _CommentTile({
    required this.comment,
    required this.onMenu,
    required this.onReply,
    this.nested = false,
    this.replyLabel,
    this.onReplies,
  });

  final HomeComment comment;
  final void Function(BuildContext context, HomeComment comment) onMenu;
  final VoidCallback onReply;
  final bool nested;
  final String? replyLabel;
  final VoidCallback? onReplies;

  @override
  Widget build(BuildContext context) {
    final avatar = nested ? 28.0 : 48.0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: Image.asset(
            comment.avatarAsset,
            width: avatar,
            height: avatar,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    comment.author,
                    style: TextStyle(
                      fontFamily: 'GeneralSans-Semibold',
                      fontSize: nested ? 14 : 16,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                      color: KolekColors.neutral900,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    comment.age,
                    style: TextStyle(
                      fontFamily: 'IBMPlexMono-Regular',
                      fontSize: nested ? 12 : 14,
                      letterSpacing: -1,
                      height: 1.2,
                      color: KolekColors.neutral500,
                    ),
                  ),
                  if (nested) ...[
                    const Spacer(),
                    Builder(
                      builder: (buttonContext) => InkWell(
                        onTap: () => onMenu(buttonContext, comment),
                        borderRadius: BorderRadius.circular(12),
                        child: const Padding(
                          padding: EdgeInsets.all(2),
                          child: Icon(
                            Icons.more_horiz,
                            size: 18,
                            color: KolekColors.neutral500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 6),
              _CommentBody(comment: comment),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: onReply,
                behavior: HitTestBehavior.opaque,
                child: const Text(
                  'Reply',
                  style: TextStyle(
                    fontFamily: 'IBMPlexMono-Medium',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 16 / 14,
                    color: KolekColors.neutral900,
                  ),
                ),
              ),
              if (replyLabel != null) ...[
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: onReplies,
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 1,
                        color: KolekColors.neutral200,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        replyLabel!,
                        style: const TextStyle(
                          fontFamily: 'IBMPlexMono-Regular',
                          fontSize: 12,
                          height: 1,
                          letterSpacing: -1,
                          color: KolekColors.neutral400,
                        ),
                      ),
                    ],
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

class _AnchoredMenuEntry<T> {
  const _AnchoredMenuEntry(this.label, this.value, {this.destructive = false});

  final String label;
  final T value;
  final bool destructive;
}

Future<T?> _showAnchoredMenu<T>(
  BuildContext context,
  List<_AnchoredMenuEntry<T>> entries,
) {
  final button = context.findRenderObject() as RenderBox?;
  final overlayState = Overlay.of(context);
  final overlay = overlayState.context.findRenderObject() as RenderBox?;
  if (button == null || overlay == null) return Future.value();

  final offset = button.localToGlobal(Offset.zero, ancestor: overlay);
  final completer = Completer<T?>();
  late OverlayEntry entry;

  void close([T? value]) {
    if (!completer.isCompleted) completer.complete(value);
    entry.remove();
  }

  final top = offset.dy + button.size.height + 6;
  final right = overlay.size.width - offset.dx - button.size.width;

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
            top: top,
            right: right < 8 ? 8 : right,
            child: Material(
              color: Colors.white,
              elevation: 8,
              shadowColor: Colors.black26,
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                width: 148,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var i = 0; i < entries.length; i++) ...[
                      if (i > 0)
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: KolekColors.neutral200,
                        ),
                      InkWell(
                        onTap: () => close(entries[i].value),
                        child: SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                entries[i].label,
                                style: TextStyle(
                                  fontFamily: 'GeneralSans-Medium',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: entries[i].destructive
                                      ? const Color(0xFFFF3B30)
                                      : KolekColors.neutral900,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    },
  );

  overlayState.insert(entry);
  return completer.future;
}

class _CommentBody extends StatelessWidget {
  const _CommentBody({required this.comment});

  final HomeComment comment;

  static const _body = TextStyle(
    fontFamily: 'IBMPlexMono-Regular',
    fontSize: 14,
    height: 20 / 14,
    color: KolekColors.neutral500,
  );

  @override
  Widget build(BuildContext context) {
    final mention = comment.mention;
    if (mention == null) return Text(comment.message, style: _body);
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: mention,
            style: const TextStyle(
              fontFamily: 'GeneralSans-Semibold',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 20 / 14,
              color: KolekColors.neutral900,
            ),
          ),
          TextSpan(text: ' ${comment.message}', style: _body),
        ],
      ),
    );
  }
}

class _CommentComposer extends StatelessWidget {
  const _CommentComposer({
    required this.avatarAsset,
    required this.controller,
    required this.focusNode,
    required this.onSubmit,
    required this.onClearMention,
    this.mention,
  });

  final String avatarAsset;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? mention;
  final VoidCallback onSubmit;
  final VoidCallback onClearMention;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 12, 20, 12 + bottom),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.asset(
              avatarAsset,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 40,
              padding: const EdgeInsets.only(left: 16, right: 4),
              decoration: BoxDecoration(
                color: KolekColors.neutral100,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: KolekColors.neutral200),
              ),
              child: Row(
                children: [
                  if (mention != null) ...[
                    Text(
                      mention!,
                      style: const TextStyle(
                        fontFamily: 'GeneralSans-Semibold',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: KolekColors.neutral900,
                      ),
                    ),
                    const SizedBox(width: 6),
                  ],
                  Expanded(
                    child: Focus(
                      onKeyEvent: (node, event) {
                        if (mention != null &&
                            controller.text.isEmpty &&
                            event is KeyDownEvent &&
                            event.logicalKey == LogicalKeyboardKey.backspace) {
                          onClearMention();
                          return KeyEventResult.handled;
                        }
                        return KeyEventResult.ignored;
                      },
                      child: TextField(
                        controller: controller,
                        focusNode: focusNode,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => onSubmit(),
                        style: const TextStyle(
                          fontFamily: 'IBMPlexMono-Regular',
                          fontSize: 14,
                          color: KolekColors.neutral900,
                        ),
                        decoration: InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                          hintText: mention == null
                              ? 'What do you think of this?'
                              : 'Add a comment',
                          hintStyle: const TextStyle(
                            fontFamily: 'IBMPlexMono-Regular',
                            fontSize: 14,
                            color: KolekColors.neutral500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Material(
                    color: const Color(0xFF2B7FFF),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: onSubmit,
                      child: const SizedBox(
                        width: 32,
                        height: 32,
                        child: Icon(
                          Icons.arrow_upward,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
