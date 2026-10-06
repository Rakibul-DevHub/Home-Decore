import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_fade_divider.dart';
import '../../../widgets/kolek_widgets.dart';
import '../bloc/list_product_bloc.dart';
import '../bloc/list_product_event.dart';
import '../bloc/list_product_state.dart';
import '../data/list_product_data.dart';
import 'gallery_picker_sheet.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({super.key});

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  final _titleCtrl = TextEditingController();
  final _artistCtrl = TextEditingController();
  final _yearCtrl = TextEditingController();
  final _widthCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();

  @override
  void dispose() {
    _titleCtrl.dispose();
    _artistCtrl.dispose();
    _yearCtrl.dispose();
    _widthCtrl.dispose();
    _heightCtrl.dispose();
    super.dispose();
  }

  /// Opens the gallery modal and appends any picked photos to the form.
  Future<void> _openGallery() async {
    final bloc = context.read<ListProductBloc>();
    final remaining =
        ListProductData.maxPhotos - bloc.state.photos.length;
    if (remaining <= 0) return;

    final paths = await GalleryPickerSheet.show(
      context,
      maxSelectable: remaining,
    );

    if (!mounted || paths == null || paths.isEmpty) return;

    for (final path in paths) {
      bloc.add(ListProductPhotoAdded(path: path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: BlocListener<ListProductBloc, ListProductState>(
          listenWhen: (prev, next) =>
          !prev.submitting && next.submitting,
          listener: (context, state) {
            // TODO: navigate to the next step once it exists.
          },
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const _AppBar(),
              const _HeroSection(),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Photos ──────────────────────────────────────
                    BlocSelector<ListProductBloc, ListProductState,
                        ({List<String> photos, bool canAdd})>(
                      selector: (s) =>
                      (photos: s.photos, canAdd: s.canAddPhoto),
                      builder: (context, data) => _PhotosSection(
                        photos: data.photos,
                        canAddPhoto: data.canAdd,
                        onAddPhoto: _openGallery,
                      ),
                    ),
                    const SizedBox(height: 22),

                    // ── Title ───────────────────────────────────────
                    const _FieldLabel(ListProductData.titleLabel),
                    const SizedBox(height: 8),
                    _TextInput(
                      controller: _titleCtrl,
                      hint: ListProductData.titleHint,
                      maxLength: ListProductData.titleMaxLength,
                      onChanged: (v) => context
                          .read<ListProductBloc>()
                          .add(ListProductTitleChanged(v)),
                    ),
                    const SizedBox(height: 18),

                    // ── Artist ──────────────────────────────────────
                    const _FieldLabel(ListProductData.artistLabel),
                    const SizedBox(height: 8),
                    _TextInput(
                      controller: _artistCtrl,
                      hint: ListProductData.artistHint,
                      maxLength: ListProductData.artistMaxLength,
                      onChanged: (v) => context
                          .read<ListProductBloc>()
                          .add(ListProductArtistChanged(v)),
                    ),
                    const SizedBox(height: 18),

                    // ── Year ────────────────────────────────────────
                    const _FieldLabel(ListProductData.yearLabel),
                    const SizedBox(height: 8),
                    _TextInput(
                      controller: _yearCtrl,
                      hint: ListProductData.yearHint,
                      onChanged: (v) => context
                          .read<ListProductBloc>()
                          .add(ListProductYearChanged(v)),
                    ),
                    const SizedBox(height: 18),

                    // ── Category ────────────────────────────────────
                    const _FieldLabel(ListProductData.categoryLabel),
                    const SizedBox(height: 8),
                    BlocSelector<ListProductBloc, ListProductState, String?>(
                      selector: (s) => s.category,
                      builder: (context, category) => _CategoryDropdown(
                        value: category,
                        onSelected: (v) => context
                            .read<ListProductBloc>()
                            .add(ListProductCategoryChanged(v)),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // ── Dimensions ──────────────────────────────────
                    const _FieldLabel(ListProductData.dimensionsLabel),
                    const SizedBox(height: 8),
                    _DimensionsRow(
                      widthCtrl: _widthCtrl,
                      heightCtrl: _heightCtrl,
                      onWidthChanged: (v) => context
                          .read<ListProductBloc>()
                          .add(ListProductWidthChanged(v)),
                      onHeightChanged: (v) => context
                          .read<ListProductBloc>()
                          .add(ListProductHeightChanged(v)),
                    ),
                    const SizedBox(height: 28),

                    // ── Next ────────────────────────────────────────
                    BlocSelector<ListProductBloc, ListProductState, bool>(
                      selector: (s) => s.canProceed,
                      builder: (context, enabled) =>
                          _NextButton(enabled: enabled),
                    ),
                    // const SizedBox(height: 8),
                    const _SaveDraftLink(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// App bar
// ─────────────────────────────────────────────────────────────────────────

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 14, 4),
      child: Row(
        children: [
          SvgPicture.asset(
            ListProductData.logoAsset,
            height: 30,
            fit: BoxFit.contain,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: AppearancePage.foreground(context),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                size: 16,
                color: AppearancePage.background(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Hero
// ─────────────────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);

    return SizedBox(
      height: 210,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 16,
            top: 12,
            right: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ListProductData.heading,
                  style: KolekText.sans(
                    size: 52,
                    weight: FontWeight.w600,
                    fontFamily: KolekFonts.generalSansSemibold,
                    height: 1.0,
                    letterSpacing: -2,
                    color: fg,
                  ),
                ),
                const SizedBox(height: 14),
                Container(width: 26, height: 4, color: fg),
                const SizedBox(height: 14),
                Text(
                  ListProductData.subtext,
                  style: KolekText.mono(
                    size: 14,
                    weight: FontWeight.w500,
                    fontFamily: KolekFonts.ibmPlexMono,
                    height: 22 / 14,
                    letterSpacing: -1,
                    color: fg,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: -8,
            top: 0,
            bottom: -4,
            child: Image.asset(
              ListProductData.heroAsset,
              height: 230,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────
/// Photos
/// ─────────────────────────────────────────────────────────────────────────

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
            // Headroom for the ✕ badge that straddles the tile's top-right
            // corner. Without this, the ListView viewport clips it.
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

  int get _slotCount {
    final total = photos.length + (canAddPhoto ? 1 : 0);
    return total < 4 ? 4 : total;
  }
}

/// Photo tile that renders either an `assets/...` image or a file path
/// returned by the gallery picker. Uses `Image.file` for absolute paths
/// and `Image.asset` for bundled assets.
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
                  color: AppearancePage.foreground(context),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  size: 12,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

/// ─────────────────────────────────────────────────────────────────────────
/// Field label
/// ─────────────────────────────────────────────────────────────────────────

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: KolekText.mono(
        size: 14,
        weight: FontWeight.w600,
        fontFamily: KolekFonts.ibmPlexMono,
        height: 1.0,
        letterSpacing: 0,
        color: AppearancePage.foreground(context),
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────
/// Text input
/// ─────────────────────────────────────────────────────────────────────────

class _TextInput extends StatelessWidget {
  const _TextInput({
    required this.controller,
    required this.hint,
    required this.onChanged,
    this.maxLength,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);
    final muted = AppearancePage.muted(context);
    final line = AppearancePage.line(context);
    final field = AppearancePage.field(context);

    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: KolekText.mono(
        size: 12,
        weight: FontWeight.w400,
        height: 1.0,
        letterSpacing: 0,
        color: fg,
      ),
      cursorColor: KolekColors.blue600,
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        hintStyle: KolekText.mono(
          size: 12,
          weight: FontWeight.w400,
          height: 1.0,
          letterSpacing: 0,
          color: muted,
        ),
        suffix: maxLength == null
            ? null
            : ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (context, value, _) => Text(
            '${value.text.length}/$maxLength',
            style: KolekText.mono(
              size: 11,
              color: muted,
            ),
          ),
        ),
        filled: true,
        fillColor: field,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: KolekColors.blue600, width: 1.2),
        ),
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────
/// Category dropdown
/// ─────────────────────────────────────────────────────────────────────────

class _CategoryDropdown extends StatelessWidget {
  const _CategoryDropdown({
    required this.value,
    required this.onSelected,
  });

  final String? value;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);
    final muted = AppearancePage.muted(context);
    final line = AppearancePage.line(context);
    final field = AppearancePage.field(context);

    final display = value ?? ListProductData.categoryHint;
    final displayColor = value == null ? muted : fg;

    return PopupMenuButton<String>(
      tooltip: '',
      padding: EdgeInsets.zero,
      position: PopupMenuPosition.under,
      color: AppearancePage.menu(context),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: BorderSide(color: line),
      ),
      onSelected: onSelected,
      itemBuilder: (context) => [
        for (final category in ListProductData.categories)
          PopupMenuItem<String>(
            value: category,
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                category,
                style: KolekText.sans(size: 14, color: fg),
              ),
            ),
          ),
      ],
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: field,
          borderRadius: BorderRadius.circular(0),
          border: Border.all(color: line),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                display,
                style: KolekText.sans(size: 14, color: displayColor),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              size: 20,
              color: AppearancePage.icon(context),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Dimensions row
// ─────────────────────────────────────────────────────────────────────────

class _DimensionsRow extends StatelessWidget {
  const _DimensionsRow({
    required this.widthCtrl,
    required this.heightCtrl,
    required this.onWidthChanged,
    required this.onHeightChanged,
  });

  final TextEditingController widthCtrl;
  final TextEditingController heightCtrl;
  final ValueChanged<String> onWidthChanged;
  final ValueChanged<String> onHeightChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: _TextInput(
            controller: widthCtrl,
            hint: ListProductData.widthHint,
            onChanged: onWidthChanged,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '×',
            style: KolekText.sans(
              size: 16,
              color: AppearancePage.muted(context),
            ),
          ),
        ),
        Expanded(
          child: _TextInput(
            controller: heightCtrl,
            hint: ListProductData.heightHint,
            onChanged: onHeightChanged,
          ),
        ),
      ],
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────
/// Next button + Save draft link
/// ─────────────────────────────────────────────────────────────────────────

class _NextButton extends StatelessWidget {
  const _NextButton({required this.enabled});

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton(
        onPressed: enabled
            ? () => context
            .read<ListProductBloc>()
            .add(const ListProductSubmitted())
            : null,
        style: FilledButton.styleFrom(
          backgroundColor: KolekColors.blue600,
          disabledBackgroundColor:
          KolekColors.blue600.withValues(alpha: 0.35),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          // Style the label via textStyle so it applies consistently
          // across enabled and disabled states.
          textStyle: KolekText.sans(
            size: 16,
            weight: FontWeight.w500,
            height: 20 / 16,
            letterSpacing: 0,
          ),
        ),
        child: const Text(ListProductData.nextLabel),
      ),
    );
  }
}

class _SaveDraftLink extends StatelessWidget {
  const _SaveDraftLink();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () => context
              .read<ListProductBloc>()
              .add(const ListProductDraftSaved()),
          behavior: HitTestBehavior.opaque,
          child: SizedBox(
            height: 56,
            child: Center(
              child: Text(
                ListProductData.draftLabel,
                textAlign: TextAlign.center,
                style: KolekText.sans(
                  size: 16,
                  weight: FontWeight.w500,
                  height: 20 / 16,
                  letterSpacing: 0,
                  color: AppearancePage.muted(context),
                ),
              ),
            ),
          ),
        ),
        const KolekFadeDivider(
          height: 2,
        ),
      ],
    );
  }
}