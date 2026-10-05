import 'package:flutter/material.dart';

class MenuItem {
  const MenuItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
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
      icon: Icons.bookmark_border,
    ),
    MenuItem(
      id: 'orders',
      title: 'Order & Purchases',
      subtitle: 'Track orders and view your history',
      icon: Icons.shopping_bag_outlined,
    ),
    MenuItem(
      id: 'selling',
      title: 'Selling',
      subtitle: 'Manage your listings and sales',
      icon: Icons.sell_outlined,
    ),
    MenuItem(
      id: 'offers',
      title: 'Offers & Bids',
      subtitle: 'Bids, offers, and auction activity',
      icon: Icons.gavel_outlined,
    ),
    MenuItem(
      id: 'settings',
      title: 'Settings',
      subtitle: 'Account, preferences, and privacy',
      icon: Icons.settings_outlined,
    ),
    MenuItem(
      id: 'invite',
      title: 'Invite Friends',
      subtitle: 'Account, preferences, and privacy',
      icon: Icons.person_add_alt_1_outlined,
    ),
  ];
}