import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/filter_data.dart';

class FilterState extends Equatable {
  const FilterState({
    required this.lowerPrice,
    required this.upperPrice,
    this.priceExpanded = true,
  });

  final double lowerPrice;
  final double upperPrice;
  final bool priceExpanded;

  FilterState copyWith({
    double? lowerPrice,
    double? upperPrice,
    bool? priceExpanded,
  }) {
    return FilterState(
      lowerPrice: lowerPrice ?? this.lowerPrice,
      upperPrice: upperPrice ?? this.upperPrice,
      priceExpanded: priceExpanded ?? this.priceExpanded,
    );
  }

  String get lowerLabel => '\$${lowerPrice.round()}';

  String get upperLabel {
    final value = upperPrice.round();
    if (value >= FilterData.maxPrice) return '\$$value+';
    return '\$$value';
  }

  @override
  List<Object> get props => [lowerPrice, upperPrice, priceExpanded];
}

class FilterCubit extends Cubit<FilterState> {
  FilterCubit()
    : super(
        const FilterState(
          lowerPrice: FilterData.initialLowerPrice,
          upperPrice: FilterData.initialUpperPrice,
        ),
      );

  void priceChanged(double lower, double upper) {
    emit(
      state.copyWith(
        lowerPrice: lower.clamp(FilterData.minPrice, FilterData.maxPrice),
        upperPrice: upper.clamp(FilterData.minPrice, FilterData.maxPrice),
      ),
    );
  }

  void togglePriceExpanded() {
    emit(state.copyWith(priceExpanded: !state.priceExpanded));
  }

  void reset() => emit(
    const FilterState(
      lowerPrice: FilterData.initialLowerPrice,
      upperPrice: FilterData.initialUpperPrice,
    ),
  );
}
