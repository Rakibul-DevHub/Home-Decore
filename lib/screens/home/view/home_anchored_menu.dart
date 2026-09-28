part of 'home_screen.dart';

class _AnchoredMenuEntry<T> {
  const _AnchoredMenuEntry(this.label, this.value, {this.destructive = false});

  final String label;
  final T value;
  final bool destructive;
}

Future<T?> _showAnchoredMenu<T>(
  BuildContext context,
  List<_AnchoredMenuEntry<T>> entries,
) {
  final button = context.findRenderObject() as RenderBox?;
  final overlayState = Overlay.of(context);
  final overlay = overlayState.context.findRenderObject() as RenderBox?;
  if (button == null || overlay == null) return Future.value();

  final offset = button.localToGlobal(Offset.zero, ancestor: overlay);
  final completer = Completer<T?>();
  late OverlayEntry entry;

  void close([T? value]) {
    if (!completer.isCompleted) completer.complete(value);
    entry.remove();
  }

  final top = offset.dy + button.size.height + 6;
  final right = overlay.size.width - offset.dx - button.size.width;

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
            top: top,
            right: right < 8 ? 8 : right,
            child: Material(
              color: Colors.white,
              elevation: 8,
              shadowColor: Colors.black26,
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                width: 148,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (var i = 0; i < entries.length; i++) ...[
                      if (i > 0)
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: KolekColors.neutral200,
                        ),
                      InkWell(
                        onTap: () => close(entries[i].value),
                        child: SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                entries[i].label,
                                style: TextStyle(
                                  fontFamily: 'GeneralSans-Medium',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: entries[i].destructive
                                      ? const Color(0xFFFF3B30)
                                      : KolekColors.neutral900,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    },
  );

  overlayState.insert(entry);
  return completer.future;
}
