import 'package:equatable/equatable.dart';

import '../data/filter_data.dart';
import '../data/shop_data.dart';

sealed class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object?> get props => [];
}

class FilterPriceChanged extends FilterEvent {
  const FilterPriceChanged(this.lower, this.upper);

  final double lower;
  final double upper;

  @override
  List<Object?> get props => [lower, upper];
}

class FilterListingTypeChanged extends FilterEvent {
  const FilterListingTypeChanged(this.type);

  final ShopListingType type;

  @override
  List<Object?> get props => [type];
}

class FilterCategoryChanged extends FilterEvent {
  const FilterCategoryChanged(this.category);

  final String category;

  @override
  List<Object?> get props => [category];
}

class FilterReset extends FilterEvent {
  const FilterReset();
}

class FilterInitialized extends FilterEvent {
  const FilterInitialized(this.filter);

  final ShopFilter filter;

  @override
  List<Object?> get props => [filter];
}

class FilterSectionToggled extends FilterEvent {
  const FilterSectionToggled(this.section);

  final FilterSection section;

  @override
  List<Object?> get props => [section];
}