part of 'home_screen.dart';

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
