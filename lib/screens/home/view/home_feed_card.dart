part of 'home_screen.dart';

class _FeedCard extends StatelessWidget {
  const _FeedCard({
    required this.post,
    required this.saved,
    required this.liked,
    required this.onSaved,
    required this.onReact,
    required this.onComments,
  });

  final HomePost post;
  final bool saved;
  final bool liked;
  final VoidCallback onSaved;
  final VoidCallback onReact;
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
                child: _PostMenu(saved: saved, onSelected: close),
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
                  saved
                      ? 'assets/icons/save_active.svg'
                      : 'assets/icons/save_post.svg',
                  width: 22,
                  height: 22,
                  colorFilter: saved
                      ? null
                      : const ColorFilter.mode(
                          KolekColors.neutral700,
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
                  _ReactHeart(liked: liked, count: post.likes, onTap: onReact),
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
                  InkWell(
                    onTap: () => _showShareSheet(context),
                    child: _StatIcon(
                      asset: 'assets/icons/share.svg',
                      value: post.shareCount,
                      valueStyle: const TextStyle(
                        fontFamily: 'IBMPlexMono-Regular',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: KolekColors.neutral600,
                      ),
                    ),
                  ),
                  if (post.type.commerceIcon != null) ...[
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: post.type.opensProduct
                          ? () => Navigator.of(
                              context,
                            ).pushNamed(AppRoute.productDetails)
                          : null,
                      child: SvgPicture.asset(
                        post.type.commerceIcon!,
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
              _PostDescription(text: post.description),
            ],
          ),
        ),
      ],
    );
  }
}

class _PostDescription extends StatefulWidget {
  const _PostDescription({required this.text});

  final String text;

  @override
  State<_PostDescription> createState() => _PostDescriptionState();
}

class _PostDescriptionState extends State<_PostDescription> {
  static const _body = TextStyle(
    fontFamily: 'IBMPlexMono-Regular',
    fontSize: 12,
    height: 20 / 12,
    color: KolekColors.neutral500,
  );

  static const _action = TextStyle(
    fontFamily: 'IBMPlexMono-Regular',
    fontSize: 10,
    height: 20 / 10,
    color: KolekColors.neutral500,
  );

  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            maxLines: _expanded ? null : 2,
            overflow: _expanded ? TextOverflow.visible : TextOverflow.clip,
            style: _body,
          ),
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.only(top: 2, bottom: 2),
              child: Text(_expanded ? 'see less' : '...more', style: _action),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReactHeart extends StatefulWidget {
  const _ReactHeart({
    required this.liked,
    required this.count,
    required this.onTap,
  });

  final bool liked;
  final String count;
  final VoidCallback onTap;

  @override
  State<_ReactHeart> createState() => _ReactHeartState();
}

class _ReactHeartState extends State<_ReactHeart>
    with SingleTickerProviderStateMixin {
  static const _countStyle = TextStyle(
    fontFamily: 'IBMPlexMono-Regular',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: KolekColors.neutral600,
  );

  late final AnimationController _bounce;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _bounce = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    _scale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1,
          end: 1.28,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.28,
          end: 0.92,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.92,
          end: 1,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 30,
      ),
    ]).animate(_bounce);
  }

  @override
  void didUpdateWidget(covariant _ReactHeart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.liked && !oldWidget.liked) {
      _bounce.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _bounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScaleTransition(
            scale: _scale,
            child: SvgPicture.asset(
              widget.liked
                  ? 'assets/icons/react_active.svg'
                  : 'assets/icons/react_border.svg',
              width: 18,
              height: 18,
              colorFilter: widget.liked
                  ? null
                  : const ColorFilter.mode(
                      KolekColors.neutral700,
                      BlendMode.srcIn,
                    ),
            ),
          ),
          const SizedBox(width: 4),
          Text(widget.count, style: _countStyle),
        ],
      ),
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
