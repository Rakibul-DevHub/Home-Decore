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
  static const buyNowSubtitle = 'List your artwork\nat a fixed price.';
  static const auctionTitle = 'Auction';
  static const auctionSubtitle = 'Let collectors bid\non your artwork.';
  static const buyNowIconAsset = 'assets/icons/dollar.svg';
  static const auctionIconAsset = 'assets/icons/auction_icon.svg';

  // ── Price ──────────────────────────────────────────────────────────
  static const priceLabel = 'Price';
  static const currencyOptions = ['USD', 'EUR', 'GBP', 'BDT'];
  static const defaultCurrency = 'USD';
  static const priceHint = 'e.g. 1,500';
  static const priceSuffix = '.00';

  // ── Auction Pricing ────────────────────────────────────────────────
  static const startingBidLabel = 'Starting Bid';
  static const reservePriceLabel = 'Reserve Price (Optional)';
  static const bidIncrementLabel = 'Bid Increment';
  static const bidIncrementHint = 'e.g. min 50';

  // ── Auction Dates ──────────────────────────────────────────────────
  static const startDateTimeLabel = 'Start date and time';
  static const endDateTimeLabel = 'End date and time';
  static const dateHint = 'MM-DD-YYYY';
  static const timeHint = '--:--';

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
  static const debitCardIconAsset = 'assets/icons/debit.svg';
  static const creditCardIconAsset = 'assets/icons/credit.svg';

  // ── Security note ──────────────────────────────────────────────────
  static const securePrefix = 'All payments are securely processed\nthrough ';
  static const secureBrand = 'kolek';
  static const secureSuffix = '. You\'re protected.';
}