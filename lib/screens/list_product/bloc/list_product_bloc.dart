import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/list_product_data.dart';
import 'list_product_event.dart';
import 'list_product_state.dart';

class ListProductBloc extends Bloc<ListProductEvent, ListProductState> {
  ListProductBloc() : super(const ListProductState()) {
    on<ListProductPhotoAdded>(_onPhotoAdded);
    on<ListProductPhotoRemoved>(_onPhotoRemoved);
    on<ListProductTitleChanged>(_onTitleChanged);
    on<ListProductArtistChanged>(_onArtistChanged);
    on<ListProductYearChanged>(_onYearChanged);
    on<ListProductCategoryChanged>(_onCategoryChanged);
    on<ListProductWidthChanged>(_onWidthChanged);
    on<ListProductHeightChanged>(_onHeightChanged);
    on<ListProductSubmitted>(_onSubmitted);
    on<ListProductDraftSaved>(_onDraftSaved);
  }

  void _onPhotoAdded(
      ListProductPhotoAdded event,
      Emitter<ListProductState> emit,
      ) {
    if (!state.canAddPhoto) return;

    // Real path from the gallery picker.
    if (event.path != null) {
      emit(state.copyWith(photos: [...state.photos, event.path!]));
      return;
    }

    // Fallback for tests / demo without a picker.
    final pool = ListProductData.samplePhotoPool;
    final next = pool[state.photos.length % pool.length];
    emit(state.copyWith(photos: [...state.photos, next]));
  }

  void _onPhotoRemoved(
      ListProductPhotoRemoved event,
      Emitter<ListProductState> emit,
      ) {
    if (event.index < 0 || event.index >= state.photos.length) return;
    final next = [...state.photos]..removeAt(event.index);
    emit(state.copyWith(photos: next));
  }

  void _onTitleChanged(
      ListProductTitleChanged event,
      Emitter<ListProductState> emit,
      ) {
    if (event.value.length > ListProductData.titleMaxLength) return;
    emit(state.copyWith(title: event.value));
  }

  void _onArtistChanged(
      ListProductArtistChanged event,
      Emitter<ListProductState> emit,
      ) {
    if (event.value.length > ListProductData.artistMaxLength) return;
    emit(state.copyWith(artist: event.value));
  }

  void _onYearChanged(
      ListProductYearChanged event,
      Emitter<ListProductState> emit,
      ) {
    emit(state.copyWith(year: event.value));
  }

  void _onCategoryChanged(
      ListProductCategoryChanged event,
      Emitter<ListProductState> emit,
      ) {
    emit(state.copyWith(category: event.value));
  }

  void _onWidthChanged(
      ListProductWidthChanged event,
      Emitter<ListProductState> emit,
      ) {
    emit(state.copyWith(width: event.value));
  }

  void _onHeightChanged(
      ListProductHeightChanged event,
      Emitter<ListProductState> emit,
      ) {
    emit(state.copyWith(height: event.value));
  }

  void _onSubmitted(
      ListProductSubmitted event,
      Emitter<ListProductState> emit,
      ) {
    if (!state.canProceed) return;
    emit(state.copyWith(submitting: true));
    // TODO: dispatch to the API and navigate to the next step.
  }

  void _onDraftSaved(
      ListProductDraftSaved event,
      Emitter<ListProductState> emit,
      ) {
    // TODO: persist the draft to local storage.
  }
}