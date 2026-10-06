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

  Future<void> _onDone(GalleryState state) async {
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
          child: BlocBuilder<GalleryBloc, GalleryState>(
            builder: (context, state) {
              return Column(
                children: [
                  const _DragHandle(),
                  const _PickerHeader(),
                  Divider(
                    height: 1,
                    thickness: 0.5,
                    color: AppearancePage.line(context),
                  ),
                  Expanded(child: _PickerBody(state: state)),
                  if (state.assets.isNotEmpty)
                    _PickerFooter(
                      state: state,
                      onDone: () => _onDone(state),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

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

class _PickerBody extends StatelessWidget {
  const _PickerBody({required this.state});

  final GalleryState state;

  @override
  Widget build(BuildContext context) {
    if (state.loading) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    if (state.permissionDenied) {
      return const _PermissionDenied();
    }

    if (state.assets.isEmpty) {
      return const _EmptyState();
    }

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
        final selectedIndex = state.selectedAssets.indexOf(asset);
        final selected = selectedIndex >= 0;
        return _AssetTile(
          asset: asset,
          selected: selected,
          badge: selected ? selectedIndex + 1 : null,
          onTap: () => context
              .read<GalleryBloc>()
              .add(GalleryAssetToggled(asset.id)),
        );
      },
    );
  }
}

class _AssetTile extends StatelessWidget {
  const _AssetTile({
    required this.asset,
    required this.selected,
    required this.badge,
    required this.onTap,
  });

  final AssetEntity asset;
  final bool selected;
  final int? badge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _AssetThumbnail(asset: asset),
          if (selected)
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: KolekColors.blue600,
                  width: 3,
                ),
              ),
            ),
          if (badge != null)
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
                  '$badge',
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
  }
}

class _AssetThumbnail extends StatelessWidget {
  const _AssetThumbnail({required this.asset});

  final AssetEntity asset;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: asset.thumbnailDataWithSize(
        const ThumbnailSize.square(300),
        quality: 85,
      ),
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

class _PickerFooter extends StatelessWidget {
  const _PickerFooter({required this.state, required this.onDone});

  final GalleryState state;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final count = state.selectionCount;
    final enabled = count > 0;

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
            textStyle: KolekText.sans(size: 15, weight: FontWeight.w600),
          ),
          child: Text(enabled ? 'Add ($count)' : 'Select photos'),
        ),
      ),
    );
  }
}