// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../theme/kolek_colors.dart';
// import '../../../widgets/kolek_widgets.dart';
// import '../cubit/filter_cubit.dart';
// import '../../shop/data/filter_data.dart';
//
// class FilterScreen extends StatelessWidget {
//   const FilterScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         scrolledUnderElevation: 0,
//         leadingWidth: 80,
//         leading: TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: Text('CLOSE', style: KolekText.mono(size: 16)),
//         ),
//         actions: [
//           TextButton(
//             onPressed: context.read<FilterCubit>().reset,
//             child: Text('RESET', style: KolekText.mono(size: 16)),
//           ),
//           const SizedBox(width: 8),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.fromLTRB(18, 8, 18, 86),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Filter',
//               style: const TextStyle(
//                 fontFamily: 'GeneralSans-Semibold',
//                 fontSize: 50,
//                 fontWeight: FontWeight.w600,
//                 color: KolekColors.neutral900,
//               ),
//             ),
//             const SizedBox(height: 22),
//             _FilterRow(
//               FilterData.sections.first,
//               style: const TextStyle(
//                 fontFamily: 'GeneralSans-Medium',
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 height: 1.0,
//                 letterSpacing: 0,
//                 color: KolekColors.neutral900,
//               ),
//             ),
//             BlocBuilder<FilterCubit, FilterState>(
//               builder: (context, state) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     InkWell(
//                       onTap: context.read<FilterCubit>().togglePriceExpanded,
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 14, bottom: 8),
//                         child: Row(
//                           children: [
//                             Text('Price Range', style: KolekText.sans(size: 12)),
//                             const Spacer(),
//                             Icon(
//                               state.priceExpanded ? Icons.remove : Icons.add,
//                               size: 18,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     if (state.priceExpanded) ...[
//                       Row(
//                         children: [
//                           Text(
//                             state.lowerLabel,
//                             style: KolekText.mono(
//                               size: 10,
//                               color: KolekColors.neutral600,
//                             ),
//                           ),
//                           const Spacer(),
//                           Text(
//                             state.upperLabel,
//                             style: KolekText.mono(
//                               size: 10,
//                               color: KolekColors.neutral600,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SliderTheme(
//                         data: SliderTheme.of(context).copyWith(
//                           trackHeight: 2.5,
//                           activeTrackColor: KolekColors.neutral900,
//                           inactiveTrackColor: KolekColors.neutral300,
//                           thumbColor: KolekColors.neutral200,
//                           overlayColor: Colors.transparent,
//                           overlayShape: SliderComponentShape.noOverlay,
//                           rangeThumbShape: const _OutlinedRangeSliderThumb(
//                             radius: 8,
//                             fillColor: KolekColors.neutral200,
//                             borderColor: KolekColors.neutral900,
//                           ),
//                           rangeTrackShape:
//                               const RoundedRectRangeSliderTrackShape(),
//                           showValueIndicator: ShowValueIndicator.never,
//                         ),
//                         child: RangeSlider(
//                           values: RangeValues(
//                             state.lowerPrice,
//                             state.upperPrice,
//                           ),
//                           min: FilterData.minPrice,
//                           max: FilterData.maxPrice,
//                           divisions: 100,
//                           onChanged: (value) {
//                             context.read<FilterCubit>().priceChanged(
//                               value.start,
//                               value.end,
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ],
//                 );
//               },
//             ),
//             ...FilterData.sections.skip(1).map(_FilterRow.new),
//           ],
//         ),
//       ),
//       bottomSheet: SafeArea(
//         top: false,
//         child: Container(
//           color: Colors.white,
//           padding: const EdgeInsets.all(18),
//           child: SizedBox(
//             width: double.infinity,
//             height: 48,
//             child: FilledButton(
//               onPressed: () => Navigator.of(context).pop(),
//               style: FilledButton.styleFrom(
//                 shape: const RoundedRectangleBorder(),
//                 backgroundColor: KolekColors.blue600,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'View Result',
//                     style: KolekText.sans(size: 12, color: Colors.white),
//                   ),
//                   const Spacer(),
//                   Text(
//                     '${FilterData.resultCount}',
//                     style: KolekText.mono(size: 11, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _FilterRow extends StatelessWidget {
//   const _FilterRow(this.label, {this.style});
//
//   final String label;
//   final TextStyle? style;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 57,
//       decoration: const BoxDecoration(
//         border: Border(bottom: BorderSide(color: KolekColors.neutral200)),
//       ),
//       child: Row(
//         children: [
//           Text(
//             label,
//             style: style ??
//                 const TextStyle(
//                   fontFamily: 'GeneralSans-Regular',
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                   color: KolekColors.neutral900,
//                 ),
//           ),
//           const Spacer(),
//           const Icon(Icons.add, size: 19),
//         ],
//       ),
//     );
//   }
// }
//
// /// Light-gray thumb with black outline; no press overlay.
// class _OutlinedRangeSliderThumb extends RangeSliderThumbShape {
//   const _OutlinedRangeSliderThumb({
//     required this.radius,
//     required this.fillColor,
//     required this.borderColor,
//   });
//
//   final double radius;
//   final Color fillColor;
//   final Color borderColor;
//
//   @override
//   Size getPreferredSize(bool isEnabled, bool isDiscrete) {
//     return Size.fromRadius(radius);
//   }
//
//   @override
//   void paint(
//     PaintingContext context,
//     Offset center, {
//     required Animation<double> activationAnimation,
//     required Animation<double> enableAnimation,
//     bool? isDiscrete,
//     bool? isEnabled,
//     bool? isOnTop,
//     TextDirection? textDirection,
//     required SliderThemeData sliderTheme,
//     Thumb? thumb,
//     bool? isPressed,
//   }) {
//     final canvas = context.canvas;
//     canvas.drawCircle(center, radius, Paint()..color = fillColor);
//     canvas.drawCircle(
//       center,
//       radius,
//       Paint()
//         ..color = borderColor
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 2,
//     );
//   }
// }






