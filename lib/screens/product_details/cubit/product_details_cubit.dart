import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/product_details_data.dart';

class ProductDetailsState extends Equatable {
  const ProductDetailsState({this.selectedImage = 0, this.cartCount = 2});

  final int selectedImage;
  final int cartCount;

  ProductDetailsState copyWith({int? selectedImage, int? cartCount}) =>
      ProductDetailsState(
        selectedImage: selectedImage ?? this.selectedImage,
        cartCount: cartCount ?? this.cartCount,
      );

  @override
  List<Object> get props => [selectedImage, cartCount];
}

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(const ProductDetailsState());

  void selectImage(int index) {
    if (index < 0 || index >= ProductDetailsData.product.images.length) return;
    emit(state.copyWith(selectedImage: index));
  }

  void addToCart() => emit(state.copyWith(cartCount: state.cartCount + 1));
}
