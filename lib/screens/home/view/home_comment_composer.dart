part of 'home_screen.dart';

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
