/// Actions available on the Password & Security screen.
enum SecurityAction {
  changePassword,
  setupTwoFactor,
  viewLoginActivity,
  logoutOtherDevices,
}

abstract final class PasswordSecurityData {
  static const appBarTitle = 'Password & Security';
  static const subtitle =
      'Manage your password and keep your Kolek account secure.';

  // ── Section 1: credential rows ─────────────────────────────────────
  static const passwordTitle = 'Password';
  static const passwordSubtitle = 'Last changed 3 months ago';
  static const passwordActionLabel = 'Change';

  static const twoFactorTitle = 'Two-Factor Authentication';
  static const twoFactorSubtitle =
      'Add an extra layer of security to your account.';
  static const twoFactorActionLabel = 'Set Up';

  // ── Section 2: full-width actions ──────────────────────────────────
  static const loginActivityLabel = 'View All Login Activity';
  static const logoutOtherDevicesLabel = 'Log Out of Other Devices';

  // ── Footnote --------
  static const footnote =
      'Kolek may send you an email or text if we detect\n'
      'important changes or unusual activity on your account.';
}