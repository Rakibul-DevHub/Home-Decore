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
      backgroundColor: KolekColors.neutral50,
      appBar: AppBar(
        backgroundColor: KolekColors.neutral50,
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
            Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Row(
                children: [
                  Text('Price Range', style: KolekText.sans(size: 12)),
                  const Spacer(),
                  const Icon(Icons.remove, size: 18),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  '\$${FilterData.initialLowerPrice.toInt()}',
                  style: KolekText.mono(size: 10),
                ),
                const Spacer(),
                Text(
                  '\$${FilterData.maxPrice.toInt()}+',
                  style: KolekText.mono(size: 10),
                ),
              ],
            ),
            BlocBuilder<FilterCubit, FilterState>(
              builder: (context, state) => RangeSlider(
                values: RangeValues(state.lowerPrice, state.upperPrice),
                min: FilterData.minPrice,
                max: FilterData.maxPrice,
                activeColor: KolekColors.neutral900,
                inactiveColor: KolekColors.neutral300,
                onChanged: (value) => context.read<FilterCubit>().priceChanged(
                  value.start,
                  value.end,
                ),
              ),
            ),
            ...FilterData.sections.skip(1).map(_FilterRow.new),
          ],
        ),
      ),
      bottomSheet: SafeArea(
        top: false,
        child: Padding(
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
