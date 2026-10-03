import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/filter_data.dart';
import '../data/shop_data.dart';
import 'filter_event.dart';
import 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc({ShopFilter? initial})
      : super(
    initial == null
        ? FilterState.initial
        : FilterState(
      lowerPrice: initial.lowerPrice,
      upperPrice: initial.upperPrice,
      listingType: initial.listingType,
      category: initial.category,
      expandedSections: FilterState.initial.expandedSections,
    ),
  ) {
    on<FilterPriceChanged>(_onPriceChanged);
    on<FilterListingTypeChanged>(_onListingTypeChanged);
    on<FilterCategoryChanged>(_onCategoryChanged);
    on<FilterReset>(_onReset);
    on<FilterInitialized>(_onInitialized);
    on<FilterSectionToggled>(_onSectionToggled);
  }

  void _onPriceChanged(FilterPriceChanged event, Emitter<FilterState> emit) {
    emit(
      state.copyWith(
        lowerPrice:
        event.lower.clamp(FilterData.minPrice, FilterData.maxPrice),
        upperPrice:
        event.upper.clamp(FilterData.minPrice, FilterData.maxPrice),
      ),
    );
  }

  void _onListingTypeChanged(
      FilterListingTypeChanged event,
      Emitter<FilterState> emit,
      ) {
    emit(state.copyWith(listingType: event.type));
  }

  void _onCategoryChanged(
      FilterCategoryChanged event,
      Emitter<FilterState> emit,
      ) {
    emit(state.copyWith(category: event.category));
  }

  void _onReset(FilterReset event, Emitter<FilterState> emit) {
    emit(FilterState.initial);
  }

  void _onInitialized(FilterInitialized event, Emitter<FilterState> emit) {
    final f = event.filter;
    emit(
      FilterState(
        lowerPrice: f.lowerPrice,
        upperPrice: f.upperPrice,
        listingType: f.listingType,
        category: f.category,
        expandedSections: FilterState.initial.expandedSections,
      ),
    );
  }

  void _onSectionToggled(
      FilterSectionToggled event,
      Emitter<FilterState> emit,
      ) {
    // Copy into a new set so Equatable's props comparison sees the change.
    final next = Set<FilterSection>.from(state.expandedSections);
    if (!next.remove(event.section)) next.add(event.section);
    emit(state.copyWith(expandedSections: next));
  }
}