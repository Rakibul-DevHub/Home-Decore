// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../screens/appearance/appearance_page.dart';
// import '../../../theme/kolek_colors.dart';
// import '../../../widgets/kolek_widgets.dart';
// import '../../messages/data/messages_data.dart';
// import '../bloc/inbox_bloc.dart';
// import '../bloc/inbox_event.dart';
// import '../bloc/inbox_state.dart';
//
// class InboxScreen extends StatefulWidget {
//   const InboxScreen({super.key});
//
//   @override
//   State<InboxScreen> createState() => _InboxScreenState();
// }
//
// class _InboxScreenState extends State<InboxScreen> {
//   late final TextEditingController _draftController;
//
//   @override
//   void initState() {
//     super.initState();
//     _draftController = TextEditingController(
//       text: context.read<InboxBloc>().state.draft,
//     );
//   }
//
//   @override
//   void dispose() {
//     _draftController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppearancePage.background(context),
//       resizeToAvoidBottomInset: true,
//       appBar: const _InboxAppBar(),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Expanded(
//             child: BlocBuilder<InboxBloc, InboxState>(
//               builder: (context, state) {
//                 return ListView.builder(
//                   padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
//                   itemCount: state.messages.length,
//                   itemBuilder: (context, index) {
//                     return _ChatBubble(message: state.messages[index]);
//                   },
//                 );
//               },
//             ),
//           ),
//           BlocSelector<InboxBloc, InboxState, String?>(
//             selector: (s) => s.thread.typingName,
//             builder: (context, typingName) {
//               if (typingName == null || typingName.isEmpty) {
//                 return const SizedBox.shrink();
//               }
//               return Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
//                 child: _TypingIndicator(name: typingName),
//               );
//             },
//           ),
//           _Composer(
//             controller: _draftController,
//             onChanged: (v) =>
//                 context.read<InboxBloc>().add(InboxDraftChanged(v)),
//             onSend: () {
//               context.read<InboxBloc>().add(const InboxMessageSent());
//               _draftController.clear();
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _TypingIndicator extends StatefulWidget {
//   const _TypingIndicator({required this.name});
//
//   final String name;
//
//   @override
//   State<_TypingIndicator> createState() => _TypingIndicatorState();
// }
//
// class _TypingIndicatorState extends State<_TypingIndicator>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 900),
//     )..repeat();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Ping-pong between two theme-aware tones for the animated dots.
//     final dotLow = AppearancePage.line(context);
//     final dotHigh = AppearancePage.muted(context);
//
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           AnimatedBuilder(
//             animation: _controller,
//             builder: (context, _) {
//               return Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: List.generate(3, (index) {
//                   final phase = (_controller.value + index / 3) % 1.0;
//                   final t = (phase < 0.5 ? phase : 1 - phase) * 2;
//                   final color = Color.lerp(dotLow, dotHigh, t)!;
//                   return Padding(
//                     padding: EdgeInsets.only(right: index == 2 ? 0 : 3),
//                     child: Container(
//                       width: 4,
//                       height: 4,
//                       decoration: BoxDecoration(
//                         color: color,
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                   );
//                 }),
//               );
//             },
//           ),
//           const SizedBox(width: 8),
//           Text(
//             '${widget.name} is typing...',
//             style: KolekText.sans(
//               size: 13,
//               weight: FontWeight.w400,
//               color: AppearancePage.muted(context),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _InboxAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const _InboxAppBar();
//
//   @override
//   Size get preferredSize => const Size.fromHeight(64);
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: AppearancePage.background(context),
//       elevation: 0,
//       scrolledUnderElevation: 0,
//       toolbarHeight: 64,
//       leadingWidth: 40,
//       leading: IconButton(
//         onPressed: () => Navigator.of(context).pop(),
//         icon: Icon(
//           Icons.arrow_back,
//           size: 22,
//           color: AppearancePage.icon(context),
//         ),
//       ),
//       titleSpacing: 4,
//       title: BlocBuilder<InboxBloc, InboxState>(
//         builder: (context, state) {
//           final thread = state.thread;
//           return Row(
//             children: [
//               ClipOval(
//                 child: Image.asset(
//                   thread.avatarAsset,
//                   width: 40,
//                   height: 40,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       thread.name,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: KolekText.sans(
//                         size: 16,
//                         weight: FontWeight.w700,
//                         color: AppearancePage.foreground(context),
//                         height: 1.15,
//                       ),
//                     ),
//                     const SizedBox(height: 2),
//                     if (thread.isOnline)
//                       Row(
//                         children: [
//                           Container(
//                             width: 7,
//                             height: 7,
//                             decoration: const BoxDecoration(
//                               color: MessagesData.onlineColor,
//                               shape: BoxShape.circle,
//                             ),
//                           ),
//                           const SizedBox(width: 5),
//                           Text(
//                             'Active now',
//                             style: KolekText.sans(
//                               size: 12,
//                               weight: FontWeight.w400,
//                               color: AppearancePage.muted(context),
//                             ),
//                           ),
//                         ],
//                       ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//       actions: [
//         IconButton(
//           onPressed: () {},
//           icon: Icon(
//             Icons.more_vert,
//             size: 22,
//             color: AppearancePage.icon(context),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _ChatBubble extends StatelessWidget {
//   const _ChatBubble({
//     required this.message,
//     this.bottom = 16,
//   });
//
//   final ChatMessage message;
//   final double bottom;
//
//   @override
//   Widget build(BuildContext context) {
//     final isMine = message.isMine;
//
//     return Padding(
//       padding: EdgeInsets.only(bottom: bottom),
//       child: Align(
//         alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
//         child: ConstrainedBox(
//           constraints: BoxConstraints(
//             maxWidth: MediaQuery.sizeOf(context).width * 0.72,
//           ),
//           child: Column(
//             crossAxisAlignment:
//             isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
//                 decoration: BoxDecoration(
//                   color: message.bubbleColor,
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 child: Text(
//                   message.text,
//                   style: KolekText.mono(
//                     size: 13,
//                     color: Colors.white,
//                     height: 1.4,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Text(
//                 message.timeLabel,
//                 style: KolekText.mono(
//                   size: 11,
//                   color: AppearancePage.muted(context),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _Composer extends StatelessWidget {
//   const _Composer({
//     required this.controller,
//     required this.onChanged,
//     required this.onSend,
//   });
//
//   final TextEditingController controller;
//   final ValueChanged<String> onChanged;
//   final VoidCallback onSend;
//
//   @override
//   Widget build(BuildContext context) {
//     // Scaffold already resizes for the keyboard — do not add viewInsets again.
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
//       child: Container(
//         padding: const EdgeInsets.fromLTRB(14, 8, 8, 8),
//         decoration: BoxDecoration(
//           color: AppearancePage.field(context),
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: AppearancePage.line(context)),
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Expanded(
//               child: TextField(
//                 controller: controller,
//                 onChanged: onChanged,
//                 minLines: 1,
//                 maxLines: 4,
//                 textInputAction: TextInputAction.send,
//                 onSubmitted: (_) => onSend(),
//                 style: KolekText.mono(
//                   size: 13,
//                   color: AppearancePage.foreground(context),
//                   height: 1.35,
//                 ),
//                 cursorColor: KolekColors.blue600,
//                 decoration: InputDecoration(
//                   isDense: true,
//                   hintText: 'Write a message...',
//                   hintStyle: KolekText.mono(
//                     size: 13,
//                     color: AppearancePage.muted(context),
//                   ),
//                   border: InputBorder.none,
//                   contentPadding: const EdgeInsets.symmetric(vertical: 8),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8),
//             Material(
//               color: KolekColors.blue600,
//               borderRadius: BorderRadius.circular(4),
//               child: InkWell(
//                 onTap: onSend,
//                 borderRadius: BorderRadius.circular(4),
//                 child: const SizedBox(
//                   width: 40,
//                   height: 40,
//                   child: Icon(
//                     Icons.arrow_upward_rounded,
//                     size: 20,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../../messages/data/messages_data.dart';
import '../bloc/inbox_bloc.dart';
import '../bloc/inbox_event.dart';
import '../bloc/inbox_state.dart';

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
      text: context.read<InboxBloc>().state.draft,
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
      backgroundColor: AppearancePage.background(context),
      resizeToAvoidBottomInset: true,
      appBar: const _InboxAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: BlocBuilder<InboxBloc, InboxState>(
              builder: (context, state) {
                final lastIndex = state.messages.length - 1;
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final message = state.messages[index];
                    // Only the newest outgoing message plays the pop-in.
                    final isNewestMine =
                        message.isMine && index == lastIndex;
                    return _ChatBubble(
                      message: message,
                      animate: isNewestMine,
                    );
                  },
                );
              },
            ),
          ),
          BlocSelector<InboxBloc, InboxState, String?>(
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
            onChanged: (v) =>
                context.read<InboxBloc>().add(InboxDraftChanged(v)),
            onSend: () {
              context.read<InboxBloc>().add(const InboxMessageSent());
              _draftController.clear();
            },
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Typing indicator (unchanged)
// ─────────────────────────────────────────────────────────────────────────

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
    final dotLow = AppearancePage.line(context);
    final dotHigh = AppearancePage.muted(context);

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
                  final color = Color.lerp(dotLow, dotHigh, t)!;
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
              color: AppearancePage.muted(context),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// App bar (unchanged)
// ─────────────────────────────────────────────────────────────────────────

class _InboxAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _InboxAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppearancePage.background(context),
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: 64,
      leadingWidth: 40,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Icon(
          Icons.arrow_back,
          size: 22,
          color: AppearancePage.icon(context),
        ),
      ),
      titleSpacing: 4,
      title: BlocBuilder<InboxBloc, InboxState>(
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
                        color: AppearancePage.foreground(context),
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
                              color: AppearancePage.muted(context),
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
          icon: Icon(
            Icons.more_vert,
            size: 22,
            color: AppearancePage.icon(context),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Chat bubble with pop-in animation
// ─────────────────────────────────────────────────────────────────────────

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({
    required this.message,
    this.bottom = 16,
    this.animate = false,
  });

  final ChatMessage message;
  final double bottom;

  /// When true, the bubble plays a one-shot pop-in animation on first build.
  /// Non-newest bubbles skip the animation entirely.
  final bool animate;

  @override
  Widget build(BuildContext context) {
    final isMine = message.isMine;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: _PopIn(
        play: animate,
        alignment: isMine ? Alignment.bottomRight : Alignment.bottomLeft,
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
                    color: AppearancePage.muted(context),
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

/// Plays a one-shot pop-in: scale from 0.6 → 1.0 with an overshoot, plus a
/// small slide from the send corner, plus a fade. When [play] is false the
/// widget settles instantly at its final state — used for historic messages.
class _PopIn extends StatefulWidget {
  const _PopIn({
    required this.child,
    required this.play,
    required this.alignment,
  });

  final Widget child;
  final bool play;
  final Alignment alignment;

  @override
  State<_PopIn> createState() => _PopInState();
}

class _PopInState extends State<_PopIn> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 340),
    );

    // Scale overshoots past 1.0 then settles — that's the bounce.
    _scale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack),
    );

    // Fade goes straight to full — no overshoot on opacity.
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);

    // Slide in from slightly below and to the side the bubble lives on.
    _slide = Tween<Offset>(
      begin: const Offset(0.12, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic),
    );

    if (widget.play) {
      _ctrl.forward();
    } else {
      _ctrl.value = 1.0;
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: ScaleTransition(
          scale: _scale,
          alignment: widget.alignment,
          child: widget.child,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Composer with bounce-on-send
// ─────────────────────────────────────────────────────────────────────────

class _Composer extends StatefulWidget {
  const _Composer({
    required this.controller,
    required this.onChanged,
    required this.onSend,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onSend;

  @override
  State<_Composer> createState() => _ComposerState();
}

class _ComposerState extends State<_Composer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bounce;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _bounce = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );

    // 1.0 → 0.82 → 1.12 → 1.0 : squish, overshoot, settle.
    _scale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.82),
        weight: 35,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.82, end: 1.12),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.12, end: 1.0),
        weight: 25,
      ),
    ]).animate(CurvedAnimation(parent: _bounce, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _bounce.dispose();
    super.dispose();
  }

  void _handleSend() {
    if (widget.controller.text.trim().isEmpty) return;
    _bounce.forward(from: 0);
    widget.onSend();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 8, 8, 8),
        decoration: BoxDecoration(
          color: AppearancePage.field(context),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppearancePage.line(context)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                controller: widget.controller,
                onChanged: widget.onChanged,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _handleSend(),
                style: KolekText.mono(
                  size: 13,
                  color: AppearancePage.foreground(context),
                  height: 1.35,
                ),
                cursorColor: KolekColors.blue600,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Write a message...',
                  hintStyle: KolekText.mono(
                    size: 13,
                    color: AppearancePage.muted(context),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ScaleTransition(
              scale: _scale,
              child: Material(
                color: KolekColors.blue600,
                borderRadius: BorderRadius.circular(4),
                child: InkWell(
                  onTap: _handleSend,
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
            ),
          ],
        ),
      ),
    );
  }
}