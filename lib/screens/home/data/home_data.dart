import 'home_post_type.dart';

export 'home_post_type.dart';

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
    required this.type,
    this.year,
    this.ownedByViewer = false,
  });

  final String id;
  final String author;
  final String location;
  final String image;
  final String title;
  final String? year;
  final String description;
  final String likes;
  final String commentCount;
  final String shareCount;
  final HomePostType type;
  final bool ownedByViewer;
}

class HomeComment {
  const HomeComment({
    required this.id,
    required this.author,
    required this.age,
    required this.message,
    this.avatarAsset = 'assets/images/demo_user.png',
    this.parentId,
    this.replyToUsername,
    this.isMine = false,
    this.replies = const [],
  });

  final String id;
  final String author;
  final String age;
  final String message;
  final String avatarAsset;

  /// Null for a level 1 comment. A level 2 comment stores its level 1 id.
  final String? parentId;

  /// Set when this level 2 comment replies to another level 2 comment.
  final String? replyToUsername;

  final bool isMine;

  /// Level 2 comments only. Never contains another nested thread.
  final List<HomeComment> replies;

  bool get isLevelTwo => parentId != null;

  HomeComment copyWith({List<HomeComment>? replies}) {
    return HomeComment(
      id: id,
      author: author,
      age: age,
      message: message,
      avatarAsset: avatarAsset,
      parentId: parentId,
      replyToUsername: replyToUsername,
      isMine: isMine,
      replies: replies ?? this.replies,
    );
  }
}

enum HomeMenuAction { savePost, message, report }

class HomeMenuItem {
  const HomeMenuItem({required this.action, required this.label});

  final HomeMenuAction action;
  final String label;
}

abstract final class HomeData {
  static const viewerName = 'Rakibul';
  static const postDescription =
      'Exploring movement and stillness. Each curve holds a moment of balance. Fired slowly so the surface stays quiet, with a soft edge that catches the light.';
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
      image: 'assets/images/home_post_1.png',
      title: 'Vase Series',
      description: postDescription,
      likes: '2,841',
      commentCount: '147',
      shareCount: '89',
      type: HomePostType.sell,
      ownedByViewer: true,
    ),
    HomePost(
      id: 'quiet-forms',
      author: 'Ronald Richards',
      location: 'Dhaka, Bangladesh',
      image: 'assets/images/home_post_2.png',
      title: 'Vase Series',
      description: postDescription,
      likes: '2,841',
      commentCount: '147',
      shareCount: '89',
      type: HomePostType.auction,
    ),
    HomePost(
      id: 'theresa-vase',
      author: 'Theresa Webb',
      location: 'Dhaka, Bangladesh',
      image: 'assets/images/home_post_3.png',
      title: 'Vase Series',
      year: '2026',
      description: postDescription,
      type: HomePostType.normal,
      likes: '2,841',
      commentCount: '147',
      shareCount: '89',
    ),
    HomePost(
      id: 'jacob-vase',
      author: 'Jacob Jones',
      location: 'Dhaka, Bangladesh',
      image: 'assets/images/home_post_4.png',
      title: 'Vase Series',
      year: '2026',
      description: postDescription,
      type: HomePostType.sell,
      likes: '2,841',
      commentCount: '147',
      shareCount: '89',
    ),
  ];

  static const _commentBody =
      'The details here really draw me in, wonderful work.';

  static final List<HomeComment> comments = [
    for (var i = 0; i < 3; i++)
      HomeComment(
        id: 'c$i',
        author: 'Darren Lee',
        age: '3h ago',
        message: _commentBody,
        replies: [
          for (var reply = 0; reply < 17; reply++)
            HomeComment(
              id: 'c${i}r$reply',
              parentId: 'c$i',
              author: 'Rakibul',
              age: '3h ago',
              message: _commentBody,
              isMine: true,
            ),
        ],
      ),
  ];
}
