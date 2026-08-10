import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/filter_data.dart';

class FilterState extends Equatable {
  const FilterState({required this.lowerPrice, required this.upperPrice});

  final double lowerPrice;
  final double upperPrice;

  @override
  List<Object> get props => [lowerPrice, upperPrice];
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
    emit(FilterState(lowerPrice: lower, upperPrice: upper));
  }

  void reset() => emit(
    const FilterState(
      lowerPrice: FilterData.initialLowerPrice,
      upperPrice: FilterData.initialUpperPrice,
    ),
  );
}
