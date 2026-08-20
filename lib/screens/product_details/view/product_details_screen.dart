import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

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
        title: const KolekTextLogo(),
        actions: [
          BlocSelector<ProductDetailsCubit, ProductDetailsState, int>(
            selector: (state) => state.cartCount,
            builder: (context, cartCount) => IconButton(
              onPressed: () => Navigator.of(context).pushNamed(AppRoute.cart),
              icon: Badge(
                backgroundColor: KolekColors.blue600,
                label: Text(
                  '$cartCount',
                  style: const TextStyle(
                    fontFamily: 'GeneralSans-Regular',
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                child: SvgPicture.asset(
                  'assets/icons/cart.svg',
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    Colors.black, // Change color as needed
                    BlendMode.srcIn,
                  ),
                ),
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
                          style: const TextStyle(
                            fontFamily: 'IBMPlexMono-Regular',
                            fontSize: 9,
                            fontWeight: FontWeight.w400,
                            color: KolekColors.neutral900,
                          ),
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
                  ProductDetailsData.product.title.toUpperCase(),
                  style: const TextStyle(
                    fontFamily: 'GeneralSans-Semibold',
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    height: 38 / 32,
                    letterSpacing: -2,
                    color: KolekColors.neutral900,
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    Text(
                      '\$${ProductDetailsData.product.price}',
                      style: const TextStyle(
                        fontFamily: 'IBMPlexMono-Medium',
                        fontSize: 27,
                        fontWeight: FontWeight.w500,
                        height: 40 / 27,
                        letterSpacing: 0,
                        color: KolekColors.blue600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 50, // Adjust to match text width
                      height: 1.5,
                      color: KolekColors.neutral950,
                    ),
                  ],
                ),


                const SizedBox(height: 12),
                Text(
                  ProductDetailsData.product.description,
                  style: const TextStyle(
                    fontFamily: 'IBMPlexMono-Regular',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 20 / 16,
                    letterSpacing: 0,
                    color: KolekColors.neutral900,
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  label: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'By ',
                          style: TextStyle(
                            fontFamily: 'IBMPlexMono-Regular',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: KolekColors.neutral950,
                          ),
                        ),
                        TextSpan(
                          text: ProductDetailsData.product.seller,
                          style: const TextStyle(
                            fontFamily: 'IBMPlexMono-Regular',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: KolekColors.blue600,
                          ),
                        ),
                        const TextSpan(
                          text: '  →',
                          style: TextStyle(
                            fontFamily: 'IBMPlexMono-Regular',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: KolekColors.neutral950,
                          ),
                        ),
                      ],
                    ),
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
                      style: const TextStyle(
                        fontFamily: 'GeneralSans-Regular',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
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
                      style: const TextStyle(
                        fontFamily: 'GeneralSans-Regular',
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
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
