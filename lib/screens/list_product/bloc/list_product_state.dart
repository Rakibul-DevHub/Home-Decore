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
    // Auction
    this.startingBid = '',
    this.reservePrice = '',
    this.bidIncrement = '',
    this.startDate = '',
    this.startTime = '',
    this.endDate = '',
    this.endTime = '',
    // Review / Details
    this.description = '',
    this.framing = 'Not Framed',
    this.returnPolicy = 'No Returns',
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

  // ── Auction ────────────────────────────────────────────────────────
  final String startingBid;
  final String reservePrice;
  final String bidIncrement;
  final String startDate;
  final String startTime;
  final String endDate;
  final String endTime;

  // ── Review / Details ───────────────────────────────────────────────
  final String description;
  final String framing;
  final String returnPolicy;

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

  bool get canSubmitPricing => switch (listingKind) {
    ListingKind.buyNow => isPriceValid,
    ListingKind.auction => startingBid.trim().isNotEmpty,
  };

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
    String? startingBid,
    String? reservePrice,
    String? bidIncrement,
    String? startDate,
    String? startTime,
    String? endDate,
    String? endTime,
    String? description,
    String? framing,
    String? returnPolicy,
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
      startingBid: startingBid ?? this.startingBid,
      reservePrice: reservePrice ?? this.reservePrice,
      bidIncrement: bidIncrement ?? this.bidIncrement,
      startDate: startDate ?? this.startDate,
      startTime: startTime ?? this.startTime,
      endDate: endDate ?? this.endDate,
      endTime: endTime ?? this.endTime,
      description: description ?? this.description,
      framing: framing ?? this.framing,
      returnPolicy: returnPolicy ?? this.returnPolicy,
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
    startingBid,
    reservePrice,
    bidIncrement,
    startDate,
    startTime,
    endDate,
    endTime,
    description,
    framing,
    returnPolicy,
    submitting,
  ];
}