import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/app_route.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../cubit/product_details_cubit.dart';
import '../data/product_details_data.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KolekColors.neutral50,
      appBar: AppBar(
        backgroundColor: KolekColors.neutral50,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, size: 20),
        ),
        centerTitle: true,
        title: Text(
          'kolek',
          style: KolekText.mono(size: 22, color: KolekColors.blue600),
        ),
        actions: [
          BlocSelector<ProductDetailsCubit, ProductDetailsState, int>(
            selector: (state) => state.cartCount,
            builder: (context, cartCount) => IconButton(
              onPressed: () => Navigator.of(context).pushNamed(AppRoute.cart),
              icon: Badge(
                label: Text('$cartCount'),
                child: const Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 96),
        children: [
          BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
            buildWhen: (previous, current) =>
                previous.selectedImage != current.selectedImage,
            builder: (context, state) => AspectRatio(
              aspectRatio: 1.05,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: InkWell(
                      onTap: () {
                        final next =
                            (state.selectedImage + 1) %
                            ProductDetailsData.product.images.length;
                        context.read<ProductDetailsCubit>().selectImage(next);
                      },
                      child: Image.asset(
                        ProductDetailsData.product.images[state.selectedImage],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    bottom: 14,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: KolekColors.neutral50.withValues(alpha: .85),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Text(
                          '${state.selectedImage + 1}/'
                          '${ProductDetailsData.product.images.length}',
                          style: KolekText.mono(size: 9),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ProductDetailsData.product.title,
                  style: KolekText.sans(
                    size: 26,
                    weight: FontWeight.w700,
                    height: .95,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '\$${ProductDetailsData.product.price}',
                  style: KolekText.sans(size: 22, color: KolekColors.blue600),
                ),
                const SizedBox(height: 12),
                Text(
                  ProductDetailsData.product.description,
                  style: KolekText.mono(size: 11, height: 1.45),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                  ),
                  icon: const CircleAvatar(
                    radius: 10,
                    backgroundColor: KolekColors.neutral300,
                    child: Text('R'),
                  ),
                  label: Text(
                    'By ${ProductDetailsData.product.seller}  →',
                    style: KolekText.mono(size: 10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: SafeArea(
        top: false,
        child: Container(
          color: KolekColors.neutral50,
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: FilledButton(
                    onPressed: () {
                      context.read<ProductDetailsCubit>().addToCart();
                      Navigator.of(context).pushNamed(AppRoute.cart);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: KolekColors.neutral900,
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: Text(
                      'Add to Cart',
                      style: KolekText.sans(size: 12, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: FilledButton(
                    onPressed: () {
                      context.read<ProductDetailsCubit>().addToCart();
                      Navigator.of(context).pushNamed(AppRoute.cart);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: KolekColors.blue600,
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: Text(
                      'Buy Now  —  \$${ProductDetailsData.product.price}',
                      style: KolekText.sans(size: 11, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
