import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';

final class GalleryState extends Equatable {
  const GalleryState({
    this.assets = const <AssetEntity>[],
    this.selectedIds = const <String>{},
    this.loading = false,
    this.permissionDenied = false,
  });

  final List<AssetEntity> assets;
  final Set<String> selectedIds;
  final bool loading;
  final bool permissionDenied;

  List<AssetEntity> get selectedAssets => assets
      .where((a) => selectedIds.contains(a.id))
      .toList(growable: false);

  int get selectionCount => selectedIds.length;

  GalleryState copyWith({
    List<AssetEntity>? assets,
    Set<String>? selectedIds,
    bool? loading,
    bool? permissionDenied,
  }) {
    return GalleryState(
      assets: assets ?? this.assets,
      selectedIds: selectedIds ?? this.selectedIds,
      loading: loading ?? this.loading,
      permissionDenied: permissionDenied ?? this.permissionDenied,
    );
  }

  @override
  List<Object?> get props => [assets, selectedIds, loading, permissionDenied];
}