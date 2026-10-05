import 'package:flutter/material.dart';

class SettingsItem {
  const SettingsItem({
    required this.id,
    required this.title,
    this.subtitle,
    this.iconAsset,
    this.iconData,
    this.isLogout = false,
    this.isDestructive = false,
  }) : assert(
  iconAsset != null || iconData != null,
  'Provide either an SVG asset path or a Material icon.',
  );

  final String id;
  final String title;
  final String? subtitle;

  /// Path to an SVG in `assets/icons/`.
  final String? iconAsset;

  /// Material icon fallback — used when no SVG exists for this row.
  final IconData? iconData;

  final bool isLogout;
  final bool isDestructive;
}

class SettingsSection {
  const SettingsSection({required this.label, required this.items});

  final String label;
  final List<SettingsItem> items;
}

abstract final class SettingsData {
  static const versionFooter = 'v 1.4.2 • Kolek © 2024';

  static const sections = <SettingsSection>[
    SettingsSection(
      label: 'ACCOUNT',
      items: [
        SettingsItem(
          id: 'edit-profile',
          title: 'Edit Profile',
          subtitle: 'Manage your profile information',
          iconData: Icons.person_outline,
        ),
        SettingsItem(
          id: 'account-info',
          title: 'Account Information',
          subtitle: 'Email, phone number, username',
          iconAsset: 'assets/icons/account_information.svg',
        ),
        SettingsItem(
          id: 'password',
          title: 'Password & Security',
          subtitle: 'Password and account security',
          iconAsset: 'assets/icons/password_security.svg',
        ),
      ],
    ),
    SettingsSection(
      label: 'NOTIFICATION',
      items: [
        SettingsItem(
          id: 'push',
          title: 'Push Notification',
          subtitle: 'Manage push notification preferences',
          iconData: Icons.notifications_none,
        ),
      ],
    ),
    SettingsSection(
      label: 'PRIVACY',
      items: [
        SettingsItem(
          id: 'privacy',
          title: 'Privacy & Visibility',
          subtitle: 'Control who can see your content',
          iconAsset: 'assets/icons/privacy.svg',
        ),
        SettingsItem(
          id: 'blocked',
          title: 'Blocked Accounts',
          subtitle: 'Manage blocked users',
          iconAsset: 'assets/icons/block.svg',
        ),
      ],
    ),
    SettingsSection(
      label: 'BUYING & SELLING',
      items: [
        SettingsItem(
          id: 'payment',
          title: 'Payment Methods',
          subtitle: 'Manage your payment methods',
          iconAsset: 'assets/icons/payment.svg',
        ),
        SettingsItem(
          id: 'shipping',
          title: 'Shipping Addresses',
          subtitle: 'Manage your shipping addresses',
          iconAsset: 'assets/icons/location.svg',
        ),
        SettingsItem(
          id: 'payouts',
          title: 'Payouts',
          subtitle: 'Manage your payout information',
          iconAsset: 'assets/icons/pay_out.svg',
        ),
      ],
    ),
    SettingsSection(
      label: 'PREFERENCES',
      items: [
        SettingsItem(
          id: 'appearance',
          title: 'Appearance',
          subtitle: 'Choose light or dark mode',
          iconAsset: 'assets/icons/appearance.svg',
        ),
      ],
    ),
    SettingsSection(
      label: 'SUPPORT',
      items: [
        SettingsItem(
          id: 'help',
          title: 'Help & Support',
          subtitle: 'Find answers and support',
          iconAsset: 'assets/icons/help_support.svg',
        ),
        SettingsItem(
          id: 'report',
          title: 'Report a Problem',
          subtitle: "Let us know what's not working",
          iconAsset: 'assets/icons/report.svg',
        ),
        SettingsItem(
          id: 'terms',
          title: 'Terms & Policies',
          subtitle: 'Terms of service and privacy policy',
          iconAsset: 'assets/icons/terms_condition.svg',
        ),
        SettingsItem(
          id: 'about',
          title: 'About Kolek',
          subtitle: 'Learn more about Kolek',
          iconAsset: 'assets/icons/about.svg',
        ),
      ],
    ),
    SettingsSection(
      label: '',
      items: [
        SettingsItem(
          id: 'logout',
          title: 'Log Out',
          iconData: Icons.logout,
          isLogout: true,
        ),
        SettingsItem(
          id: 'delete-account',
          title: 'Deactivate or Delete Account',
          iconAsset: 'assets/icons/deactivate_delete_account.svg',
          isDestructive: true,
        ),
      ],
    ),
  ];
}