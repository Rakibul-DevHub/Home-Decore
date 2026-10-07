import 'package:equatable/equatable.dart';

import '../data/filter_data.dart';
import '../data/shop_data.dart';

class FilterState extends Equatable {
  const FilterState({
    required this.lowerPrice,
    required this.upperPrice,
    required this.listingType,
    required this.category,
    required this.expandedSections,
  });

  final double lowerPrice;
  final double upperPrice;
  final ShopListingType listingType;
  final String category;

  /// Sections currently open on the screen. Collapsed when a section is
  /// missing from the set.
  final Set<FilterSection> expandedSections;

  static const initial = FilterState(
    lowerPrice: FilterData.initialLowerPrice,
    upperPrice: FilterData.initialUpperPrice,
    listingType: ShopListingType.all,
    category: 'All',
    expandedSections: {
      FilterSection.price,
      FilterSection.listing,
      FilterSection.category,
    },
  );

  bool isExpanded(FilterSection section) =>
      expandedSections.contains(section);

  /// Snapshot of the current draft, ready to send to [ShopBloc].
  ShopFilter toFilter() => ShopFilter(
    lowerPrice: lowerPrice,
    upperPrice: upperPrice,
    listingType: listingType,
    category: category,
  );

  String get lowerLabel => '\$${lowerPrice.round()}';

  String get upperLabel {
    final value = upperPrice.round();
    return value >= FilterData.maxPrice ? '\$$value+' : '\$$value';
  }

  FilterState copyWith({
    double? lowerPrice,
    double? upperPrice,
    ShopListingType? listingType,
    String? category,
    Set<FilterSection>? expandedSections,
  }) =>
      FilterState(
        lowerPrice: lowerPrice ?? this.lowerPrice,
        upperPrice: upperPrice ?? this.upperPrice,
        listingType: listingType ?? this.listingType,
        category: category ?? this.category,
        expandedSections: expandedSections ?? this.expandedSections,
      );

  @override
  List<Object> get props =>
      [lowerPrice, upperPrice, listingType, category, expandedSections];
}