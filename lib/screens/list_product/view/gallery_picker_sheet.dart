import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../../../screens/appearance/appearance_page.dart';
import '../../../../theme/kolek_colors.dart';
import '../../../../widgets/kolek_widgets.dart';
import '../bloc/gallery_bloc.dart';
import '../bloc/gallery_event.dart';
import '../bloc/gallery_state.dart';

/// Modal bottom sheet for picking photos/videos from the device gallery.
///
/// Pops with a `List<String>` of file paths when the user confirms, or
/// `null` if they dismiss the sheet without picking anything.
class GalleryPickerSheet extends StatefulWidget {
  const GalleryPickerSheet({super.key, required this.maxSelectable});

  final int maxSelectable;

  static Future<List<String>?> show(
      BuildContext context, {
        required int maxSelectable,
      }) {
    return showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.35),
      builder: (_) => BlocProvider(
        create: (_) => GalleryBloc(maxSelectable: maxSelectable),
        child: GalleryPickerSheet(maxSelectable: maxSelectable),
      ),
    );
  }

  @override
  State<GalleryPickerSheet> createState() => _GalleryPickerSheetState();
}

class _GalleryPickerSheetState extends State<GalleryPickerSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<GalleryBloc>().add(const GalleryLoadRequested());
      }
    });
  }

  Future<void> _collectAndPop() async {
    final state = context.read<GalleryBloc>().state;
    final selected = state.selectedAssets;
    if (selected.isEmpty) {
      Navigator.of(context).pop();
      return;
    }

    final paths = <String>[];
    for (final asset in selected) {
      final file = await asset.file;
      if (file != null) paths.add(file.path);
    }

    if (!mounted) return;
    Navigator.of(context).pop(paths);
  }

  @override
  Widget build(BuildContext context) {
    final sheetHeight = MediaQuery.of(context).size.height * 0.92;

    return SizedBox(
      height: sheetHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppearancePage.background(context),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(16),
          ),
          child: Column(
            children: [
              const _DragHandle(),
              const _PickerHeader(),
              Divider(
                height: 1,
                thickness: 0.5,
                color: AppearancePage.line(context),
              ),
              const Expanded(child: _PickerBody()),
              _PickerFooter(onDone: _collectAndPop),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Drag handle
// ─────────────────────────────────────────────────────────────────────────

class _DragHandle extends StatelessWidget {
  const _DragHandle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 4),
      child: Center(
        child: Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: AppearancePage.line(context),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Header
// ─────────────────────────────────────────────────────────────────────────

class _PickerHeader extends StatelessWidget {
  const _PickerHeader();

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 4, 12, 10),
      child: Row(
        children: [
          Text(
            'Recent',
            style: KolekText.sans(
              size: 18,
              weight: FontWeight.w600,
              color: fg,
            ),
          ),
          const SizedBox(width: 6),
          Icon(Icons.keyboard_arrow_down, size: 22, color: fg),
          const Spacer(),
          IconButton(
            onPressed: () {
              // TODO: wire to device camera via image_picker when ready.
            },
            icon: Icon(
              Icons.photo_camera_outlined,
              size: 24,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Body — outer rebuild is scoped to non-selection state
// ─────────────────────────────────────────────────────────────────────────

class _PickerBody extends StatelessWidget {
  const _PickerBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryBloc, GalleryState>(
      // Selection changes are handled per-tile below. The body only needs
      // to react to load status and the asset list itself.
      buildWhen: (prev, next) =>
      prev.loading != next.loading ||
          prev.permissionDenied != next.permissionDenied ||
          !identical(prev.assets, next.assets),
      builder: (context, state) {
        if (state.loading) {
          return const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        }
        if (state.permissionDenied) return const _PermissionDenied();
        if (state.assets.isEmpty) return const _EmptyState();

        return GridView.builder(
          padding: const EdgeInsets.all(2),
          itemCount: state.assets.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
          ),
          itemBuilder: (context, index) {
            final asset = state.assets[index];
            // Keyed by asset id so Flutter reuses the tile widget (and
            // its memoized thumbnail) even if the list reorders.
            return _AssetTile(key: ValueKey(asset.id), asset: asset);
          },
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Tile — rebuilds only when ITS OWN selection/badge changes
// ─────────────────────────────────────────────────────────────────────────

class _AssetTile extends StatelessWidget {
  const _AssetTile({super.key, required this.asset});

  final AssetEntity asset;

  @override
  Widget build(BuildContext context) {
    // Per-tile selector. When tile A is tapped, only tile A's tuple
    // changes — so only tile A rebuilds. Badge numbers on other tiles
    // don't change, so they don't rebuild either.
    return BlocSelector<
        GalleryBloc,
        GalleryState,
        ({bool selected, int? badge})>(
      selector: (state) {
        final idx = state.selectedAssets.indexOf(asset);
        return (selected: idx >= 0, badge: idx >= 0 ? idx + 1 : null);
      },
      builder: (context, sel) {
        return GestureDetector(
          onTap: () => context
              .read<GalleryBloc>()
              .add(GalleryAssetToggled(asset.id)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _AssetThumbnail(asset: asset),
              if (sel.selected)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: KolekColors.blue600,
                      width: 3,
                    ),
                  ),
                ),
              if (sel.badge != null)
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    width: 22,
                    height: 22,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: KolekColors.blue600,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${sel.badge}',
                      style: KolekText.sans(
                        size: 11,
                        weight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Thumbnail — future is created once per asset, never re-created
// ─────────────────────────────────────────────────────────────────────────

class _AssetThumbnail extends StatefulWidget {
  const _AssetThumbnail({required this.asset});

  final AssetEntity asset;

  @override
  State<_AssetThumbnail> createState() => _AssetThumbnailState();
}

class _AssetThumbnailState extends State<_AssetThumbnail> {
  /// Resolved once, in initState. Rebuilt only when the asset itself
  /// changes — which never happens for a keyed grid tile. This is what
  /// stops the thumbnails from flickering on every selection change.
  late Future<Uint8List?> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  @override
  void didUpdateWidget(covariant _AssetThumbnail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.asset.id != widget.asset.id) {
      _future = _load();
    }
  }

  Future<Uint8List?> _load() {
    return widget.asset.thumbnailDataWithSize(
      const ThumbnailSize.square(300),
      quality: 85,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return ColoredBox(color: AppearancePage.field(context));
        }
        final bytes = snapshot.data;
        if (bytes == null) {
          return ColoredBox(
            color: AppearancePage.field(context),
            child: Icon(
              Icons.broken_image_outlined,
              color: AppearancePage.muted(context),
            ),
          );
        }
        return Image.memory(
          bytes,
          fit: BoxFit.cover,
          gaplessPlayback: true,
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Permission denied + empty states
// ─────────────────────────────────────────────────────────────────────────

class _PermissionDenied extends StatelessWidget {
  const _PermissionDenied();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.lock_outline,
              size: 42,
              color: AppearancePage.muted(context),
            ),
            const SizedBox(height: 16),
            Text(
              'Photo access is disabled',
              style: KolekText.sans(
                size: 16,
                weight: FontWeight.w600,
                color: AppearancePage.foreground(context),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Enable access in your device settings to pick photos for your listing.',
              textAlign: TextAlign.center,
              style: KolekText.sans(
                size: 13,
                color: AppearancePage.muted(context),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => PhotoManager.openSetting(),
              child: const Text('Open Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No photos on this device',
        style: KolekText.sans(
          size: 14,
          color: AppearancePage.muted(context),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Footer — rebuilds only when count or visibility changes
// ─────────────────────────────────────────────────────────────────────────

class _PickerFooter extends StatelessWidget {
  const _PickerFooter({required this.onDone});

  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
        GalleryBloc,
        GalleryState,
        ({bool show, int count})>(
      selector: (s) => (show: s.assets.isNotEmpty, count: s.selectionCount),
      builder: (context, data) {
        if (!data.show) return const SizedBox.shrink();
        final enabled = data.count > 0;

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton(
              onPressed: enabled ? onDone : null,
              style: FilledButton.styleFrom(
                backgroundColor: KolekColors.blue600,
                disabledBackgroundColor:
                KolekColors.blue600.withValues(alpha: 0.35),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: KolekText.sans(
                  size: 15,
                  weight: FontWeight.w600,
                ),
              ),
              child: Text(enabled ? 'Add (${data.count})' : 'Select photos'),
            ),
          ),
        );
      },
    );
  }
}