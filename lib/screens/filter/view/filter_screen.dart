import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../cubit/filter_cubit.dart';
import '../data/filter_data.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        leadingWidth: 80,
        leading: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('CLOSE', style: KolekText.mono(size: 10)),
        ),
        actions: [
          TextButton(
            onPressed: context.read<FilterCubit>().reset,
            child: Text('RESET', style: KolekText.mono(size: 10)),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 86),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter',
              style: KolekText.sans(
                size: 50,
                weight: FontWeight.w700,
                height: 1,
              ),
            ),
            const SizedBox(height: 22),
            _FilterRow(FilterData.sections.first),
            BlocBuilder<FilterCubit, FilterState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: context.read<FilterCubit>().togglePriceExpanded,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 14, bottom: 8),
                        child: Row(
                          children: [
                            Text('Price Range', style: KolekText.sans(size: 12)),
                            const Spacer(),
                            Icon(
                              state.priceExpanded ? Icons.remove : Icons.add,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (state.priceExpanded) ...[
                      Row(
                        children: [
                          Text(
                            state.lowerLabel,
                            style: KolekText.mono(
                              size: 10,
                              color: KolekColors.neutral600,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            state.upperLabel,
                            style: KolekText.mono(
                              size: 10,
                              color: KolekColors.neutral600,
                            ),
                          ),
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 2.5,
                          activeTrackColor: KolekColors.neutral900,
                          inactiveTrackColor: KolekColors.neutral300,
                          thumbColor: KolekColors.neutral200,
                          overlayColor: Colors.transparent,
                          overlayShape: SliderComponentShape.noOverlay,
                          rangeThumbShape: const _OutlinedRangeSliderThumb(
                            radius: 8,
                            fillColor: KolekColors.neutral200,
                            borderColor: KolekColors.neutral900,
                          ),
                          rangeTrackShape:
                              const RoundedRectRangeSliderTrackShape(),
                          showValueIndicator: ShowValueIndicator.never,
                        ),
                        child: RangeSlider(
                          values: RangeValues(
                            state.lowerPrice,
                            state.upperPrice,
                          ),
                          min: FilterData.minPrice,
                          max: FilterData.maxPrice,
                          divisions: 100,
                          onChanged: (value) {
                            context.read<FilterCubit>().priceChanged(
                              value.start,
                              value.end,
                            );
                          },
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
            ...FilterData.sections.skip(1).map(_FilterRow.new),
          ],
        ),
      ),
      bottomSheet: SafeArea(
        top: false,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(18),
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              style: FilledButton.styleFrom(
                shape: const RoundedRectangleBorder(),
                backgroundColor: KolekColors.blue600,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'View Result',
                    style: KolekText.sans(size: 12, color: Colors.white),
                  ),
                  const Spacer(),
                  Text(
                    '${FilterData.resultCount}',
                    style: KolekText.mono(size: 11, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  const _FilterRow(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: KolekColors.neutral200)),
      ),
      child: Row(
        children: [
          Text(label, style: KolekText.sans(size: 12)),
          const Spacer(),
          const Icon(Icons.add, size: 19),
        ],
      ),
    );
  }
}

/// Light-gray thumb with black outline; no press overlay.
class _OutlinedRangeSliderThumb extends RangeSliderThumbShape {
  const _OutlinedRangeSliderThumb({
    required this.radius,
    required this.fillColor,
    required this.borderColor,
  });

  final double radius;
  final Color fillColor;
  final Color borderColor;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(radius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool? isDiscrete,
    bool? isEnabled,
    bool? isOnTop,
    TextDirection? textDirection,
    required SliderThemeData sliderTheme,
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
        ..strokeWidth = 2,
    );
  }
}
