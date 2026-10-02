// part of 'home_screen.dart';
//
// enum _CommentAction { edit, delete, hide, report }
//
// class _CommentsSheet extends StatefulWidget {
//   const _CommentsSheet({required this.isPostOwner});
//
//   final bool isPostOwner;
//
//   @override
//   State<_CommentsSheet> createState() => _CommentsSheetState();
// }
//
// class _CommentsSheetState extends State<_CommentsSheet> {
//   static const _composerAvatar = 'assets/images/demo_user.png';
//   static const _collapsed = 0.68;
//   static const _closeExtent = 0.2;
//
//   final _sheet = DraggableScrollableController();
//   final _composer = TextEditingController();
//   final _composerFocus = FocusNode();
//   final _expanded = <String>{};
//   HomeComment? _replyTo;
//   double? _lastExtent;
//   bool _closing = false;
//   bool _movingProgrammatically = false;
//   bool _armedFromFull = false;
//   double _sheetHeight = 1;
//   double _screenHeight = 1;
//   String? _highlightedId;
//   int _revealGen = 0;
//   ScrollController? _commentsScroll;
//   final _highlightKey = GlobalKey();
//   late List<HomeComment> _comments = List.of(HomeData.comments);
//
//   @override
//   void initState() {
//     super.initState();
//     _sheet.addListener(_closeNearBottom);
//   }
//
//   @override
//   void dispose() {
//     _sheet.removeListener(_closeNearBottom);
//     _sheet.dispose();
//     _composer.dispose();
//     _composerFocus.dispose();
//     super.dispose();
//   }
//
//   // ─────────────── Header drag: works at any scroll offset ───────────────
//
//   void _onHeaderDragStart(DragStartDetails details) {
//     if (!_sheet.isAttached) return;
//     _movingProgrammatically = true;
//   }
//
//   void _onHeaderDragUpdate(DragUpdateDetails details) {
//     if (!_sheet.isAttached || _sheetHeight <= 0) return;
//     final delta = -(details.primaryDelta ?? 0) / _sheetHeight;
//     final next = (_sheet.size + delta).clamp(_closeExtent, 1.0);
//     _sheet.jumpTo(next);
//   }
//
//   void _onHeaderDragEnd(DragEndDetails details) {
//     if (!_sheet.isAttached || _sheetHeight <= 0) {
//       _movingProgrammatically = false;
//       return;
//     }
//
//     final velocity = -(details.primaryVelocity ?? 0) / _sheetHeight;
//     final current = _sheet.size;
//     final projected = (current + velocity * 0.18).clamp(_closeExtent, 1.0);
//
//     // Dragged low enough → close.
//     if (current <= _closeExtent + 0.08 || projected < _closeExtent + 0.15) {
//       _movingProgrammatically = false;
//       _closeSheet();
//       return;
//     }
//
//     // Keep the flag on during the snap animation so the listener doesn't
//     // accidentally close mid-snap.
//     _movingProgrammatically = true;
//     final target = (velocity < -0.5 || projected >= 0.9) ? 1.0 : _collapsed;
//     _sheet
//         .animateTo(
//       target,
//       duration: const Duration(milliseconds: 220),
//       curve: Curves.easeOutCubic,
//     )
//         .whenComplete(() {
//       _movingProgrammatically = false;
//       if (_sheet.isAttached) _lastExtent = _sheet.size;
//     });
//   }
//
//   // ─────────────────────────── Existing logic ────────────────────────────
//
//   void _startReply(HomeComment comment) {
//     setState(() {
//       _replyTo = comment;
//       _expanded.add(comment.parentId ?? comment.id);
//     });
//     _fitSheet();
//     _composerFocus.requestFocus();
//   }
//
//   void _submit() {
//     final text = _composer.text.trim();
//     if (text.isEmpty) return;
//     final target = _replyTo;
//     final rootId = target == null ? null : target.parentId ?? target.id;
//     final reply = HomeComment(
//       id: 'local-${DateTime.now().microsecondsSinceEpoch}',
//       author: HomeData.viewerName,
//       age: 'Just now',
//       message: text,
//       parentId: rootId,
//       replyToUsername:
//       target != null && target.isLevelTwo ? target.author : null,
//       isMine: true,
//     );
//     setState(() {
//       if (rootId == null) {
//         _comments = [..._comments, reply];
//       } else {
//         _comments = [
//           for (final item in _comments)
//             if (item.id == rootId)
//               item.copyWith(replies: [...item.replies, reply])
//             else
//               item,
//         ];
//         _expanded.add(rootId);
//       }
//       _composer.clear();
//       _replyTo = null;
//       _highlightedId = reply.id;
//     });
//     _fitSheet();
//     _composerFocus.unfocus();
//     _reveal(reply.id);
//   }
//
//   Future<void> _reveal(String id) async {
//     final gen = ++_revealGen;
//     await Future<void>.delayed(const Duration(milliseconds: 60));
//     if (!mounted || gen != _revealGen) return;
//     await _scrollToHighlighted();
//     await Future<void>.delayed(const Duration(milliseconds: 1400));
//     if (!mounted || gen != _revealGen || _highlightedId != id) return;
//     setState(() => _highlightedId = null);
//   }
//
//   Future<void> _scrollToHighlighted() async {
//     final target = _highlightKey.currentContext;
//     if (target != null) {
//       await Scrollable.ensureVisible(
//         target,
//         duration: const Duration(milliseconds: 380),
//         curve: Curves.easeOutCubic,
//         alignment: 0.28,
//       );
//       return;
//     }
//     final controller = _commentsScroll;
//     if (controller == null || !controller.hasClients) return;
//     await controller.animateTo(
//       controller.position.maxScrollExtent,
//       duration: const Duration(milliseconds: 380),
//       curve: Curves.easeOutCubic,
//     );
//     await Future<void>.delayed(const Duration(milliseconds: 40));
//     final built = _highlightKey.currentContext;
//     if (!mounted || built == null) return;
//     await Scrollable.ensureVisible(
//       built,
//       duration: const Duration(milliseconds: 220),
//       curve: Curves.easeOutCubic,
//       alignment: 0.28,
//     );
//   }
//
//   void _remove(String id) {
//     setState(() {
//       _comments = _withoutId(_comments, id);
//       _expanded.remove(id);
//     });
//     _fitSheet();
//   }
//
//   void _toggleReplies(String id) {
//     setState(() {
//       if (!_expanded.add(id)) _expanded.remove(id);
//     });
//     _fitSheet();
//   }
//
//   void _fitSheet() {
//     if (!_sheet.isAttached) return;
//     _movingProgrammatically = true;
//     _sheet
//         .animateTo(
//       _expanded.isEmpty ? _collapsed : 1,
//       duration: const Duration(milliseconds: 220),
//       curve: Curves.easeOutCubic,
//     )
//         .whenComplete(() {
//       _movingProgrammatically = false;
//       if (_sheet.isAttached) _lastExtent = _sheet.size;
//     });
//   }
//
//   double get _fullScreenDismissExtent {
//     if (_sheetHeight <= 0) return 0.75;
//     final drop = (_screenHeight * 0.25) / _sheetHeight;
//     return (1 - drop).clamp(_closeExtent, 0.9);
//   }
//
//   void _closeNearBottom() {
//     if (_closing || !_sheet.isAttached) return;
//     final extent = _sheet.size;
//     if (_movingProgrammatically) {
//       _lastExtent = extent;
//       _armedFromFull = extent >= 0.98;
//       return;
//     }
//     final last = _lastExtent;
//     _lastExtent = extent;
//     if (extent >= 0.98) {
//       _armedFromFull = true;
//       return;
//     }
//     if (last == null || extent >= last) return;
//     if (_armedFromFull && extent <= _fullScreenDismissExtent) {
//       _closeSheet();
//       return;
//     }
//     if (extent <= _closeExtent) _closeSheet();
//   }
//
//   void _closeSheet() {
//     if (_closing) return;
//     _closing = true;
//     Navigator.of(context).pop();
//   }
//
//   List<HomeComment> _withoutId(List<HomeComment> items, String id) {
//     return [
//       for (final item in items)
//         if (item.id != id)
//           item.copyWith(
//             replies: [
//               for (final reply in item.replies)
//                 if (reply.id != id) reply,
//             ],
//           ),
//     ];
//   }
//
//   Future<void> _openCommentMenu(
//       BuildContext buttonContext,
//       HomeComment comment,
//       ) async {
//     final action = await _showAnchoredMenu(
//       buttonContext,
//       _commentMenuEntries(comment),
//     );
//     if (!mounted || action == null) return;
//     switch (action) {
//       case _CommentAction.delete:
//       case _CommentAction.hide:
//         _remove(comment.id);
//       case _CommentAction.edit:
//       case _CommentAction.report:
//         break;
//     }
//   }
//
//   List<_AnchoredMenuEntry<_CommentAction>> _commentMenuEntries(
//       HomeComment comment,
//       ) {
//     if (comment.isMine) {
//       return const [
//         _AnchoredMenuEntry('Edit', _CommentAction.edit),
//         _AnchoredMenuEntry('Delete', _CommentAction.delete, destructive: true),
//       ];
//     }
//     if (widget.isPostOwner) {
//       return const [
//         _AnchoredMenuEntry('Hide', _CommentAction.hide),
//         _AnchoredMenuEntry('Report', _CommentAction.report),
//         _AnchoredMenuEntry('Delete', _CommentAction.delete, destructive: true),
//       ];
//     }
//     return const [_AnchoredMenuEntry('Report', _CommentAction.report)];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final colors = _HomeColors.of(context);
//     final view = View.of(context);
//     final pixelRatio = view.devicePixelRatio;
//     final logicalTop = view.viewPadding.top / pixelRatio;
//     final logicalWidth = view.physicalSize.width / pixelRatio;
//     final layoutWidth = MediaQuery.sizeOf(context).width;
//     final scale = layoutWidth <= 0 ? 1.0 : logicalWidth / layoutWidth;
//     final topInset = scale <= 0 ? logicalTop : logicalTop / scale;
//     final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
//
//     // Reserve at least 12dp of barrier at the top so tapping outside the
//     // sheet always dismisses it, even when viewPadding.top is 0.
//     final barrierGap = topInset < 12 ? 12.0 : topInset;
//
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final available = constraints.maxHeight.isFinite
//             ? constraints.maxHeight
//             : MediaQuery.sizeOf(context).height;
//         final sheetHeight = (available - barrierGap).clamp(0.0, available);
//         _sheetHeight = sheetHeight;
//         _screenHeight = available;
//
//         return Padding(
//           padding: EdgeInsets.only(top: barrierGap),
//           child: SizedBox(
//             height: sheetHeight,
//             child: DraggableScrollableSheet(
//               controller: _sheet,
//               expand: true,
//               snap: true,
//               snapAnimationDuration: const Duration(milliseconds: 180),
//               initialChildSize: _collapsed,
//               minChildSize: _closeExtent,
//               maxChildSize: 1,
//               snapSizes: const [_collapsed],
//               builder: (context, scrollController) {
//                 _commentsScroll = scrollController;
//                 return Padding(
//                   padding: EdgeInsets.only(bottom: bottomInset),
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.vertical(
//                       top: Radius.circular(32),
//                     ),
//                     child: ColoredBox(
//                       color: colors.canvas,
//                       child: Column(
//                         children: [
//                           Expanded(
//                             child: CustomScrollView(
//                               controller: scrollController,
//                               physics: const AlwaysScrollableScrollPhysics(),
//                               slivers: [
//                                 SliverPersistentHeader(
//                                   pinned: true,
//                                   delegate: _CommentsHeaderDelegate(
//                                     onDragStart: _onHeaderDragStart,
//                                     onDragUpdate: _onHeaderDragUpdate,
//                                     onDragEnd: _onHeaderDragEnd,
//                                   ),
//                                 ),
//                                 SliverPadding(
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: 12,
//                                   ),
//                                   sliver: SliverList(
//                                     delegate: SliverChildBuilderDelegate(
//                                           (context, index) {
//                                         if (index.isOdd) {
//                                           return const SizedBox(height: 12);
//                                         }
//                                         final comment = _comments[index ~/ 2];
//                                         return _CommentThread(
//                                           comment: comment,
//                                           expanded: _expanded.contains(
//                                             comment.id,
//                                           ),
//                                           highlightedId: _highlightedId,
//                                           highlightKey: _highlightKey,
//                                           onToggle: () =>
//                                               _toggleReplies(comment.id),
//                                           onMenu: (context, target) =>
//                                               _openCommentMenu(context, target),
//                                           onReply: _startReply,
//                                         );
//                                       },
//                                       childCount: _comments.isEmpty
//                                           ? 0
//                                           : _comments.length * 2 - 1,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           _CommentComposer(
//                             avatarAsset: _composerAvatar,
//                             controller: _composer,
//                             focusNode: _composerFocus,
//                             replyToUsername: _replyTo?.author,
//                             onSubmit: _submit,
//                             onClearMention: () =>
//                                 setState(() => _replyTo = null),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class _CommentsHeaderDelegate extends SliverPersistentHeaderDelegate {
//   const _CommentsHeaderDelegate({
//     required this.onDragStart,
//     required this.onDragUpdate,
//     required this.onDragEnd,
//   });
//
//   static const _extent = 65.0;
//
//   final GestureDragStartCallback onDragStart;
//   final GestureDragUpdateCallback onDragUpdate;
//   final GestureDragEndCallback onDragEnd;
//
//   @override
//   double get minExtent => _extent;
//
//   @override
//   double get maxExtent => _extent;
//
//   @override
//   Widget build(
//       BuildContext context,
//       double shrinkOffset,
//       bool overlapsContent,
//       ) {
//     final colors = _HomeColors.of(context);
//     return ColoredBox(
//       color: colors.canvas,
//       child: GestureDetector(
//         behavior: HitTestBehavior.opaque,
//         onVerticalDragStart: onDragStart,
//         onVerticalDragUpdate: onDragUpdate,
//         onVerticalDragEnd: onDragEnd,
//         child: Column(
//           children: [
//             const SizedBox(height: 24),
//             Center(
//               child: DecoratedBox(
//                 decoration: BoxDecoration(
//                   color: colors.muted,
//                   borderRadius: const BorderRadius.all(Radius.circular(16)),
//                 ),
//                 child: const SizedBox(width: 40, height: 3),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Comments',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontFamily: 'GeneralSans-Medium',
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 height: 1,
//                 color: colors.text,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Divider(height: 1, thickness: 1, color: colors.line),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   bool shouldRebuild(covariant _CommentsHeaderDelegate oldDelegate) => true;
// }









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
  String? _highlightedId;
  int _revealGen = 0;
  ScrollController? _commentsScroll;
  final _highlightKey = GlobalKey();
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

  // ─────────────── Header drag: works at any scroll offset ───────────────

  void _onHeaderDragStart(DragStartDetails details) {
    if (!_sheet.isAttached) return;
    _movingProgrammatically = true;
  }

  void _onHeaderDragUpdate(DragUpdateDetails details) {
    if (!_sheet.isAttached || _sheetHeight <= 0) return;
    final delta = -(details.primaryDelta ?? 0) / _sheetHeight;
    final next = (_sheet.size + delta).clamp(_closeExtent, 1.0);
    _sheet.jumpTo(next);
  }

  void _onHeaderDragEnd(DragEndDetails details) {
    if (!_sheet.isAttached || _sheetHeight <= 0) {
      _movingProgrammatically = false;
      return;
    }

    final velocity = -(details.primaryVelocity ?? 0) / _sheetHeight;
    final current = _sheet.size;
    final projected = (current + velocity * 0.18).clamp(_closeExtent, 1.0);

    if (current <= _closeExtent + 0.08 || projected < _closeExtent + 0.15) {
      _movingProgrammatically = false;
      _closeSheet();
      return;
    }

    _movingProgrammatically = true;
    final target = (velocity < -0.5 || projected >= 0.9) ? 1.0 : _collapsed;
    _sheet
        .animateTo(
      target,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
    )
        .whenComplete(() {
      _movingProgrammatically = false;
      if (_sheet.isAttached) _lastExtent = _sheet.size;
    });
  }

  // ─────────────────────────── Existing logic ────────────────────────────

  void _startReply(HomeComment comment) {
    setState(() {
      _replyTo = comment;
      _expanded.add(comment.parentId ?? comment.id);
    });
    _fitSheet();
    _composerFocus.requestFocus();
  }

  void _submit() {
    final text = _composer.text.trim();
    if (text.isEmpty) return;
    final target = _replyTo;
    final rootId = target == null ? null : target.parentId ?? target.id;
    final reply = HomeComment(
      id: 'local-${DateTime.now().microsecondsSinceEpoch}',
      author: HomeData.viewerName,
      age: 'Just now',
      message: text,
      parentId: rootId,
      replyToUsername:
      target != null && target.isLevelTwo ? target.author : null,
      isMine: true,
    );
    setState(() {
      if (rootId == null) {
        _comments = [..._comments, reply];
      } else {
        _comments = [
          for (final item in _comments)
            if (item.id == rootId)
              item.copyWith(replies: [...item.replies, reply])
            else
              item,
        ];
        _expanded.add(rootId);
      }
      _composer.clear();
      _replyTo = null;
      _highlightedId = reply.id;
    });
    _fitSheet();
    _composerFocus.unfocus();
    _reveal(reply.id);
  }

  Future<void> _reveal(String id) async {
    final gen = ++_revealGen;
    await Future<void>.delayed(const Duration(milliseconds: 60));
    if (!mounted || gen != _revealGen) return;
    await _scrollToHighlighted();
    await Future<void>.delayed(const Duration(milliseconds: 1400));
    if (!mounted || gen != _revealGen || _highlightedId != id) return;
    setState(() => _highlightedId = null);
  }

  Future<void> _scrollToHighlighted() async {
    final target = _highlightKey.currentContext;
    if (target != null) {
      await Scrollable.ensureVisible(
        target,
        duration: const Duration(milliseconds: 380),
        curve: Curves.easeOutCubic,
        alignment: 0.28,
      );
      return;
    }
    final controller = _commentsScroll;
    if (controller == null || !controller.hasClients) return;
    await controller.animateTo(
      controller.position.maxScrollExtent,
      duration: const Duration(milliseconds: 380),
      curve: Curves.easeOutCubic,
    );
    await Future<void>.delayed(const Duration(milliseconds: 40));
    final built = _highlightKey.currentContext;
    if (!mounted || built == null) return;
    await Scrollable.ensureVisible(
      built,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      alignment: 0.28,
    );
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
        if (item.id != id)
          item.copyWith(
            replies: [
              for (final reply in item.replies)
                if (reply.id != id) reply,
            ],
          ),
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

    // Capture the keyboard inset BEFORE removing it from the sheet's
    // MediaQuery, so we can apply it manually to the composer only.
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;

    // Reserve at least 12dp of barrier at the top so tapping outside the
    // sheet always dismisses it, even when viewPadding.top is 0.
    final barrierGap = topInset < 12 ? 12.0 : topInset;

    // Hide the keyboard inset from everything below. This prevents
    // DraggableScrollableSheet from expanding when the keyboard opens —
    // we handle the composer's keyboard offset ourselves.
    return MediaQuery.removeViewInsets(
      context: context,
      removeBottom: true,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final available = constraints.maxHeight.isFinite
              ? constraints.maxHeight
              : MediaQuery.sizeOf(context).height;
          final sheetHeight = (available - barrierGap).clamp(0.0, available);
          _sheetHeight = sheetHeight;
          _screenHeight = available;

          return Padding(
            padding: EdgeInsets.only(top: barrierGap),
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
                  _commentsScroll = scrollController;
                  return ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                    child: ColoredBox(
                      color: colors.canvas,
                      // Hide the composer during the pop animation when
                      // the sheet is too small to fit it — prevents the
                      // overflow stripes on close.
                      child: LayoutBuilder(
                        builder: (context, sheetConstraints) {
                          final composerSlot =
                              keyboardInset + 80; // composer + margin
                          final canShowComposer =
                              sheetConstraints.maxHeight > composerSlot;

                          return Column(
                            children: [
                              Expanded(
                                child: CustomScrollView(
                                  controller: scrollController,
                                  physics:
                                  const AlwaysScrollableScrollPhysics(),
                                  slivers: [
                                    SliverPersistentHeader(
                                      pinned: true,
                                      delegate: _CommentsHeaderDelegate(
                                        onDragStart: _onHeaderDragStart,
                                        onDragUpdate: _onHeaderDragUpdate,
                                        onDragEnd: _onHeaderDragEnd,
                                      ),
                                    ),
                                    SliverPadding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      sliver: SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                              (context, index) {
                                            if (index.isOdd) {
                                              return const SizedBox(
                                                height: 12,
                                              );
                                            }
                                            final comment =
                                            _comments[index ~/ 2];
                                            return _CommentThread(
                                              comment: comment,
                                              expanded: _expanded.contains(
                                                comment.id,
                                              ),
                                              highlightedId: _highlightedId,
                                              highlightKey: _highlightKey,
                                              onToggle: () =>
                                                  _toggleReplies(comment.id),
                                              onMenu: (context, target) =>
                                                  _openCommentMenu(
                                                    context,
                                                    target,
                                                  ),
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
                              if (canShowComposer)
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: keyboardInset,
                                  ),
                                  child: _CommentComposer(
                                    avatarAsset: _composerAvatar,
                                    controller: _composer,
                                    focusNode: _composerFocus,
                                    replyToUsername: _replyTo?.author,
                                    onSubmit: _submit,
                                    onClearMention: () =>
                                        setState(() => _replyTo = null),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CommentsHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _CommentsHeaderDelegate({
    required this.onDragStart,
    required this.onDragUpdate,
    required this.onDragEnd,
  });

  static const _extent = 65.0;

  final GestureDragStartCallback onDragStart;
  final GestureDragUpdateCallback onDragUpdate;
  final GestureDragEndCallback onDragEnd;

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
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onVerticalDragStart: onDragStart,
        onVerticalDragUpdate: onDragUpdate,
        onVerticalDragEnd: onDragEnd,
        child: Column(
          children: [
            const SizedBox(height: 24),
            Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.muted,
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                ),
                child: const SizedBox(width: 40, height: 3),
              ),
            ),
            const SizedBox(height: 8),
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
            const SizedBox(height: 8),
            Divider(height: 1, thickness: 1, color: colors.line),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _CommentsHeaderDelegate oldDelegate) => true;
}
