// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// import '../../../routes/app_route.dart';
// import '../../../screens/appearance/appearance_page.dart';
// import '../../../screens/main_shell/cubit/main_shell_cubit.dart';
// import '../../../theme/kolek_colors.dart';
// import '../../../widgets/notification_line_mapper.dart';
// import '../bloc/shop_bloc.dart';
// import '../data/shop_data.dart';
//
// class ShopScreen extends StatelessWidget {
//   const ShopScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppearancePage.background(context),
//       appBar: AppBar(
//         backgroundColor: AppearancePage.background(context),
//         scrolledUnderElevation: 0,
//         leadingWidth: 96,
//         leading: Row(
//           children: [
//             IconButton(
//               onPressed: () async {
//                 final result = await Navigator.of(
//                   context,
//                 ).pushNamed(AppRoute.search);
//                 if (result == AppRoute.shop && context.mounted) {
//                   context.read<MainShellCubit>().switchTab(1);
//                 }
//               },
//               icon: SvgPicture.asset(
//                 'assets/icons/search.svg',
//                 width: 24,
//                 height: 24,
//                 colorFilter: AppearancePage.iconFilter(context),
//               ),
//             ),
//           ],
//         ),
//         centerTitle: true,
//         title: SvgPicture.asset(
//           'assets/icons/text_logo.svg',
//           width: 78,
//           height: 24,
//           fit: BoxFit.contain,
//         ),
//
//         actions: [
//           BlocSelector<ShopBloc, ShopState, int>(
//             selector: (state) => state.cartCount,
//             builder: (context, cartCount) => IconButton(
//               onPressed: () => Navigator.of(context).pushNamed(AppRoute.cart),
//               icon: Badge(
//                 label: Text(
//                   '$cartCount',
//                   style: const TextStyle(
//                     fontFamily: 'GeneralSans-Regular',
//                     fontSize: 10,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.white,
//                   ),
//                 ),
//                 backgroundColor: KolekColors.blue600,
//                 child: SvgPicture.asset(
//                   'assets/icons/cart.svg',
//                   width: 24,
//                   height: 24,
//                   colorFilter: AppearancePage.iconFilter(context),
//                 ),
//               ),
//             ),
//           ),
//           IconButton(
//             onPressed: () =>
//                 Navigator.of(context).pushNamed(AppRoute.notifications),
//             icon: SvgPicture.asset(
//               'assets/icons/notification_active.svg',
//               width: 24,
//               height: 24,
//               colorMapper: NotificationLineMapper(AppearancePage.icon(context)),
//             ),
//           ),
//         ],
//       ),
//       body: CustomScrollView(
//         slivers: [
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(18, 4, 18, 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     ShopData.title,
//                     style: TextStyle(
//                       fontFamily: 'GeneralSans-Semibold',
//                       fontSize: 60,
//                       fontWeight: FontWeight.w600,
//                       height: 1,
//                       color: AppearancePage.foreground(context),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     ShopData.subtitle,
//                     style: TextStyle(
//                       fontFamily: 'IBMPlexMono-Regular',
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                       height: 1.4,
//                       color: AppearancePage.secondary(context),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Divider(color: AppearancePage.line(context)),
//                   Row(
//                     children: [
//                       TextButton(
//                         onPressed: () async {
//                           await Navigator.of(context)
//                               .pushNamed(AppRoute.filter);
//                           if (context.mounted) {
//                             context
//                                 .read<ShopBloc>()
//                                 .add(const ShopFilterApplied());
//                           }
//                         },
//                         style: TextButton.styleFrom(
//                           padding: const EdgeInsets.only(top: 8),
//                           minimumSize: const Size(0, 0),
//                           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               'Filter',
//                               style: TextStyle(
//                                 fontFamily: 'IBMPlexMono-Regular',
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w400,
//                                 color: AppearancePage.foreground(context),
//                               ),
//                             ),
//                             const SizedBox(width: 6),
//                             Icon(
//                               Icons.tune,
//                               size: 17,
//                               color: AppearancePage.icon(context),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const Spacer(),
//                       BlocSelector<ShopBloc, ShopState, String>(
//                         selector: (state) => state.sortLabel,
//                         builder: (context, sortLabel) => InkWell(
//                           onTap: () => context
//                               .read<ShopBloc>()
//                               .add(const ShopSortCycled()),
//                           child: Row(
//                             children: [
//                               Text(
//                                 'Sort: $sortLabel',
//                                 style: TextStyle(
//                                   fontFamily: 'IBMPlexMono-Regular',
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                   color: AppearancePage.foreground(context),
//                                 ),
//                               ),
//                               Icon(
//                                 Icons.keyboard_arrow_down,
//                                 size: 17,
//                                 color: AppearancePage.icon(context),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverPadding(
//             padding: const EdgeInsets.symmetric(horizontal: 18),
//             sliver: SliverGrid.builder(
//               itemCount: ShopData.products.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 8,
//                 mainAxisSpacing: 18,
//                 childAspectRatio: .67,
//               ),
//               itemBuilder: (context, index) {
//                 final product = ShopData.products[index];
//                 return InkWell(
//                   key: ValueKey('product-$index'),
//                   onTap: () =>
//                       Navigator.of(context).pushNamed(AppRoute.productDetails),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: Image.asset(
//                           product.image,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         product.name,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           fontFamily: 'GeneralSans-Medium',
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           height: 1.25,
//                           color: AppearancePage.foreground(context),
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Row(
//                         children: [
//                           Text(
//                             '\$${product.price}',
//                             style: TextStyle(
//                               fontFamily: 'GeneralSans-Semibold',
//                               fontSize: 12,
//                               fontWeight: FontWeight.w700,
//                               color: AppearancePage.foreground(context),
//                             ),
//                           ),
//                           const Spacer(),
//                           InkWell(
//                             onTap: () => context
//                                 .read<ShopBloc>()
//                                 .add(const ShopCartItemAdded()),
//                             child: Icon(
//                               Icons.add_circle_outline,
//                               size: 17,
//                               color: AppearancePage.icon(context),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           const SliverToBoxAdapter(child: SizedBox(height: 22)),
//         ],
//       ),
//     );
//   }
// }
//








/*

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../routes/app_route.dart';
import '../../../screens/appearance/appearance_page.dart';
import '../../../screens/main_shell/cubit/main_shell_cubit.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/notification_line_mapper.dart';
import '../bloc/shop_bloc.dart';
import '../data/shop_data.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      appBar: AppBar(
        backgroundColor: AppearancePage.background(context),
        scrolledUnderElevation: 0,
        leadingWidth: 96,
        leading: Row(
          children: [
            IconButton(
              onPressed: () async {
                final result = await Navigator.of(
                  context,
                ).pushNamed(AppRoute.search);
                if (result == AppRoute.shop && context.mounted) {
                  context.read<MainShellCubit>().switchTab(1);
                }
              },
              icon: SvgPicture.asset(
                'assets/icons/search.svg',
                width: 24,
                height: 24,
                colorFilter: AppearancePage.iconFilter(context),
              ),
            ),
          ],
        ),
        centerTitle: true,
        title: SvgPicture.asset(
          'assets/icons/text_logo.svg',
          width: 78,
          height: 24,
          fit: BoxFit.contain,
        ),
        actions: [
          BlocSelector<ShopBloc, ShopState, int>(
            selector: (state) => state.cartCount,
            builder: (context, cartCount) => IconButton(
              onPressed: () => Navigator.of(context).pushNamed(AppRoute.cart),
              icon: Badge(
                label: Text(
                  '$cartCount',
                  style: const TextStyle(
                    fontFamily: 'GeneralSans-Regular',
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: KolekColors.blue600,
                child: SvgPicture.asset(
                  'assets/icons/cart.svg',
                  width: 24,
                  height: 24,
                  colorFilter: AppearancePage.iconFilter(context),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoute.notifications),
            icon: SvgPicture.asset(
              'assets/icons/notification_active.svg',
              width: 24,
              height: 24,
              colorMapper:
              NotificationLineMapper(AppearancePage.icon(context)),
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
                    style: TextStyle(
                      fontFamily: 'GeneralSans-Semibold',
                      fontSize: 60,
                      fontWeight: FontWeight.w600,
                      height: 1,
                      color: AppearancePage.foreground(context),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    ShopData.subtitle,
                    style: TextStyle(
                      fontFamily: 'IBMPlexMono-Regular',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                      color: AppearancePage.secondary(context),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Divider(color: AppearancePage.line(context)),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () async {
                          await Navigator.of(context)
                              .pushNamed(AppRoute.filter);
                          if (context.mounted) {
                            context
                                .read<ShopBloc>()
                                .add(const ShopFilterApplied());
                          }
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.only(top: 8),
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Filter',
                              style: TextStyle(
                                fontFamily: 'IBMPlexMono-Regular',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppearancePage.foreground(context),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Icon(
                              Icons.tune,
                              size: 17,
                              color: AppearancePage.icon(context),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      BlocSelector<ShopBloc, ShopState, String>(
                        selector: (state) => state.sortLabel,
                        builder: (context, sortLabel) => InkWell(
                          onTap: () => context
                              .read<ShopBloc>()
                              .add(const ShopSortCycled()),
                          child: Row(
                            children: [
                              Text(
                                'Sort: $sortLabel',
                                style: TextStyle(
                                  fontFamily: 'IBMPlexMono-Regular',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppearancePage.foreground(context),
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 17,
                                color: AppearancePage.icon(context),
                              ),
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
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              product.image,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            // Bookmark button pinned to the top-right of the
                            // product image.
                            Positioned(
                              top: 8,
                              right: 8,
                              child: _SaveButton(productId: product.id),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'GeneralSans-Medium',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.25,
                          color: AppearancePage.foreground(context),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '\$${product.price}',
                            style: TextStyle(
                              fontFamily: 'GeneralSans-Semibold',
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppearancePage.foreground(context),
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () => context
                                .read<ShopBloc>()
                                .add(const ShopCartItemAdded()),
                            child: Icon(
                              Icons.add_circle_outline,
                              size: 17,
                              color: AppearancePage.icon(context),
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

/// Bookmark toggle pinned to the top-right corner of a product card.
///
/// Reads its saved flag from [ShopBloc] via [BlocSelector] so only the
/// button that actually flipped rebuilds — not every card in the grid.
class _SaveButton extends StatelessWidget {
  const _SaveButton({required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ShopBloc, ShopState, bool>(
      selector: (state) => state.isSaved(productId),
      builder: (context, saved) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () => context
                .read<ShopBloc>()
                .add(ShopProductSaveToggled(productId)),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: SvgPicture.asset(
                saved
                    ? 'assets/icons/save_active.svg'
                    : 'assets/icons/save_post.svg',
                width: 22,
                height: 22,
                // Only tint the outline version. The active SVG carries its
                // own filled colour.
                colorFilter: saved
                    ? null
                    : AppearancePage.iconFilter(context),
              ),
            ),
          ),
        );
      },
    );
  }
}*/










import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../routes/app_route.dart';
import '../../../screens/appearance/appearance_page.dart';
import '../../../screens/main_shell/cubit/main_shell_cubit.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/notification_line_mapper.dart';
import '../bloc/shop_bloc.dart';
import '../data/shop_data.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      appBar: AppBar(
        backgroundColor: AppearancePage.background(context),
        scrolledUnderElevation: 0,
        leadingWidth: 96,
        leading: Row(
          children: [
            IconButton(
              onPressed: () async {
                final result = await Navigator.of(
                  context,
                ).pushNamed(AppRoute.search);
                if (result == AppRoute.shop && context.mounted) {
                  context.read<MainShellCubit>().switchTab(1);
                }
              },
              icon: SvgPicture.asset(
                'assets/icons/search.svg',
                width: 24,
                height: 24,
                colorFilter: AppearancePage.iconFilter(context),
              ),
            ),
          ],
        ),
        centerTitle: true,
        title: SvgPicture.asset(
          'assets/icons/text_logo.svg',
          width: 78,
          height: 24,
          fit: BoxFit.contain,
        ),
        actions: [
          BlocSelector<ShopBloc, ShopState, int>(
            selector: (state) => state.cartCount,
            builder: (context, cartCount) => IconButton(
              onPressed: () => Navigator.of(context).pushNamed(AppRoute.cart),
              icon: Badge(
                label: Text(
                  '$cartCount',
                  style: const TextStyle(
                    fontFamily: 'GeneralSans-Regular',
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: KolekColors.blue600,
                child: SvgPicture.asset(
                  'assets/icons/cart.svg',
                  width: 24,
                  height: 24,
                  colorFilter: AppearancePage.iconFilter(context),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoute.notifications),
            icon: SvgPicture.asset(
              'assets/icons/notification_active.svg',
              width: 24,
              height: 24,
              colorMapper:
              NotificationLineMapper(AppearancePage.icon(context)),
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
                    style: TextStyle(
                      fontFamily: 'GeneralSans-Semibold',
                      fontSize: 60,
                      fontWeight: FontWeight.w600,
                      height: 1,
                      color: AppearancePage.foreground(context),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    ShopData.subtitle,
                    style: TextStyle(
                      fontFamily: 'IBMPlexMono-Regular',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                      color: AppearancePage.secondary(context),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Divider(color: AppearancePage.line(context)),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () async {
                          await Navigator.of(context)
                              .pushNamed(AppRoute.filter);
                          if (context.mounted) {
                            context
                                .read<ShopBloc>()
                                .add(const ShopFilterApplied());
                          }
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.only(top: 8),
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Filter',
                              style: TextStyle(
                                fontFamily: 'IBMPlexMono-Regular',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppearancePage.foreground(context),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Icon(
                              Icons.tune,
                              size: 17,
                              color: AppearancePage.icon(context),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      BlocSelector<ShopBloc, ShopState, String>(
                        selector: (state) => state.sortLabel,
                        builder: (context, sortLabel) => InkWell(
                          onTap: () => context
                              .read<ShopBloc>()
                              .add(const ShopSortCycled()),
                          child: Row(
                            children: [
                              Text(
                                'Sort: $sortLabel',
                                style: TextStyle(
                                  fontFamily: 'IBMPlexMono-Regular',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppearancePage.foreground(context),
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                size: 17,
                                color: AppearancePage.icon(context),
                              ),
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
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              product.image,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            // Bookmark button pinned to the top-right.
                            Positioned(
                              top: 8,
                              right: 8,
                              child: _SaveButton(productId: product.id),
                            ),
                            // // Auction countdown badge, bottom-left.
                            // if (product.isAuction &&
                            //     product.auctionRemaining != null)
                            //   Positioned(
                            //     left: 8,
                            //     bottom: 8,
                            //     child: _AuctionTimerBadge(
                            //       remaining: product.auctionRemaining!,
                            //     ),
                            //   ),


                            // Auction countdown badge, bottom-right.
                            if (product.isAuction &&
                                product.auctionRemaining != null)
                              Positioned(
                                right: 8,
                                bottom: 8,
                                child: _AuctionTimerBadge(
                                  remaining: product.auctionRemaining!,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'GeneralSans-Medium',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.25,
                          color: AppearancePage.foreground(context),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '\$${product.price}',
                            style: TextStyle(
                              fontFamily: 'GeneralSans-Semibold',
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppearancePage.foreground(context),
                            ),
                          ),
                          const Spacer(),
                          // Auction products get the gavel icon; regular
                          // products get the add-to-cart icon.
                          if (product.isAuction)
                            SvgPicture.asset(
                              'assets/icons/auction.svg',
                              width: 20,
                              height: 20,
                              colorFilter: AppearancePage.iconFilter(context),
                            )
                          else
                            InkWell(
                              onTap: () => context
                                  .read<ShopBloc>()
                                  .add(const ShopCartItemAdded()),
                              child: Icon(
                                Icons.add_circle_outline,
                                size: 17,
                                color: AppearancePage.icon(context),
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

/// Bookmark toggle pinned to the top-right corner of a product card.
class _SaveButton extends StatelessWidget {
  const _SaveButton({required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ShopBloc, ShopState, bool>(
      selector: (state) => state.isSaved(productId),
      builder: (context, saved) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () => context
                .read<ShopBloc>()
                .add(ShopProductSaveToggled(productId)),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: SvgPicture.asset(
                saved
                    ? 'assets/icons/save_active.svg'
                    : 'assets/icons/save_post.svg',
                width: 22,
                height: 22,
                colorFilter: saved
                    ? null
                    : AppearancePage.iconFilter(context),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Live countdown badge for auction products.
///
/// Starts from [remaining] on first mount and ticks down once per second.
/// Format matches the design: `02d : 07h : 01m`.
class _AuctionTimerBadge extends StatefulWidget {
  const _AuctionTimerBadge({required this.remaining});

  final Duration remaining;

  @override
  State<_AuctionTimerBadge> createState() => _AuctionTimerBadgeState();
}

class _AuctionTimerBadgeState extends State<_AuctionTimerBadge> {
  static const _tick = Duration(seconds: 1);

  late Duration _remaining;
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _remaining = widget.remaining;
    _ticker = Timer.periodic(_tick, (_) {
      if (!mounted) return;
      setState(() {
        final next = _remaining - _tick;
        _remaining = next.isNegative ? Duration.zero : next;
      });
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  String _format(Duration d) {
    final days = d.inDays;
    final hours = d.inHours.remainder(24);
    final minutes = d.inMinutes.remainder(60);
    return '${_two(days)}d : ${_two(hours)}h : ${_two(minutes)}m';
  }

  String _two(int value) => value.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F0FF),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.schedule,
            size: 13,
            color: KolekColors.blue600,
          ),
          const SizedBox(width: 4),
          Text(
            _format(_remaining),
            style: const TextStyle(
              fontFamily: 'IBMPlexMono-Medium',
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: KolekColors.blue600,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}