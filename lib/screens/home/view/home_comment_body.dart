part of 'home_screen.dart';

class _CommentBody extends StatelessWidget {
  const _CommentBody({required this.comment});

  final HomeComment comment;

  @override
  Widget build(BuildContext context) {
    final colors = _HomeColors.of(context);
    final body = TextStyle(
      fontFamily: 'IBMPlexMono-Regular',
      fontSize: 14,
      height: 20 / 14,
      color: colors.muted,
    );
    final mention = comment.mention;
    if (mention == null) return Text(comment.message, style: body);
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: mention,
            style: TextStyle(
              fontFamily: 'GeneralSans-Semibold',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 20 / 14,
              color: colors.text,
            ),
          ),
          TextSpan(text: ' ${comment.message}', style: body),
        ],
      ),
    );
  }
}
