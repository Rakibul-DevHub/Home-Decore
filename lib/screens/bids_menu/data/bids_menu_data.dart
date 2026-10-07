// /// Tab at the top of the Bids screen.
// enum BidsMenuTab { myAuctions, myBids }
//
// /// Lifecycle of an auction bid from the host's perspective.
// enum BidStatus { active, waitingForPayment, completed }
//
// class BidListing {
//   const BidListing({
//     required this.id,
//     required this.thumbnail,
//     required this.title,
//     required this.artist,
//     required this.listedAtPrice,
//     required this.bidPrice,
//     required this.status,
//     required this.footerLabel,
//     this.isWinningBid = true,
//   });
//
//   final String id;
//   final String thumbnail;
//   final String title;
//   final String artist;
//
//   /// "Listed at: $600"
//   final int listedAtPrice;
//
//   /// The highest / winning bid amount.
//   final int bidPrice;
//
//   final BidStatus status;
//
//   /// Bottom muted line — "Expire in 18 h" or "Payment complete".
//   final String footerLabel;
//
//   /// When true, uses "Winning bid:"; otherwise "Highest bid:".
//   /// Matches the design where the Active card says "Highest bid" and
//   /// the later-stage cards say "Winning bid".
//   final bool isWinningBid;
//
//   BidsMenuTab get tab => BidsMenuTab.myAuctions;
// }
//
// abstract final class BidsMenuData {
//   static const title = 'Bids';
//
//   static const tabs = <({String label, BidsMenuTab value})>[
//     (label: 'Auctions', value: BidsMenuTab.myAuctions),
//     (label: 'Bids', value: BidsMenuTab.myBids),
//   ];
//
//   static const myAuctionsSectionHeader = 'My Hosted Auctions';
//   static const myBidsSectionHeader = 'My Bids';
//
//   static const emptyMessage = 'Nothing here yet';
//
//   /// Human-readable status label.
//   static String statusLabel(BidStatus s) => switch (s) {
//     BidStatus.active => 'Active',
//     BidStatus.waitingForPayment => 'Waiting for Payment',
//     BidStatus.completed => 'Completed',
//   };
//
//   // ── Sample listings (matches the design) ──────────────────────────
//   static const auctions = <BidListing>[
//     BidListing(
//       id: 'b1',
//       thumbnail: 'assets/images/img1.png',
//       title: 'Untitled No. 8',
//       artist: 'Maya Chen',
//       listedAtPrice: 600,
//       bidPrice: 725,
//       status: BidStatus.active,
//       footerLabel: 'Expire in 18 h',
//       isWinningBid: false,
//     ),
//     BidListing(
//       id: 'b2',
//       thumbnail: 'assets/images/img1.png',
//       title: 'Untitled No. 8',
//       artist: 'Maya Chen',
//       listedAtPrice: 600,
//       bidPrice: 725,
//       status: BidStatus.waitingForPayment,
//       footerLabel: 'Expire in 18 h',
//     ),
//     BidListing(
//       id: 'b3',
//       thumbnail: 'assets/images/img1.png',
//       title: 'Untitled No. 8',
//       artist: 'Maya Chen',
//       listedAtPrice: 600,
//       bidPrice: 725,
//       status: BidStatus.completed,
//       footerLabel: 'Payment complete',
//     ),
//   ];
//
//   static const myBids = <BidListing>[];
// }









/// Tab at the top of the Bids screen.
enum BidsMenuTab { myAuctions, myBids }

/// Lifecycle states across both roles — hosting auctions and placing bids.
enum BidStatus {
  // Host side (My Auctions)
  active,
  waitingForPayment,
  completed,
  // Bidder side (My Bids)
  highestBidder,
  countered,
  expired,
  won,
}

/// Visual style for the optional card action button.
enum BidActionStyle { dark, primary }

class BidListing {
  const BidListing({
    required this.id,
    required this.thumbnail,
    required this.title,
    required this.artist,
    required this.status,
    required this.footerLabel,
    // Auction-side rows (host)
    this.listedAtPrice,
    this.bidPrice,
    this.isWinningBid = true,
    // Bidder-side row (bidder)
    this.yourOffer,
    // Optional action button
    this.actionLabel,
    this.actionStyle,
  });

