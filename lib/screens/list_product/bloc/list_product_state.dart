/**
import 'package:equatable/equatable.dart';
import '../data/list_product_data.dart';

final class ListProductState extends Equatable {
  const ListProductState({
    this.photos = const <String>[],
    this.title = '',
    this.artist = '',
    this.year = '',
    this.category,
    this.width = '',
    this.height = '',
    this.submitting = false,
  });

  final List<String> photos;
  final String title;
  final String artist;
  final String year;
  final String? category;
  final String width;
  final String height;
  final bool submitting;

  int get photoCount => photos.length;
  bool get canAddPhoto => photos.length < ListProductData.maxPhotos;

  bool get isTitleValid => title.trim().isNotEmpty;
  bool get isArtistValid => artist.trim().isNotEmpty;
  bool get isYearValid => year.trim().isNotEmpty;
  bool get isCategoryValid => category != null && category!.trim().isNotEmpty;

  /// The bare minimum required to move forward.
  bool get canProceed =>
      isTitleValid && isArtistValid && isYearValid && isCategoryValid;

  ListProductState copyWith({
    List<String>? photos,
    String? title,
    String? artist,
    String? year,
    String? category,
    String? width,
    String? height,
    bool? submitting,
  }) {
    return ListProductState(
      photos: photos ?? this.photos,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      year: year ?? this.year,
      category: category ?? this.category,
      width: width ?? this.width,
      height: height ?? this.height,
      submitting: submitting ?? this.submitting,
    );
  }

  @override
  List<Object?> get props => [
    photos,
    title,
    artist,
    year,
    category,
    width,
    height,
    submitting,
  ];
}*/

















import 'package:equatable/equatable.dart';

import '../data/list_product_data.dart';
import '../data/pricing_data.dart';

final class ListProductState extends Equatable {
  const ListProductState({
    // Form
    this.photos = const <String>[],
    this.title = '',
    this.artist = '',
    this.year = '',
    this.category,
    this.width = '',
    this.height = '',
    // Pricing
    this.listingKind = ListingKind.buyNow,
    this.price = '',
    this.currency = PricingData.defaultCurrency,
    this.paymentMethod,
    // Meta
    this.submitting = false,
  });

  // ── Form ───────────────────────────────────────────────────────────
  final List<String> photos;
  final String title;
  final String artist;
  final String year;
  final String? category;
  final String width;
  final String height;

  // ── Pricing ────────────────────────────────────────────────────────
  final ListingKind listingKind;
  final String price;
  final String currency;
  final PaymentMethod? paymentMethod;

  final bool submitting;

  // ── Derived ────────────────────────────────────────────────────────
  int get photoCount => photos.length;
  bool get canAddPhoto => photos.length < ListProductData.maxPhotos;

  bool get isTitleValid => title.trim().isNotEmpty;
  bool get isArtistValid => artist.trim().isNotEmpty;
  bool get isYearValid => year.trim().isNotEmpty;
  bool get isCategoryValid => category != null && category!.trim().isNotEmpty;

  bool get isPriceValid => price.trim().isNotEmpty;
  bool get isPaymentValid => paymentMethod != null;

  bool get canProceed =>
      isTitleValid &&
          isArtistValid &&
          isYearValid &&
          isCategoryValid;

  bool get canSubmitPricing =>
      isPriceValid && isPaymentValid;

  ListProductState copyWith({
    List<String>? photos,
    String? title,
    String? artist,
    String? year,
    String? category,
    String? width,
    String? height,
    ListingKind? listingKind,
    String? price,
    String? currency,
    PaymentMethod? paymentMethod,
    bool? submitting,
  }) {
    return ListProductState(
      photos: photos ?? this.photos,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      year: year ?? this.year,
      category: category ?? this.category,
      width: width ?? this.width,
      height: height ?? this.height,
      listingKind: listingKind ?? this.listingKind,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      submitting: submitting ?? this.submitting,
    );
  }

  @override
  List<Object?> get props => [
    photos,
    title,
    artist,
    year,
    category,
    width,
    height,
    listingKind,
    price,
    currency,
    paymentMethod,
    submitting,
  ];
}