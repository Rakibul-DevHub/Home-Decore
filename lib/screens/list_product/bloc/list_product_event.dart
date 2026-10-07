/**
import 'package:equatable/equatable.dart';

sealed class ListProductEvent extends Equatable {
  const ListProductEvent();

  @override
  List<Object?> get props => [];
}

/// User added a photo. [path] is the file path returned by the gallery
/// picker. When null, the bloc falls back to a sample asset (demo only).
final class ListProductPhotoAdded extends ListProductEvent {
  const ListProductPhotoAdded({this.path});

  final String? path;

  @override
  List<Object?> get props => [path];
}

/// User removed a photo from the row.
final class ListProductPhotoRemoved extends ListProductEvent {
  const ListProductPhotoRemoved(this.index);

  final int index;

  @override
  List<Object?> get props => [index];
}

final class ListProductTitleChanged extends ListProductEvent {
  const ListProductTitleChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

final class ListProductArtistChanged extends ListProductEvent {
  const ListProductArtistChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

final class ListProductYearChanged extends ListProductEvent {
  const ListProductYearChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

final class ListProductCategoryChanged extends ListProductEvent {
  const ListProductCategoryChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

final class ListProductWidthChanged extends ListProductEvent {
  const ListProductWidthChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

final class ListProductHeightChanged extends ListProductEvent {
  const ListProductHeightChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

/// User tapped Next.
final class ListProductSubmitted extends ListProductEvent {
  const ListProductSubmitted();
}

/// User tapped Save as Draft.
final class ListProductDraftSaved extends ListProductEvent {
  const ListProductDraftSaved();
}*/










import 'package:equatable/equatable.dart';

import '../data/pricing_data.dart';

sealed class ListProductEvent extends Equatable {
  const ListProductEvent();

  @override
  List<Object?> get props => [];
}

// ── Form events (unchanged) ──────────────────────────────────────────

final class ListProductPhotoAdded extends ListProductEvent {
  const ListProductPhotoAdded({this.path});
  final String? path;
  @override
  List<Object?> get props => [path];
}

final class ListProductPhotoRemoved extends ListProductEvent {
  const ListProductPhotoRemoved(this.index);
  final int index;
  @override
  List<Object?> get props => [index];
}

final class ListProductTitleChanged extends ListProductEvent {
  const ListProductTitleChanged(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

final class ListProductArtistChanged extends ListProductEvent {
  const ListProductArtistChanged(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

final class ListProductYearChanged extends ListProductEvent {
  const ListProductYearChanged(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

final class ListProductCategoryChanged extends ListProductEvent {
  const ListProductCategoryChanged(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

final class ListProductWidthChanged extends ListProductEvent {
  const ListProductWidthChanged(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

final class ListProductHeightChanged extends ListProductEvent {
  const ListProductHeightChanged(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

final class ListProductSubmitted extends ListProductEvent {
  const ListProductSubmitted();
}

final class ListProductDraftSaved extends ListProductEvent {
  const ListProductDraftSaved();
}

// ── Pricing events (new) ─────────────────────────────────────────────

final class ListProductListingKindChanged extends ListProductEvent {
  const ListProductListingKindChanged(this.kind);
  final ListingKind kind;
  @override
  List<Object?> get props => [kind];
}

final class ListProductPriceChanged extends ListProductEvent {
  const ListProductPriceChanged(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

final class ListProductCurrencyChanged extends ListProductEvent {
  const ListProductCurrencyChanged(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

final class ListProductPaymentMethodChanged extends ListProductEvent {
  const ListProductPaymentMethodChanged(this.method);
  final PaymentMethod method;
  @override
  List<Object?> get props => [method];
}

final class ListProductStartingBidChanged extends ListProductEvent {
  const ListProductStartingBidChanged(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

final class ListProductReservePriceChanged extends ListProductEvent {
  const ListProductReservePriceChanged(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

final class ListProductBidIncrementChanged extends ListProductEvent {
  const ListProductBidIncrementChanged(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

final class ListProductStartDateChanged extends ListProductEvent {
  const ListProductStartDateChanged(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

final class ListProductStartTimeChanged extends ListProductEvent {
  const ListProductStartTimeChanged(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

final class ListProductEndDateChanged extends ListProductEvent {
  const ListProductEndDateChanged(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

final class ListProductEndTimeChanged extends ListProductEvent {
  const ListProductEndTimeChanged(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

// ── Review & Details events ──────────────────────────────────────────

final class ListProductDescriptionChanged extends ListProductEvent {
  const ListProductDescriptionChanged(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

final class ListProductFramingChanged extends ListProductEvent {
  const ListProductFramingChanged(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}

final class ListProductReturnPolicyChanged extends ListProductEvent {
  const ListProductReturnPolicyChanged(this.value);
  final String value;
  @override
  List<Object?> get props => [value];
}