import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../bloc/filter_bloc.dart';
import '../bloc/shop_bloc.dart';
import '../data/filter_data.dart';
import '../data/shop_data.dart';
import '../bloc/filter_event.dart';
import '../bloc/filter_state.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  static const _accent = KolekColors.blue600;

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);
    final muted = AppearancePage.muted(context);
    final line = AppearancePage.line(context);

    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: Column(
          children: [
            // ── Top action bar ──────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _TopAction(
                    label: 'CLOSE',
                    color: fg,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  _TopAction(
                    label: 'RESET',
                    color: muted,
                    onTap: () => context
                        .read<FilterBloc>()
                        .add(const FilterReset()),
                  ),
                ],
              ),
            ),

            // ── Scrollable content ──────────────────────────────────
            Expanded(
              child: BlocBuilder<FilterBloc, FilterState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Filter',
                          style: TextStyle(
                            fontFamily: 'GeneralSans-Semibold',
                            fontSize: 56,
                            fontWeight: FontWeight.w700,
                            height: 1,
                            letterSpacing: -1,
                            color: fg,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // ── Price Range ─────────────────────────
                        _SectionHeader(title: 'Price Range', color: fg),
                        const SizedBox(height: 20),
                        _PriceLabels(
                          lower: state.lowerPrice,
                          upper: state.upperPrice,
                          color: fg,
                        ),
                        const SizedBox(height: 6),
                        _PriceSlider(
                          lower: state.lowerPrice,
                          upper: state.upperPrice,
                          fg: fg,
                          onChanged: (v) => context
                              .read<FilterBloc>()
                              .add(FilterPriceChanged(v.start, v.end)),
                        ),
                        const SizedBox(height: 28),

                        // ── Listing Type ────────────────────────
                        _SectionHeader(title: 'Listing Type', color: fg),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(
                              child: _ListingTypeButton(
                                label: 'Purchase',
                                icon: Icon(
                                  Icons.shopping_bag_outlined,
                                  size: 18,
                                  color: fg,
                                ),
                                selected: state.listingType ==
                                    ShopListingType.purchase,
                                fg: fg,
                                borderColor: line,
                                onTap: () => context.read<FilterBloc>().add(
                                  const FilterListingTypeChanged(
                                    ShopListingType.purchase,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _ListingTypeButton(
                                label: 'Auction',
                                icon: SvgPicture.asset(
                                  'assets/icons/auction.svg',
                                  width: 18,
                                  height: 18,
                                  colorFilter: ColorFilter.mode(
                                    fg,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                selected: state.listingType ==
                                    ShopListingType.auction,
                                fg: fg,
                                borderColor: line,
                                onTap: () => context.read<FilterBloc>().add(
                                  const FilterListingTypeChanged(
                                    ShopListingType.auction,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),

                        // ── Category ────────────────────────────
                        _SectionHeader(title: 'Category', color: fg),
                        const SizedBox(height: 14),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            const gap = 10.0;
                            final chipWidth =
                                (constraints.maxWidth - gap) / 2;
                            return Wrap(
                              spacing: gap,
                              runSpacing: gap,
                              children: [
                                for (final item in FilterData.categories)
                                  SizedBox(
                                    width: chipWidth,
                                    child: _CategoryChip(
                                      item: item,
                                      selected:
                                      state.category == item.label,
                                      fg: fg,
                                      borderColor: line,
                                      onTap: () => context
                                          .read<FilterBloc>()
                                          .add(
                                        FilterCategoryChanged(
                                          item.label,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // ── View Result button ──────────────────────────────────
            BlocBuilder<FilterBloc, FilterState>(
              builder: (context, state) {
                final count = ShopData.countMatching(state.toFilter());
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      onPressed: () {
                        // Push the draft filter to ShopBloc, then close.
                        context.read<ShopBloc>().add(
                          ShopFilterApplied(state.toFilter()),
                        );
                        Navigator.of(context).pop();
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: _accent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'View Result',
                              style: TextStyle(
                                fontFamily: 'GeneralSans-Medium',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '$count',
                              style: const TextStyle(
                                fontFamily: 'GeneralSans-Medium',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Components
// ─────────────────────────────────────────────────────────────────────────

class _TopAction extends StatelessWidget {
  const _TopAction({
    required this.label,
    required this.color,
    required this.onTap,
  });

  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'IBMPlexMono-Regular',
            fontSize: 13,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
            color: color,
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.color});

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'IBMPlexMono-Regular',
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
        Container(width: 22, height: 1.5, color: color),
      ],
    );
  }
}

class _PriceLabels extends StatelessWidget {
  const _PriceLabels({
    required this.lower,
    required this.upper,
    required this.color,
  });

  final double lower;
  final double upper;
  final Color color;

  String _fmtLower(double value) => '\$${value.round()}';

  String _fmtUpper(double value) {
    final rounded = value.round();
    return rounded >= FilterData.maxPrice ? '\$$rounded+' : '\$$rounded';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(_fmtLower(lower), style: _style),
        Text(_fmtUpper(upper), style: _style),
      ],
    );
  }

  TextStyle get _style => TextStyle(
    fontFamily: 'IBMPlexMono-Regular',
    fontSize: 14,
    color: color,
  );
}

class _PriceSlider extends StatelessWidget {
  const _PriceSlider({
    required this.lower,
    required this.upper,
    required this.fg,
    required this.onChanged,
  });

  final double lower;
  final double upper;
  final Color fg;
  final ValueChanged<RangeValues> onChanged;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 2,
        activeTrackColor: fg,
        inactiveTrackColor: fg,
        rangeThumbShape: _RingRangeThumbShape(
          radius: 11,
          fillColor: AppearancePage.background(context),
          borderColor: fg,
        ),
        overlayShape: SliderComponentShape.noOverlay,
        showValueIndicator: ShowValueIndicator.never,
      ),
      child: RangeSlider(
        values: RangeValues(lower, upper),
        min: FilterData.minPrice,
        max: FilterData.maxPrice,
        onChanged: onChanged,
      ),
    );
  }
}

class _RingRangeThumbShape extends RangeSliderThumbShape {
  const _RingRangeThumbShape({
    required this.radius,
    required this.fillColor,
    required this.borderColor,
  });

  final double radius;
  final Color fillColor;
  final Color borderColor;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      Size.fromRadius(radius);

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        bool isDiscrete = false,
        bool isEnabled = false,
        bool? isOnTop,
        required SliderThemeData sliderTheme,
        TextDirection? textDirection,
        Thumb? thumb,
        bool? isPressed,
      }) {
    final canvas = context.canvas;
    canvas.drawCircle(center, radius, Paint()..color = fillColor);
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
  }
}

class _ListingTypeButton extends StatelessWidget {
  const _ListingTypeButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.fg,
    required this.borderColor,
    required this.onTap,
  });

  final String label;
  final Widget icon;
  final bool selected;
  final Color fg;
  final Color borderColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: selected
              ? FilterScreen._accent.withValues(alpha: 0.08)
              : null,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? FilterScreen._accent : borderColor,
            width: selected ? 1.2 : 1,
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: 18, height: 18, child: icon),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'GeneralSans-Medium',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: fg,
                ),
              ),
            ),
            if (selected)
              const Icon(
                Icons.check_circle,
                color: FilterScreen._accent,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.item,
    required this.selected,
    required this.fg,
    required this.borderColor,
    required this.onTap,
  });

  final FilterCategory item;
  final bool selected;
  final Color fg;
  final Color borderColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: selected
              ? FilterScreen._accent.withValues(alpha: 0.10)
              : null,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? FilterScreen._accent : borderColor,
            width: selected ? 1.2 : 1,
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: 24, height: 24, child: _leading()),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                item.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'GeneralSans-Medium',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: selected ? FilterScreen._accent : fg,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _leading() {
    if (selected) {
      return const Icon(
        Icons.check_circle,
        color: FilterScreen._accent,
        size: 22,
      );
    }
    if (item.asset == null) return const SizedBox.shrink();
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Image.asset(item.asset!, fit: BoxFit.cover),
    );
  }
}