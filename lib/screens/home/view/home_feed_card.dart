part of 'home_screen.dart';

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
