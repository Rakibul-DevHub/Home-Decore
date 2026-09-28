import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../routes/app_route.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';
import '../bloc/search_state.dart';
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
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, size: 22),
        ),
        centerTitle: true,
        title: const KolekTextLogo(height: 22),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoute.notifications),
            icon: SvgPicture.asset(
              'assets/icons/notification_active.svg',
              width: 22,
              height: 22,
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: KolekColors.neutral200),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: TextField(
              onChanged: (value) => context
                  .read<SearchBloc>()
                  .add(SearchQueryChanged(value)),
              style: KolekText.mono(size: 16),
              decoration: InputDecoration(
                hintText: 'Search Person',
                hintStyle: KolekText.mono(
                  size: 16,
                  color: KolekColors.neutral900,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 8),
                  child: SvgPicture.asset(
                    'assets/icons/search.svg',
                    width: 20,
                    height: 20,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 44,
                  minHeight: 44,
                ),
                filled: true,
                fillColor: KolekColors.neutral200,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: Row(
              children: [
                Text(
                  'Recent Searches',
                  style: KolekText.sans(size: 18, weight: FontWeight.w500),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => context
                      .read<SearchBloc>()
                      .add(const SearchRecentCleared()),
                  child: Text(
                    'Clear All',
                    style: KolekText.mono(
                      size: 14,
                      weight: FontWeight.w500,
                      color: KolekColors.blue600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                final people = state.visible;
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                  itemCount: people.length,
                  separatorBuilder: (_, _) => const Divider(
                    height: 1,
                    thickness: 1,
                    color: KolekColors.neutral100,
                  ),
                  itemBuilder: (context, index) {
                    final person = people[index];
                    return _PersonRow(
                      person: person,
                      onRemove: () =>
                          context
                              .read<SearchBloc>()
                              .add(SearchPersonRemoved(person.id)),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PersonRow extends StatelessWidget {
  const _PersonRow({required this.person, required this.onRemove});

  final SearchPerson person;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          _Avatar(person: person),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  person.name,
                  style: KolekText.sans(
                    size: 16,
                    weight: FontWeight.w500,
                    color: KolekColors.neutral800,
                  ),
                ),
                if (person.handle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    person.handle!,
                    style: KolekText.mono(
                      size: 14,
                      color: KolekColors.neutral500,
                    ),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            onPressed: onRemove,
            icon: const Icon(Icons.close, size: 20, color: KolekColors.neutral700),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.person});

  final SearchPerson person;

  @override
  Widget build(BuildContext context) {
    final avatar = person.avatarAsset;
    if (avatar == null) {
      return const SizedBox(
        width: 52,
        height: 52,
        child: Icon(
          Icons.history,
          size: 22,
          color: KolekColors.neutral700,
        ),
      );
    }
    return ClipOval(
      child: Image.asset(avatar, width: 52, height: 52, fit: BoxFit.cover),
    );
  }
}
