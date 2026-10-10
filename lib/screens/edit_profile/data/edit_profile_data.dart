class EditProfileValues {
  const EditProfileValues({
    required this.name,
    required this.username,
    required this.bio,
    required this.location,
  });

  final String name;
  final String username;
  final String bio;
  final String location;

  EditProfileValues copyWith({
    String? name,
    String? username,
    String? bio,
    String? location,
  }) {
    return EditProfileValues(
      name: name ?? this.name,
      username: username ?? this.username,
      bio: bio ?? this.bio,
      location: location ?? this.location,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is EditProfileValues &&
              other.name == name &&
              other.username == username &&
              other.bio == bio &&
              other.location == location;

  @override
  int get hashCode => Object.hash(name, username, bio, location);
}

abstract final class EditProfileData {
  static const appBarTitle = 'Edit Profile';
  static const saveLabel = 'Save';
  static const changePhotoLabel = 'Change Profile Photo';

  static const avatarAsset = 'assets/images/demo_user.png';

  // Field labels (rendered uppercase)
  static const nameLabel = 'Full Name';
  static const usernameLabel = 'User Name';
  static const bioLabel = 'Bio';
  static const locationLabel = 'Location';

  static const nameHint = 'Your full name';
  static const usernameHint = '@username';
  static const bioHint = 'Tell people about yourself';
  static const locationHint = 'City, State';

  /// The base URL shown under the username field.
  static const profileUrlBase = 'kolek.io/';

  /// Seed data for the fields.
  static const initial = EditProfileValues(
    name: 'Simone Albers',
    username: '@simone.albers',
    bio: 'CONTEMPORARY PAINTER\n5 MIXED MEDIA ARTIST',
    location: 'San Francisco, CA',
  );
}