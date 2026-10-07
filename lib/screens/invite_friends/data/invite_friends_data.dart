abstract final class InviteFriendsData {
  static const title = 'Invite Friends';

  // ── Hero ───────────────────────────────────────────────────────────
  static const heroTitle = 'Art is better\nwith friends.';
  static const heroSubtitle =
      'Invite friends to join Kolek and discover\n'
      'new artists, collect work, and share\n'
      'what inspires them.';

  // ── Invite link ────────────────────────────────────────────────────
  static const inviteLinkLabel = 'Your Invite Link';
  static const inviteLink = 'kolek.io/invite/khairuldado';
  static const copyLabel = 'Copy';
  static const copiedLabel = 'Copied';

  // ── Contact support ────────────────────────────────────────────────
  static const contactSupportLabel = 'Contact Support';

  // ── Share with ─────────────────────────────────────────────────────
  static const shareWithLabel = 'Share With';
  static const messagesLabel = 'Messages';
  static const emailLabel = 'Email';

  // ── Suggested message ─────────────────────────────────────────────
  static const suggestedLabel = 'Suggested Invite Message';
  static const suggestedBody =
      'Join me on Kolek — a place to discover, share, buy, and sell art.';
}

/// Which channel the user picked under "Share With".
enum ShareChannel { messages, email }