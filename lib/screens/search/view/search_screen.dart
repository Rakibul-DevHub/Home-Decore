import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/app_route.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../cubit/search_cubit.dart';
import '../data/search_data.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KolekColors.neutral50,
      appBar: AppBar(
        backgroundColor: KolekColors.neutral50,
        scrolledUnderElevation: 0,
        leading: const Icon(Icons.arrow_back, size: 21),
        centerTitle: true,
        title: Text(
          'kolek',
          style: KolekText.mono(size: 22, color: KolekColors.blue600),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 24),
        children: [
          TextField(
            textInputAction: TextInputAction.search,
            onChanged: context.read<SearchCubit>().queryChanged,
            onSubmitted: (value) {
              context.read<SearchCubit>().submit(value);
              Navigator.of(context).pushNamed(AppRoute.shop);
            },
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: KolekText.sans(size: 14),
              prefixIcon: const Icon(Icons.search, size: 21),
              filled: true,
              fillColor: KolekColors.neutral200,
              border: InputBorder.none,
            ),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              Text('Recent Searches', style: KolekText.sans(size: 14)),
              const Spacer(),
              TextButton(
                onPressed: context.read<SearchCubit>().clearRecent,
                child: Text(
                  'Clear All',
                  style: KolekText.mono(size: 11, color: KolekColors.blue600),
                ),
              ),
            ],
          ),
          BlocSelector<SearchCubit, SearchState, List<String>>(
            selector: (state) => state.recentSearches,
            builder: (context, recentSearches) => Wrap(
              spacing: 8,
              runSpacing: 8,
              children: recentSearches
                  .map(
                    (item) => Chip(
                      label: Text(item, style: KolekText.mono(size: 10)),
                      deleteIcon: const Icon(Icons.close, size: 14),
                      onDeleted: () =>
                          context.read<SearchCubit>().removeRecent(item),
                      backgroundColor: KolekColors.neutral50,
                      side: const BorderSide(color: KolekColors.neutral300),
                      shape: const RoundedRectangleBorder(),
                      padding: EdgeInsets.zero,
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 22),
          Text('Popular Searches', style: KolekText.sans(size: 14)),
          const SizedBox(height: 8),
          ...SearchData.popular.map(
            (item) => InkWell(
              key: ValueKey('popular-$item'),
              onTap: () {
                context.read<SearchCubit>().submit(item);
                Navigator.of(context).pushNamed(AppRoute.shop);
              },
              child: Container(
                height: 57,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: KolekColors.neutral200),
                  ),
                ),
                child: Row(
                  children: [
                    Text(item, style: KolekText.mono(size: 11)),
                    const Spacer(),
                    const Icon(Icons.chevron_right, size: 18),
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
