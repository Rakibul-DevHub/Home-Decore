import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../../messages/data/messages_data.dart';
import '../cubit/inbox_cubit.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  late final TextEditingController _draftController;

  @override
  void initState() {
    super.initState();
    _draftController = TextEditingController(
      text: context.read<InboxCubit>().state.draft,
    );
  }

  @override
  void dispose() {
    _draftController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: const _InboxAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: BlocBuilder<InboxCubit, InboxState>(
              builder: (context, state) {
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    return _ChatBubble(message: state.messages[index]);
                  },
                );
              },
            ),
          ),
          BlocSelector<InboxCubit, InboxState, String?>(
            selector: (s) => s.thread.typingName,
            builder: (context, typingName) {
              if (typingName == null || typingName.isEmpty) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                child: _TypingIndicator(name: typingName),
              );
            },
          ),
          _Composer(
            controller: _draftController,
            onChanged: context.read<InboxCubit>().setDraft,
            onSend: () {
              context.read<InboxCubit>().send();
              _draftController.clear();
            },
          ),
        ],
      ),
    );
  }
}

class _TypingIndicator extends StatefulWidget {
  const _TypingIndicator({required this.name});

  final String name;

  @override
  State<_TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(3, (index) {
                  final phase = (_controller.value + index / 3) % 1.0;
                  final t = (phase < 0.5 ? phase : 1 - phase) * 2;
                  final color = Color.lerp(
                    KolekColors.neutral300,
                    KolekColors.neutral500,
                    t,
                  )!;
                  return Padding(
                    padding: EdgeInsets.only(right: index == 2 ? 0 : 3),
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }),
              );
            },
          ),
          const SizedBox(width: 8),
          Text(
            '${widget.name} is typing...',
            style: KolekText.sans(
              size: 13,
              weight: FontWeight.w400,
              color: KolekColors.neutral400,
            ),
          ),
        ],
      ),
    );
  }
}

class _InboxAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _InboxAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: 64,
      leadingWidth: 40,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(
          Icons.arrow_back,
          size: 22,
          color: KolekColors.neutral500,
        ),
      ),
      titleSpacing: 4,
      title: BlocBuilder<InboxCubit, InboxState>(
        builder: (context, state) {
          final thread = state.thread;
          return Row(
            children: [
              ClipOval(
                child: Image.asset(
                  thread.avatarAsset,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      thread.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: KolekText.sans(
                        size: 16,
                        weight: FontWeight.w700,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    if (thread.isOnline)
                      Row(
                        children: [
                          Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                              color: MessagesData.onlineColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Active now',
                            style: KolekText.sans(
                              size: 12,
                              weight: FontWeight.w400,
                              color: KolekColors.neutral400,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert,
            size: 22,
            color: KolekColors.neutral500,
          ),
        ),
      ],
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({
    required this.message,
    this.bottom = 16,
  });

  final ChatMessage message;
  final double bottom;

  @override
  Widget build(BuildContext context) {
    final isMine = message.isMine;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Align(
        alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * 0.72,
          ),
          child: Column(
            crossAxisAlignment:
                isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                decoration: BoxDecoration(
                  color: message.bubbleColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  message.text,
                  style: KolekText.mono(
                    size: 13,
                    color: Colors.white,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                message.timeLabel,
                style: KolekText.mono(
                  size: 11,
                  color: KolekColors.neutral400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer({
    required this.controller,
    required this.onChanged,
    required this.onSend,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    // Scaffold already resizes for the keyboard — do not add viewInsets again.
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 8, 8, 8),
        decoration: BoxDecoration(
          color: KolekColors.neutral100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: KolekColors.neutral200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => onSend(),
                style: KolekText.mono(size: 13, height: 1.35),
                cursorColor: KolekColors.blue600,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Write a message...',
                  hintStyle: KolekText.mono(
                    size: 13,
                    color: KolekColors.neutral400,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Material(
              color: KolekColors.blue600,
              borderRadius: BorderRadius.circular(4),
              child: InkWell(
                onTap: onSend,
                borderRadius: BorderRadius.circular(4),
                child: const SizedBox(
                  width: 40,
                  height: 40,
                  child: Icon(
                    Icons.arrow_upward_rounded,
                    size: 20,
                    color: Colors.white,
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