  final String id;
  final String thumbnail;
  final String title;
  final String artist;

  final BidStatus status;

  /// Bottom muted line. "Expire in 18 h" / "Payment complete" /
  /// "Time over" / "Pay with in 48 to confirm product."
  final String footerLabel;

  /// "Listed at: $600" — auction cards only.
  final int? listedAtPrice;

  /// Highest / winning bid amount — auction cards only.
  final int? bidPrice;

  /// When true, uses "Winning bid:"; otherwise "Highest bid:".
  final bool isWinningBid;

  /// "Your Offer: $725" — bidder cards only.
  final int? yourOffer;

  /// Optional action button label. "Counter" / "Pay Now".
  final String? actionLabel;

  /// Style for the action button.
  final BidActionStyle? actionStyle;
}

abstract final class BidsMenuData {
  static const title = 'Bids';

  static const tabs = <({String label, BidsMenuTab value})>[
    (label: 'My Auctions', value: BidsMenuTab.myAuctions),
    (label: 'My Bids', value: BidsMenuTab.myBids),
  ];

  static const myAuctionsSectionHeader = 'My Hosted Auctions';
  static const myBidsSectionHeader = "Auctions I'm Bidding On";

  static const emptyMessage = 'Nothing here yet';

  /// Human-readable status label.
  static String statusLabel(BidStatus s) => switch (s) {
    BidStatus.active => 'Active',
    BidStatus.waitingForPayment => 'Waiting for Payment',
    BidStatus.completed => 'Completed',
    BidStatus.highestBidder => 'You are still highest bidder',
    BidStatus.countered => 'Countered',
    BidStatus.expired => 'Expired',
    BidStatus.won => 'You are Auction Winner.',
  };

  // ── My Auctions (host) ────────────────────────────────────────────
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
      thumbnail: 'assets/images/img2.png',
      title: 'Untitled No. 8',
      artist: 'Maya Chen',
      listedAtPrice: 600,
      bidPrice: 725,
      status: BidStatus.waitingForPayment,
      footerLabel: 'Expire in 18 h',
    ),
    BidListing(
      id: 'b3',
      thumbnail: 'assets/images/img2.png',
      title: 'Untitled No. 8',
      artist: 'Maya Chen',
      listedAtPrice: 600,
      bidPrice: 725,
      status: BidStatus.completed,
      footerLabel: 'Payment complete',
    ),
  ];

  // ── My Bids (bidder) -------------------------
  static const myBids = <BidListing>[
    BidListing(
      id: 'mb1',
      thumbnail: 'assets/images/img1.png',
      title: 'Untitled No. 8',
      artist: 'Maya Chen',
      yourOffer: 725,
      status: BidStatus.highestBidder,
      footerLabel: 'Expire in 18 h',
    ),
    BidListing(
      id: 'mb2',
      thumbnail: 'assets/images/img2.png',
      title: 'Untitled No. 8',
      artist: 'Maya Chen',
      yourOffer: 725,
      status: BidStatus.countered,
      footerLabel: 'Expire in 18 h',
      actionLabel: 'Counter',
      actionStyle: BidActionStyle.dark,
    ),
    BidListing(
      id: 'mb3',
      thumbnail: 'assets/images/img2.png',
      title: 'Untitled No. 8',
      artist: 'Maya Chen',
      yourOffer: 725,
      status: BidStatus.expired,
      footerLabel: 'Time over',
    ),
    BidListing(
      id: 'mb4',
      thumbnail: 'assets/images/img2.png',
      title: 'Untitled No. 8',
      artist: 'Maya Chen',
      yourOffer: 725,
      status: BidStatus.won,
      footerLabel: 'Pay with in 48 to confirm product.',
      actionLabel: 'Pay Now',
      actionStyle: BidActionStyle.primary,
    ),
    BidListing(
      id: 'mb5',
      thumbnail: 'assets/images/img2.png',
      title: 'Untitled No. 8',
      artist: 'Maya Chen',
      yourOffer: 725,
      status: BidStatus.won,
      footerLabel: 'Pay with in 48 to confirm product.',
      actionLabel: 'Pay Now',
      actionStyle: BidActionStyle.primary,
    ),
  ];
}