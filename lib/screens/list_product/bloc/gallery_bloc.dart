import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';

import 'gallery_event.dart';
import 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc({required this.maxSelectable})
      : super(const GalleryState()) {
    on<GalleryLoadRequested>(_onLoad);
    on<GalleryAssetToggled>(_onToggle);
    on<GallerySelectionCleared>(_onClear);
  }

  final int maxSelectable;

  Future<void> _onLoad(
      GalleryLoadRequested event,
      Emitter<GalleryState> emit,
      ) async {
    emit(state.copyWith(loading: true));

    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) {
      emit(state.copyWith(loading: false, permissionDenied: true));
      return;
    }

    final albums = await PhotoManager.getAssetPathList(
      type: RequestType.common,
      onlyAll: true,
    );

    if (albums.isEmpty) {
      emit(state.copyWith(loading: false, assets: const []));
      return;
    }

    final recent = albums.first;
    final count = await recent.assetCountAsync;
    final assets = await recent.getAssetListPaged(
      page: 0,
      size: count,
    );

    emit(state.copyWith(loading: false, assets: assets));
  }

  void _onToggle(GalleryAssetToggled event, Emitter<GalleryState> emit) {
    final selected = Set<String>.from(state.selectedIds);

    if (selected.contains(event.assetId)) {
      selected.remove(event.assetId);
    } else {
      if (selected.length >= maxSelectable) return;
      selected.add(event.assetId);
    }

    emit(state.copyWith(selectedIds: selected));
  }

  void _onClear(GallerySelectionCleared event, Emitter<GalleryState> emit) {
    emit(state.copyWith(selectedIds: const <String>{}));
  }
}