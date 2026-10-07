/// Tab at the top of the Bids screen.
enum BidsMenuTab { myAuctions, myBids }

/// Lifecycle of an auction bid from the host's perspective.
enum BidStatus { active, waitingForPayment, completed }

class BidListing {
  const BidListing({
    required this.id,
    required this.thumbnail,
    required this.title,
    required this.artist,
    required this.listedAtPrice,
    required this.bidPrice,
    required this.status,
    required this.footerLabel,
    this.isWinningBid = true,
  });

  final String id;
  final String thumbnail;
  final String title;
  final String artist;

  /// "Listed at: $600"
  final int listedAtPrice;

  /// The highest / winning bid amount.
  final int bidPrice;

  final BidStatus status;

  /// Bottom muted line — "Expire in 18 h" or "Payment complete".
  final String footerLabel;

  /// When true, uses "Winning bid:"; otherwise "Highest bid:".
  /// Matches the design where the Active card says "Highest bid" and
  /// the later-stage cards say "Winning bid".
  final bool isWinningBid;

  BidsMenuTab get tab => BidsMenuTab.myAuctions;
}

abstract final class BidsMenuData {
  static const title = 'Bids';

  static const tabs = <({String label, BidsMenuTab value})>[
    (label: 'Auctions', value: BidsMenuTab.myAuctions),
    (label: 'Bids', value: BidsMenuTab.myBids),
  ];

  static const myAuctionsSectionHeader = 'My Hosted Auctions';
  static const myBidsSectionHeader = 'My Bids';

  static const emptyMessage = 'Nothing here yet';

  /// Human-readable status label.
  static String statusLabel(BidStatus s) => switch (s) {
    BidStatus.active => 'Active',
    BidStatus.waitingForPayment => 'Waiting for Payment',
    BidStatus.completed => 'Completed',
  };

  // ── Sample listings (matches the design) ──────────────────────────
  static const auctions = <BidListing>[
    BidListing(
      id: 'b1',
      thumbnail: 'assets/images/img1.png',
      title: 'Untitled No. 8',
      artist: 'Maya Chen',
      listedAtPrice: 600,
      bidPrice: 725,
      status: BidStatus.active,
      footerLabel: 'Expire in 18 h',
      isWinningBid: false,
    ),
    BidListing(
      id: 'b2',
      thumbnail: 'assets/images/img1.png',
      title: 'Untitled No. 8',
      artist: 'Maya Chen',
      listedAtPrice: 600,
      bidPrice: 725,
      status: BidStatus.waitingForPayment,
      footerLabel: 'Expire in 18 h',
    ),
    BidListing(
      id: 'b3',
      thumbnail: 'assets/images/img1.png',
      title: 'Untitled No. 8',
      artist: 'Maya Chen',
      listedAtPrice: 600,
      bidPrice: 725,
      status: BidStatus.completed,
      footerLabel: 'Payment complete',
    ),
  ];

  static const myBids = <BidListing>[];
}