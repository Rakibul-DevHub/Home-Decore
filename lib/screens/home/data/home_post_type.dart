enum HomePostType {
  normal,
  sell,
  auction;

  String? get commerceIcon => switch (this) {
    HomePostType.sell => 'assets/icons/cart.svg',
    HomePostType.auction => 'assets/icons/auction.svg',
    HomePostType.normal => null,
  };

  bool get opensProduct => this == HomePostType.sell;
}
