/// Which listing model the seller chose.
enum ListingKind { buyNow, auction }

/// Which payment method the seller accepts.
enum PaymentMethod { debit, credit }

abstract final class PricingData {
  static const appBarTitle = 'List a Product';
  static const nextLabel = 'Next';

  // ── Listing Type ───────────────────────────────────────────────────
  static const listingTypeLabel = 'Listing Type';
  static const buyNowTitle = 'Buy Now';
  static const buyNowSubtitle = 'List your artwork at a fixed price.';
  static const auctionTitle = 'Auction';
  static const auctionSubtitle = 'Let collectors bid on your artwork.';

  // ── Price ──────────────────────────────────────────────────────────
  static const priceLabel = 'Price';
  static const currencyOptions = ['USD', 'EUR', 'GBP', 'BDT'];
  static const defaultCurrency = 'USD';
  static const priceHint = 'e.g. 1,500';
  static const priceSuffix = '.00';

  // ── Shipping ───────────────────────────────────────────────────────
  static const shippingLabel = 'Shipping';
  static const shipsFromTitle = 'Ships from';
  static const shipsFromValue = 'Los Angeles, CA, USA';
  static const shippingOptionsTitle = 'Shipping Options';
  static const shippingOptionsValue = 'Domestic & International';

  // ── Payment ────────────────────────────────────────────────────────
  static const paymentLabel = 'Payment Options';
  static const debitCardLabel = 'Debit card';
  static const creditCardLabel = 'Credit Card';

  // ── Security note ──────────────────────────────────────────────────
  static const securePrefix = 'All payments are securely processed\nthrough ';
  static const secureBrand = 'kolek';
  static const secureSuffix = '. You\'re protected.';
}