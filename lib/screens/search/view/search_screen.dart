import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../routes/app_route.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../cubit/search_cubit.dart';
import '../data/search_data.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  void _goToShop(BuildContext context) {
    Navigator.of(context).pop(AppRoute.shop);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, size: 22),
        ),
        centerTitle: true,
        title: const KolekTextLogo(height: 22),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                SvgPicture.asset(
                  'assets/icons/notification.svg',
                  width: 22,
                  height: 22,
                ),
                Positioned(
                  right: -1,
                  top: -1,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: KolekColors.blue600,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: KolekColors.neutral200),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
        children: [
          TextField(
            textInputAction: TextInputAction.search,
            onChanged: context.read<SearchCubit>().queryChanged,
            onSubmitted: (value) {
              context.read<SearchCubit>().submit(value);
              _goToShop(context);
            },
            style: KolekText.sans(size: 14),
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: KolekText.sans(
                size: 14,
                color: KolekColors.neutral500,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 14, right: 8),
                child: SvgPicture.asset(
                  'assets/icons/search.svg',
                  width: 18,
                  height: 18,
                  fit: BoxFit.scaleDown,
                ),
              ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 40,
                minHeight: 40,
              ),
              filled: true,
              fillColor: KolekColors.neutral100,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              Text(
                'Recent Searches',
                style: KolekText.sans(size: 14, weight: FontWeight.w700),
              ),
              const Spacer(),
              GestureDetector(
                onTap: context.read<SearchCubit>().clearRecent,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'Clear All',
                    style: KolekText.mono(
                      size: 11,
                      color: KolekColors.blue600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          BlocSelector<SearchCubit, SearchState, List<String>>(
            selector: (state) => state.recentSearches,
            builder: (context, recentSearches) => Wrap(
              spacing: 8,
              runSpacing: 8,
              children: recentSearches
                  .map(
                    (item) => _RecentSearchChip(
                      label: item,
                      onDeleted: () =>
                          context.read<SearchCubit>().removeRecent(item),
                      onTap: () {
                        context.read<SearchCubit>().submit(item);
                        _goToShop(context);
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 28),
          Text(
            'Popular Searches',
            style: KolekText.sans(size: 14, weight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, thickness: 1, color: KolekColors.neutral200),
          ...SearchData.popular.map(
            (item) => InkWell(
              key: ValueKey('popular-$item'),
              onTap: () {
                context.read<SearchCubit>().submit(item);
                _goToShop(context);
              },
              child: Container(
                height: 52,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: KolekColors.neutral200),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(item, style: KolekText.mono(size: 12)),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      size: 18,
                      color: KolekColors.neutral400,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentSearchChip extends StatelessWidget {
  const _RecentSearchChip({
    required this.label,
    required this.onDeleted,
    required this.onTap,
  });

  final String label;
  final VoidCallback onDeleted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: const BorderSide(color: KolekColors.neutral200),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 8, 8, 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: KolekText.mono(
                  size: 11,
                  color: KolekColors.neutral500,
                ),
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: onDeleted,
                behavior: HitTestBehavior.opaque,
                child: const Padding(
                  padding: EdgeInsets.all(2),
                  child: Icon(
                    Icons.close,
                    size: 14,
                    color: KolekColors.neutral500,
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
