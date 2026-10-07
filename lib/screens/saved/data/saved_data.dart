/// Tabs shown at the top of the Saved screen.
enum SavedTab { all, artwork, posts }

abstract final class SavedData {
  static const title = 'Saved';

  static const tabs = <({String label, SavedTab value})>[
    (label: 'All', value: SavedTab.all),
    (label: 'Artwork', value: SavedTab.artwork),
    (label: 'Posts', value: SavedTab.posts),
  ];

  /// Product IDs that start out saved. In a real app this comes from the
  /// backend / local storage — the demo seeds a few so the grid isn't
  /// empty on first launch.
  static const initialSavedIds = <String>{
    'nordic',
    'stoneware',
    'wall-art',
    'table',
    'series',
    'minimal',
  };

  static const emptyArtworkMessage = 'Nothing saved yet';
  static const emptyPostsMessage = 'No saved posts yet';
}