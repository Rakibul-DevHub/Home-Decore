part of 'home_screen.dart';

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
  static const _closeExtent = 0.2;

  final _sheet = DraggableScrollableController();
  final _composer = TextEditingController();
  final _composerFocus = FocusNode();
  final _expanded = <String>{};
  HomeComment? _replyTo;
  double? _lastExtent;
  bool _closing = false;
  bool _movingProgrammatically = false;
  bool _armedFromFull = false;
  double _sheetHeight = 1;
  double _screenHeight = 1;
  late List<HomeComment> _comments = List.of(HomeData.comments);

  @override
  void initState() {
    super.initState();
    _sheet.addListener(_closeNearBottom);
  }

  @override
  void dispose() {
    _sheet.removeListener(_closeNearBottom);
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
    _movingProgrammatically = true;
    _sheet
        .animateTo(
          _expanded.isEmpty ? _collapsed : 1,
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
        )
        .whenComplete(() {
          _movingProgrammatically = false;
          if (_sheet.isAttached) _lastExtent = _sheet.size;
        });
  }

  double get _fullScreenDismissExtent {
    if (_sheetHeight <= 0) return 0.75;
    final drop = (_screenHeight * 0.25) / _sheetHeight;
    return (1 - drop).clamp(_closeExtent, 0.9);
  }

  void _closeNearBottom() {
    if (_closing || !_sheet.isAttached) return;
    final extent = _sheet.size;
    if (_movingProgrammatically) {
      _lastExtent = extent;
      _armedFromFull = extent >= 0.98;
      return;
    }
    final last = _lastExtent;
    _lastExtent = extent;
    if (extent >= 0.98) {
      _armedFromFull = true;
      return;
    }
    if (last == null || extent >= last) return;
    if (_armedFromFull && extent <= _fullScreenDismissExtent) {
      _closeSheet();
      return;
    }
    if (extent <= _closeExtent) _closeSheet();
  }

  void _closeSheet() {
    if (_closing) return;
    _closing = true;
    Navigator.of(context).pop();
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
    final colors = _HomeColors.of(context);
    final view = View.of(context);
    final pixelRatio = view.devicePixelRatio;
    final logicalTop = view.viewPadding.top / pixelRatio;
    final logicalWidth = view.physicalSize.width / pixelRatio;
    final layoutWidth = MediaQuery.sizeOf(context).width;
    final scale = layoutWidth <= 0 ? 1.0 : logicalWidth / layoutWidth;
    final topInset = scale <= 0 ? logicalTop : logicalTop / scale;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return LayoutBuilder(
      builder: (context, constraints) {
        final available = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : MediaQuery.sizeOf(context).height;
        final sheetHeight = (available - topInset).clamp(0.0, available);
        _sheetHeight = sheetHeight;
        _screenHeight = available;

        return Padding(
          padding: EdgeInsets.only(top: topInset),
          child: SizedBox(
            height: sheetHeight,
            child: DraggableScrollableSheet(
              controller: _sheet,
              expand: true,
              snap: true,
              snapAnimationDuration: const Duration(milliseconds: 180),
              initialChildSize: _collapsed,
              minChildSize: _closeExtent,
              maxChildSize: 1,
              snapSizes: const [_collapsed],
              builder: (context, scrollController) {
                return Padding(
                  padding: EdgeInsets.only(bottom: bottomInset),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                    child: ColoredBox(
                      color: colors.canvas,
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
                                  padding: const EdgeInsets.fromLTRB(
                                    20,
                                    12,
                                    20,
                                    12,
                                  ),
                                  sliver: SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                        if (index.isOdd) {
                                          return const SizedBox(height: 12);
                                        }
                                        final comment = _comments[index ~/ 2];
                                        return _CommentThread(
                                          comment: comment,
                                          expanded: _expanded.contains(
                                            comment.id,
                                          ),
                                          onToggle: () =>
                                              _toggleReplies(comment.id),
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
                            onClearMention: () =>
                                setState(() => _replyTo = null),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
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
    final colors = _HomeColors.of(context);
    return ColoredBox(
      color: colors.canvas,
      child: Column(
        children: [
          SizedBox(height: 24),
          Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: colors.muted,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: SizedBox(width: 40, height: 3),
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
              color: colors.text,
            ),
          ),
          SizedBox(height: 8),
          Divider(height: 1, thickness: 1, color: colors.line),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _CommentsHeaderDelegate oldDelegate) => false;
}
