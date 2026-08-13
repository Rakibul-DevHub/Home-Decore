class HomePost {
  const HomePost({
    required this.id,
    required this.author,
    required this.location,
    required this.image,
    required this.title,
    required this.description,
    required this.likes,
    required this.commentCount,
    required this.shareCount,
  });

  final String id;
  final String author;
  final String location;
  final String image;
  final String title;
  final String description;
  final String likes;
  final String commentCount;
  final String shareCount;
}

class HomeComment {
  const HomeComment({
    required this.author,
    required this.age,
    required this.message,
    this.avatarAsset = 'assets/images/demo_user.png',
    this.replyCount = 17,
  });

  final String author;
  final String age;
  final String message;
  final String avatarAsset;
  final int replyCount;
}

enum HomeMenuAction { savePost, message, report }

class HomeMenuItem {
  const HomeMenuItem({required this.action, required this.label});

  final HomeMenuAction action;
  final String label;
}

abstract final class HomeData {
  static const menuItems = [
    HomeMenuItem(action: HomeMenuAction.savePost, label: 'Save Post'),
    HomeMenuItem(action: HomeMenuAction.message, label: 'Message'),
    HomeMenuItem(action: HomeMenuAction.report, label: 'Report'),
  ];

  static const posts = [
    HomePost(
      id: 'vase-series',
      author: 'Ronald Richards',
      location: 'Dhaka, Bangladesh',
      image: 'assets/images/vase_series.png',
      title: 'Vase Series',
      description:
          'Exploring movement and stillness. Each curve holds a moment of '
          'balance.',
      likes: '2,841',
      commentCount: '147',
      shareCount: '89',
    ),
    HomePost(
      id: 'quiet-forms',
      author: 'Wade Warren',
      location: 'Dhaka, Bangladesh',
      image: 'assets/images/vase_series_1.png',
      title: 'Quiet Forms',
      description:
          'A study in texture, form, and patient craftsmanship across quiet '
          'spaces.',
      likes: '1,204',
      commentCount: '86',
      shareCount: '41',
    ),
  ];

  static const comments = [
    HomeComment(
      author: 'Darren Lee',
      age: '3h ago',
      message: 'The details here really draw me in,\nwonderful work.',
    ),
    HomeComment(
      author: 'Darren Lee',
      age: '3h ago',
      message: 'The details here really draw me in,\nwonderful work.',
    ),
    HomeComment(
      author: 'Darren Lee',
      age: '3h ago',
      message: 'The details here really draw me in,\nwonderful work.',
    ),
    HomeComment(
      author: 'Darren Lee',
      age: '3h ago',
      message: 'The details here really draw me in,\nwonderful work.',
    ),
  ];
}
