import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../routes/app_route.dart';
import '../../../screens/main_shell/cubit/main_shell_cubit.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../cubit/shop_cubit.dart';
import '../data/shop_data.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        leadingWidth: 96,
        leading: Row(
          children: [
            const SizedBox(width: 8),
            const KolekLogo(size: 28),
            IconButton(
              onPressed: () async {
                final result =
                    await Navigator.of(context).pushNamed(AppRoute.search);
                if (result == AppRoute.shop && context.mounted) {
                  context.read<MainShellCubit>().switchTab(1);
                }
              },
              icon: SvgPicture.asset(
                'assets/icons/search.svg',
                width: 20,
                height: 20,
              ),
            ),
          ],
        ),
        centerTitle: true,
        title: const KolekTextLogo(),
        actions: [
          BlocSelector<ShopCubit, ShopState, int>(
            selector: (state) => state.cartCount,
            builder: (context, cartCount) => IconButton(
              onPressed: () => Navigator.of(context).pushNamed(AppRoute.cart),
              icon: Badge(
                label: Text('$cartCount'),
                backgroundColor: KolekColors.blue600,
                child: SvgPicture.asset(
                  'assets/icons/cart.svg',
                  width: 22,
                  height: 22,
                  colorFilter: const ColorFilter.mode(
                    KolekColors.neutral900,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/notification_active.svg',
              width: 22,
              height: 22,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 4, 18, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ShopData.title,
                    style: KolekText.sans(
                      size: 50,
                      weight: FontWeight.w700,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    ShopData.subtitle,
                    style: KolekText.mono(
                      size: 11,
                      color: KolekColors.neutral600,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () async {
                          await Navigator.of(context).pushNamed(AppRoute.filter);
                          if (context.mounted) {
                            context.read<ShopCubit>().markFilterApplied();
                          }
                        },
                        icon: const Icon(Icons.tune, size: 17),
                        label: Text('Filter', style: KolekText.mono(size: 11)),
                      ),
                      const Spacer(),
                      BlocSelector<ShopCubit, ShopState, String>(
                        selector: (state) => state.sortLabel,
                        builder: (context, sortLabel) => InkWell(
                          onTap: context.read<ShopCubit>().cycleSort,
                          child: Row(
                            children: [
                              Text(
                                'Sort: $sortLabel',
                                style: KolekText.mono(size: 11),
                              ),
                              const Icon(Icons.keyboard_arrow_down, size: 17),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            sliver: SliverGrid.builder(
              itemCount: ShopData.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 18,
                childAspectRatio: .67,
              ),
              itemBuilder: (context, index) {
                final product = ShopData.products[index];
                return InkWell(
                  key: ValueKey('product-$index'),
                  onTap: () =>
                      Navigator.of(context).pushNamed(AppRoute.productDetails),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.asset(
                          product.image,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: KolekText.sans(size: 11, height: 1.25),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '\$${product.price}',
                            style: KolekText.sans(
                              size: 12,
                              weight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: context.read<ShopCubit>().addToCart,
                            child: const Icon(
                              Icons.add_circle_outline,
                              size: 17,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 22)),
        ],
      ),
    );
  }
}
