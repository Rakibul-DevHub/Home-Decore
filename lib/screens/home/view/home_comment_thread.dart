part of 'home_screen.dart';

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
    final multiple = replies.length > 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CommentTile(
          comment: comment,
          onMenu: onMenu,
          onReply: () => onReply(comment),
          replyLabel: multiple
              ? (expanded
                    ? 'Hide replies'
                    : 'View ${replies.length} more replies')
              : null,
          onReplies: multiple ? onToggle : null,
        ),
        if (!multiple || expanded)
          for (final reply in replies)
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 12),
              child: _CommentTile(
                comment: reply,
                nested: true,
                onMenu: onMenu,
                onReply: () => onReply(reply),
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
    final colors = _HomeColors.of(context);
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
                      color: colors.text,
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
                      color: colors.muted,
                    ),
                  ),
                  if (nested) ...[
                    const Spacer(),
                    Builder(
                      builder: (buttonContext) => InkWell(
                        onTap: () => onMenu(buttonContext, comment),
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Icon(
                            Icons.more_horiz,
                            size: 18,
                            color: colors.muted,
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
                child: Text(
                  'Reply',
                  style: TextStyle(
                    fontFamily: 'IBMPlexMono-Medium',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 16 / 14,
                    color: colors.text,
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
                      Container(width: 32, height: 1, color: colors.line),
                      const SizedBox(width: 8),
                      Text(
                        replyLabel!,
                        style: TextStyle(
                          fontFamily: 'IBMPlexMono-Regular',
                          fontSize: 12,
                          height: 1,
                          letterSpacing: -1,
                          color: colors.muted,
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
