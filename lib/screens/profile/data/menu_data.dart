import 'package:flutter/material.dart';

class MenuItem {
  const MenuItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.iconAsset,
  });

  final String id;
  final String title;
  final String subtitle;
  final String iconAsset;
}

abstract final class MenuData {
  static const userName = 'Simone Albers';
  static const userHandle = '@simone.albers';
  static const userAvatar = 'assets/images/demo_user.png';

  static const versionFooter = 'v 1.4.2 • Kolek © 2024';

  static const items = <MenuItem>[
    MenuItem(
      id: 'saved',
      title: 'Saved',
      subtitle: "Artworks and post you've saved",
      iconAsset: 'assets/icons/save.svg',       // bookmark
    ),
    MenuItem(
      id: 'orders',
      title: 'Order & Purchases',
      subtitle: 'Track orders and view your history',
      iconAsset: 'assets/icons/cart.svg',      // shopping bag
    ),
    MenuItem(
      id: 'selling',
      title: 'Selling',
      subtitle: 'Manage your listings and sales',
      iconAsset: 'assets/icons/tag.svg',     // tag
    ),
    MenuItem(
      id: 'offers',
      title: 'Offers & Bids',
      subtitle: 'Bids, offers, and auction activity',
      iconAsset: 'assets/icons/offer_bid.svg',     // gavel
    ),
    MenuItem(
      id: 'settings',
      title: 'Settings',
      subtitle: 'Account, preferences, and privacy',
      iconAsset: 'assets/icons/settings.svg',    // gear
    ),
    MenuItem(
      id: 'invite',
      title: 'Invite Friends',
      subtitle: 'Account, preferences, and privacy',
      iconAsset: 'assets/icons/invite_friend.svg',      // person with +
    ),
  ];
}