part of 'list_product_screen.dart';

/// Photos label, counter, and the horizontal scroll row of tiles.
class _PhotosSection extends StatelessWidget {
  const _PhotosSection({
    required this.photos,
    required this.canAddPhoto,
    required this.onAddPhoto,
  });

  final List<String> photos;
  final bool canAddPhoto;
  final VoidCallback onAddPhoto;

  /// The tile is 82px tall. The ✕ badge overhangs 6px above the tile,
  /// so the row needs at least 6px of headroom on top. We give it 7px
  /// of padding on both sides — 7 + 82 + 7 = 96.
  static const _rowHeight = 96.0;
  static const _rowPadY = 7.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const _FieldLabel(ListProductData.photosLabel),
            const Spacer(),
            Text(
              '${photos.length}/${ListProductData.maxPhotos}',
              style: KolekText.mono(
                size: 11,
                color: AppearancePage.muted(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: _rowHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(vertical: _rowPadY),
            itemCount: _slotCount,
            separatorBuilder: (_, _) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              if (index < photos.length) {
                return _PhotoTile(
                  path: photos[index],
                  onRemove: () => context
                      .read<ListProductBloc>()
                      .add(ListProductPhotoRemoved(index)),
                );
              }
              if (index == photos.length && canAddPhoto) {
                return _AddPhotoTile(onTap: onAddPhoto);
              }
              return const _EmptyPhotoTile();
            },
          ),
        ),
      ],
    );
  }

  /// Photos + optional add tile, padded to a minimum of four slots so
  /// the row always looks populated.
  int get _slotCount {
    final total = photos.length + (canAddPhoto ? 1 : 0);
    return total < 4 ? 4 : total;
  }
}

/// Selected photo tile with a floating ✕ remove badge.
class _PhotoTile extends StatelessWidget {
  const _PhotoTile({required this.path, required this.onRemove});

  final String path;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 76,
      height: 82,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: _PhotoImage(path: path, width: 76, height: 82),
          ),
          Positioned(
            top: -6,
            right: -6,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  // Foreground-colored circle → dark in light mode,
                  // light in dark mode. Reads as a high-contrast chip
                  // against any photo.
                  color: AppearancePage.foreground(context),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  size: 12,
                  // Opposite of the circle so the ✕ stays visible.
                  color: AppearancePage.background(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Renders a photo from either a bundled asset or a file-system path.
///
/// Bundled assets start with `assets/`. Anything else is treated as a
/// file path returned by the gallery picker.
class _PhotoImage extends StatelessWidget {
  const _PhotoImage({
    required this.path,
    required this.width,
    required this.height,
  });

  final String path;
  final double width;
  final double height;

  bool get _isAsset => path.startsWith('assets/');

  @override
  Widget build(BuildContext context) {
    if (_isAsset) {
      return Image.asset(
        path,
        width: width,
        height: height,
        fit: BoxFit.cover,
      );
    }
    return Image.file(
      File(path),
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => ColoredBox(
        color: AppearancePage.field(context),
        child: Icon(
          Icons.broken_image_outlined,
          color: AppearancePage.muted(context),
        ),
      ),
    );
  }
}

/// Dashed "+" tile that opens the gallery modal.
class _AddPhotoTile extends StatelessWidget {
  const _AddPhotoTile({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);
    final muted = AppearancePage.muted(context);
    final line = AppearancePage.line(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 76,
        height: 82,
        decoration: BoxDecoration(
          color: AppearancePage.field(context),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: line),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 22, color: fg),
            const SizedBox(height: 6),
            Text(
              ListProductData.addPhotosLabel,
              textAlign: TextAlign.center,
              style: KolekText.sans(
                size: 12,
                weight: FontWeight.w500,
                fontFamily: KolekFonts.generalSans,
                height: 1.0,
                letterSpacing: 0,
                color: muted,   // ← the fix
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Empty placeholder tile — fills out the row when there are fewer
/// than four real tiles to show.
class _EmptyPhotoTile extends StatelessWidget {
  const _EmptyPhotoTile();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76,
      height: 82,
      decoration: BoxDecoration(
        color: AppearancePage.field(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppearancePage.line(context)),
      ),
    );
  }
}