/// Tab at the top of the Selling screen.
enum SellingTab { active, sold, drafts }

/// The visual shape of a listing card. Each shape renders a slightly
/// different set of rows — see `_ListingCard` in the screen file.
enum SellingListingShape {
  activeForSale,    // price + "Active" pill + listed date
  activeAuction,    // current bid + N bids + time left
  soldReadyToShip,  // "Sold for X" + "Ready to Ship" pill + listed date
  soldDelivered,    // "Sold for X" + "Delivered" pill + sold date
  draft,            // unfinished listing
}

/// Actions available from the ⋯ menu on each card.
enum SellingMenuAction { edit, share, delete }

class SellingListing {
  const SellingListing({
    required this.id,
    required this.thumbnail,
    required this.title,
    required this.shape,
    required this.kindLabel,
    required this.priceLine,
    this.statusLabel,
    this.bidsLabel,
    this.timeLeftLabel,
    this.metaLabel,
  });

  final String id;
  final String thumbnail;
  final String title;
  final SellingListingShape shape;

  /// "For Sale" or "Auction" — shown directly under the title.
  final String kindLabel;

  /// Main price line. Varies by shape:
  ///   active for-sale → "$850"
  ///   auction         → "Current Bid: $850"
  ///   sold            → "Sold for $850"
  final String priceLine;

  /// Pill label — "Active", "Ready to Ship", "Delivered", "Draft".
  /// Null for auctions.
  final String? statusLabel;

  /// "8 bids" — auctions only.
  final String? bidsLabel;

  /// "12h 34m left" — auctions only.
  final String? timeLeftLabel;

  /// Bottom muted line — "Listed 3 days ago", "Sold 8 days ago".
  final String? metaLabel;

  /// Which tab this listing appears under.
  SellingTab get tab => switch (shape) {
    SellingListingShape.activeForSale ||
    SellingListingShape.activeAuction =>
    SellingTab.active,
    SellingListingShape.soldReadyToShip ||
    SellingListingShape.soldDelivered =>
    SellingTab.sold,
    SellingListingShape.draft => SellingTab.drafts,
  };
}

abstract final class SellingData {
  static const title = 'Selling';

  static const tabs = <({String label, SellingTab value})>[
    (label: 'Active', value: SellingTab.active),
    (label: 'Sold', value: SellingTab.sold),
    (label: 'Drafts', value: SellingTab.drafts),
  ];

  // ── Promo card copy ────────────────────────────────────────────────
  static const promoTitle = 'Want to list something new?';
  static const promoBody =
      'List artwork and products for the Kolek\ncommunity to discover.';
  static const promoButton = 'List an Item';

  // ── Sample listings (matches the design) ──────────────────────────
  static const listings = <SellingListing>[
    SellingListing(
      id: 'l1',
      thumbnail: 'assets/images/img1.png',
      title: 'Blue Study No. 4',
      shape: SellingListingShape.activeForSale,
      kindLabel: 'For Sale',
      priceLine: '\$850',
      statusLabel: 'Active',
      metaLabel: 'Listed 3 days ago',
    ),
    SellingListing(
      id: 'l2',
      thumbnail: 'assets/images/img2.png',
      title: 'Untitled No. 8',
      shape: SellingListingShape.activeAuction,
      kindLabel: 'Auction',
      priceLine: 'Current Bid: \$850',
      bidsLabel: '8 bids',
      timeLeftLabel: '12h 34m left',
    ),
    SellingListing(
      id: 'l3',
      thumbnail: 'assets/images/img3.png',
      title: 'Sunday Morning',
      shape: SellingListingShape.soldReadyToShip,
      kindLabel: 'For Sale',
      priceLine: 'Sold for \$850',
      statusLabel: 'Ready to Ship',
      metaLabel: 'Listed 3 days ago',
    ),
    SellingListing(
      id: 'l4',
      thumbnail: 'assets/images/img4.png',
      title: 'Blue Study No. 4',
      shape: SellingListingShape.soldDelivered,
      kindLabel: 'For Sale',
      priceLine: 'Sold for \$950',
      statusLabel: 'Delivered',
      metaLabel: 'Sold 8 days ago',
    ),
  ];
}