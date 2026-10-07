// abstract final class FilterData {
//   static const minPrice = 0.0;
//   static const maxPrice = 5000.0;
//   static const initialLowerPrice = 0.0;
//   static const initialUpperPrice = 5000.0;
//   static const resultCount = 12;
//   static const sections = [
//     'Category',
//     'Artist',
//     'Medium',
//     'Color',
//     'Size',
//     'Availability',
//   ];
// }







/// Identifies each collapsible section on the filter screen.
enum FilterSection { price, listing, category }

class FilterCategory {
  const FilterCategory({required this.label, required this.asset});

  final String label;

  /// Null for the "All" chip — no thumbnail, just the checkmark when
  /// selected.
  final String? asset;
}

abstract final class FilterData {
  static const minPrice = 0.0;
  static const maxPrice = 5000.0;
  static const initialLowerPrice = 0.0;
  static const initialUpperPrice = 5000.0;

  static const categories = <FilterCategory>[
    FilterCategory(label: 'All', asset: null),
    FilterCategory(
      label: 'Printing',
      asset: 'assets/images/filter_printing.png',
    ),
    FilterCategory(
      label: 'Photography',
      asset: 'assets/images/filter_photography.png',
    ),
    FilterCategory(
      label: 'Sculpture',
      asset: 'assets/images/filter_sculpture.png',
    ),
    FilterCategory(
      label: 'Drawing',
      asset: 'assets/images/filter_drawing.png',
    ),
    FilterCategory(
      label: 'Print',
      asset: 'assets/images/filter_print.png',
    ),
    FilterCategory(
      label: 'Mixed Media',
      asset: 'assets/images/filter_mixed_media.png',
    ),
    FilterCategory(
      label: 'Digital Art',
      asset: 'assets/images/filter_digital_art.png',
    ),
    FilterCategory(
      label: 'Other',
      asset: 'assets/images/filter_other.png',
    ),
  ];
}