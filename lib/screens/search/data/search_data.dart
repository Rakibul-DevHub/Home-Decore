class SearchPerson {
  const SearchPerson({
    required this.id,
    required this.name,
    this.handle,
    this.avatarAsset,
  });

  final String id;
  final String name;
  final String? handle;
  final String? avatarAsset;

  bool get isHistory => avatarAsset == null;
}

abstract final class SearchData {
  static const recent = [
    SearchPerson(id: 'h1', name: 'Courtney Henry'),
    SearchPerson(
      id: 'u1',
      name: 'Courtney Henry',
      handle: '@courtney_234',
      avatarAsset: 'assets/images/search_user_1.png',
    ),
    SearchPerson(id: 'h2', name: 'Courtney Henry'),
    SearchPerson(
      id: 'u2',
      name: 'Courtney Henry',
      handle: '@courtney_234',
      avatarAsset: 'assets/images/search_user_2.png',
    ),
    SearchPerson(id: 'h3', name: 'Courtney Henry'),
    SearchPerson(
      id: 'u3',
      name: 'Courtney Henry',
      handle: '@courtney_234',
      avatarAsset: 'assets/images/search_user_3.png',
    ),
    SearchPerson(
      id: 'u4',
      name: 'Courtney Henry',
      handle: '@courtney_234',
      avatarAsset: 'assets/images/search_user_4.png',
    ),
  ];
}
