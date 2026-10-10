class AccountInformationValues {
  const AccountInformationValues({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    required this.username,
    required this.memberSince,
  });

  final String fullName;
  final String email;
  final String phone;
  final String password;

  /// Read-only — a user can't change their handle from this screen.
  final String username;

  /// Read-only — server-provided account creation date.
  final String memberSince;

  AccountInformationValues copyWith({
    String? fullName,
    String? email,
    String? phone,
    String? password,
  }) {
    return AccountInformationValues(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      username: username,
      memberSince: memberSince,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AccountInformationValues &&
              other.fullName == fullName &&
              other.email == email &&
              other.phone == phone &&
              other.password == password &&
              other.username == username &&
              other.memberSince == memberSince;

  @override
  int get hashCode =>
      Object.hash(fullName, email, phone, password, username, memberSince);
}

abstract final class AccountInformationData {
  static const appBarTitle = 'Account Information';
  static const subtitle =
      'Manage the information connected to your Kolek account.';

  // ── Field labels ───────────────────────────────────────────────────
  static const fullNameLabel = 'Full Name';
  static const emailLabel = 'Email Address';
  static const phoneLabel = 'Phone Number';
  static const passwordLabel = 'Password';

  static const accountSectionLabel = 'ACCOUNT';
  static const usernameLabel = 'User Name';
  static const memberSinceLabel = 'Member Since';

  // ── Hints ──────────────────────────────────────────────────────────
  static const fullNameHint = 'e.g. Alex Morgan';
  static const emailHint = 'e.g.alex@gmail.com';
  static const phoneHint = 'e.g. +1 234 567 8900';
  static const passwordHint = '••••••••••';

  /// Helper text shown under the email field.
  static const emailHelper =
      'This Is The Email Used To Sign In And Receive Important Account\n'
      'Communications.';

  static const changeLabel = 'Change';
  static const saveLabel = 'Save Changes';

  /// Seed values — replace with the current user's data when the API is
  /// wired.
  static const initial = AccountInformationValues(
    fullName: '',
    email: '',
    phone: '',
    password: '••••••••••',
    username: '@devindeamaral',
    memberSince: 'August 2026',
  );
}