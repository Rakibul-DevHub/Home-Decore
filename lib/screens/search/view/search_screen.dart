import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../screens/appearance/appearance_page.dart';
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppearancePage.overlay(context),
      child: Scaffold(
        backgroundColor: AppearancePage.background(context),
        appBar: AppBar(
          backgroundColor: AppearancePage.background(context),
          scrolledUnderElevation: 0,
          systemOverlayStyle: AppearancePage.overlay(context),
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              size: 22,
              color: AppearancePage.foreground(context),
            ),
          ),
          centerTitle: true,
          title: SvgPicture.asset(
            'assets/icons/text_logo.svg',
            height: 22,
            fit: BoxFit.contain,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Divider(
              height: 1,
              thickness: 1,
              color: AppearancePage.line(context),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: TextField(
                onChanged: (value) =>
                    context.read<SearchBloc>().add(SearchQueryChanged(value)),
                style: KolekText.mono(
                  size: 16,
                  color: AppearancePage.foreground(context),
                ),
                cursorColor: AppearancePage.foreground(context),
                decoration: InputDecoration(
                  hintText: 'Search Person',
                  hintStyle: KolekText.mono(
                    size: 16,
                    color: AppearancePage.muted(context),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 8),
                    child: SvgPicture.asset(
                      'assets/icons/search.svg',
                      width: 20,
                      height: 20,
                      fit: BoxFit.scaleDown,
                      colorFilter: AppearancePage.iconFilter(context),
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                  ),
                  filled: true,
                  fillColor: AppearancePage.field(context),
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
                    style: KolekText.sans(
                      size: 18,
                      weight: FontWeight.w500,
                      color: AppearancePage.foreground(context),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => context.read<SearchBloc>().add(
                      const SearchRecentCleared(),
                    ),
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
                    separatorBuilder: (_, _) => Divider(
                      height: 1,
                      thickness: 1,
                      color: AppearancePage.line(context),
                    ),
                    itemBuilder: (context, index) {
                      final person = people[index];
                      return _PersonRow(
                        person: person,
                        onRemove: () => context.read<SearchBloc>().add(
                          SearchPersonRemoved(person.id),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
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
        crossAxisAlignment: CrossAxisAlignment.center,
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
                    color: AppearancePage.foreground(context),
                  ),
                ),
                if (person.handle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    person.handle!,
                    style: KolekText.mono(
                      size: 14,
                      color: AppearancePage.muted(context),
                    ),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            onPressed: onRemove,
            icon: Icon(
              Icons.close,
              size: 20,
              color: AppearancePage.icon(context),
            ),
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
    return SizedBox(
      width: 46,
      height: 46,
      child: avatar == null
          ? Center(
              child: Icon(
                Icons.history,
                size: 24,
                color: AppearancePage.icon(context),
              ),
            )
          : ClipOval(
              child: Image.asset(
                avatar,
                width: 46,
                height: 46,
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}
