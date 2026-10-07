import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../bloc/list_product_bloc.dart';
import '../bloc/list_product_event.dart';
import '../bloc/list_product_state.dart';
import '../data/pricing_data.dart';
import 'framing_screen.dart';
import 'return_policy_screen.dart';

class ListProductReviewScreen extends StatefulWidget {
  const ListProductReviewScreen({super.key});

  @override
  State<ListProductReviewScreen> createState() =>
      _ListProductReviewScreenState();
}

class _ListProductReviewScreenState extends State<ListProductReviewScreen> {
  late final TextEditingController _descCtrl;

  @override
  void initState() {
    super.initState();
    _descCtrl = TextEditingController(
      text: context.read<ListProductBloc>().state.description,
    );
  }

  @override
  void dispose() {
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);
    final bg = AppearancePage.background(context);
    final muted = AppearancePage.muted(context);
    final line = AppearancePage.line(context);
    final field = AppearancePage.field(context);
    final bloc = context.read<ListProductBloc>();

    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: Column(
          children: [
            // ── App Bar ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: fg,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                        color: bg,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'List a Product',
                    style: KolekText.sans(
                      size: 18,
                      weight: FontWeight.w600,
                      color: fg,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      bloc.add(const ListProductSubmitted());
                      Navigator.of(context).popUntil((r) => r.isFirst);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: KolekColors.blue600,
                    ),
                    child: Text(
                      'Share',
                      style: KolekText.sans(
                        size: 16,
                        weight: FontWeight.w500,
                        color: KolekColors.blue600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Body ─────────────────────────────────────────────
            Expanded(
              child: BlocBuilder<ListProductBloc, ListProductState>(
                builder: (context, state) {
                  final isBuyNow = state.listingKind == ListingKind.buyNow;
                  final priceText = isBuyNow
                      ? (state.price.isNotEmpty ? '\$${state.price}' : '\$1,500')
                      : (state.startingBid.isNotEmpty
                          ? '\$${state.startingBid}'
                          : '\$1,500');
                  final listingTitle = isBuyNow ? 'Buy Now' : 'Auction';
                  final artistText = state.artist.isNotEmpty
                      ? state.artist
                      : 'Simone Albers';
                  final yearText =
                      state.year.isNotEmpty ? state.year : '2024';
                  final catText = state.category ?? 'Oil on Canvas';
                  final widthText =
                      state.width.isNotEmpty ? state.width : '60';
                  final heightText =
                      state.height.isNotEmpty ? state.height : '80';
                  final metaText =
                      '$yearText · $catText · $widthText × $heightText cm';

                  return ListView(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    children: [
                      // ── Preview ──────────────────────────────────────
                      Text(
                        'Preview',
                        style: KolekText.sans(
                          size: 16,
                          weight: FontWeight.w600,
                          color: fg,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: field,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: line),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Artwork photo with Edit pill
                            Stack(
                              children: [
                                SizedBox(
                                  height: 160,
                                  width: double.infinity,
                                  child: _buildArtworkImage(state.photos),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: GestureDetector(
                                    onTap: () => Navigator.of(context).pop(),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white
                                            .withValues(alpha: 0.95),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.edit_outlined,
                                            size: 13,
                                            color: Colors.black,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            'Edit',
                                            style: KolekText.sans(
                                              size: 12,
                                              weight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Details under the image
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        listingTitle,
                                        style: KolekText.mono(
                                          size: 15,
                                          weight: FontWeight.w700,
                                          color: fg,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        priceText,
                                        style: KolekText.sans(
                                          size: 15,
                                          weight: FontWeight.w700,
                                          color: fg,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    artistText,
                                    style: KolekText.mono(
                                      size: 12,
                                      weight: FontWeight.w400,
                                      color: muted,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    metaText,
                                    style: KolekText.mono(
                                      size: 12,
                                      weight: FontWeight.w400,
                                      color: muted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ── Description ──────────────────────────────────
                      Text(
                        'Description',
                        style: KolekText.sans(
                          size: 16,
                          weight: FontWeight.w600,
                          color: fg,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: field,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: line),
                        ),
                        child: Column(
                          children: [
                            TextField(
                              controller: _descCtrl,
                              minLines: 5,
                              maxLines: 6,
                              maxLength: 1000,
                              buildCounter: (_,
                                      {required currentLength,
                                      required isFocused,
                                      maxLength}) =>
                                  null,
                              onChanged: (v) => bloc
                                  .add(ListProductDescriptionChanged(v)),
                              style: KolekText.mono(
                                size: 13,
                                weight: FontWeight.w400,
                                height: 1.4,
                                color: fg,
                              ),
                              cursorColor: KolekColors.blue600,
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                hintText:
                                    'Tell the story behind your artwork...',
                                hintStyle: KolekText.mono(
                                  size: 13,
                                  weight: FontWeight.w400,
                                  color: muted,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: ValueListenableBuilder<TextEditingValue>(
                                valueListenable: _descCtrl,
                                builder: (context, val, _) => Text(
                                  '${val.text.length}/1000',
                                  style: KolekText.mono(
                                    size: 11,
                                    weight: FontWeight.w400,
                                    color: muted,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ── Additional Details ───────────────────────────
                      Text(
                        'Additional Details',
                        style: KolekText.sans(
                          size: 16,
                          weight: FontWeight.w600,
                          color: fg,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: field,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: line),
                        ),
                        child: Column(
                          children: [
                            // Framing
                            InkWell(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => BlocProvider.value(
                                    value: bloc,
                                    child: const FramingScreen(),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Framing',
                                      style: KolekText.sans(
                                        size: 14,
                                        weight: FontWeight.w500,
                                        color: fg,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      state.framing,
                                      style: KolekText.sans(
                                        size: 14,
                                        weight: FontWeight.w400,
                                        color: muted,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(
                                      Icons.chevron_right,
                                      size: 18,
                                      color: muted,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 1,
                              thickness: 1,
                              indent: 16,
                              endIndent: 16,
                              color: line,
                            ),
                            // Return Policy
                            InkWell(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => BlocProvider.value(
                                    value: bloc,
                                    child: const ReturnPolicyScreen(),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Return Policy',
                                      style: KolekText.sans(
                                        size: 14,
                                        weight: FontWeight.w500,
                                        color: fg,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      state.returnPolicy,
                                      style: KolekText.sans(
                                        size: 14,
                                        weight: FontWeight.w400,
                                        color: muted,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(
                                      Icons.chevron_right,
                                      size: 18,
                                      color: muted,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // ── Actions ──────────────────────────────────────
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: FilledButton(
                          onPressed: () {
                            bloc.add(const ListProductSubmitted());
                            Navigator.of(context).popUntil((r) => r.isFirst);
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: KolekColors.blue600,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            textStyle: KolekText.sans(
                              size: 16,
                              weight: FontWeight.w500,
                            ),
                          ),
                          child: const Text('Share Listing'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          bloc.add(const ListProductDraftSaved());
                          Navigator.of(context).popUntil((r) => r.isFirst);
                        },
                        behavior: HitTestBehavior.opaque,
                        child: SizedBox(
                          height: 40,
                          child: Center(
                            child: Text(
                              'Save as Draft',
                              style: KolekText.sans(
                                size: 15,
                                weight: FontWeight.w500,
                                color: muted,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArtworkImage(List<String> photos) {
    if (photos.isNotEmpty) {
      final path = photos.first;
      if (File(path).existsSync()) {
        return Image.file(
          File(path),
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _defaultArtworkImage(),
        );
      }
    }
    return _defaultArtworkImage();
  }

  Widget _defaultArtworkImage() {
    return Image.asset(
      'assets/images/list_product.png',
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Container(
        color: Colors.grey.shade300,
        alignment: Alignment.center,
        child: const Icon(Icons.image, size: 48, color: Colors.grey),
      ),
    );
  }
}
