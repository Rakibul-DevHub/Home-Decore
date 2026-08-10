import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/app_route.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../cubit/new_post_cubit.dart';
import '../data/new_post_data.dart';

class NewPostDetailsScreen extends StatelessWidget {
  const NewPostDetailsScreen({super.key});

  IconData _iconFor(String label) => switch (label) {
    'Add Location' => Icons.location_on_outlined,
    'Add Hashtags' => Icons.tag,
    'Connect Product' => Icons.link,
    _ => Icons.tune,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.cancel, size: 28),
        ),
        centerTitle: true,
        title: Text(
          'New Post',
          style: KolekText.sans(size: 16, weight: FontWeight.w700),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).popUntil(
                (route) => route.settings.name == AppRoute.mainShell,
              );
            },
            child: Text(
              'Share',
              style: KolekText.sans(
                size: 14,
                weight: FontWeight.w600,
                color: KolekColors.blue600,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<NewPostCubit, NewPostState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              SizedBox(
                height: 78,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.selectedIndexes.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final galleryIndex = state.selectedIndexes[index];
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.asset(
                            NewPostData.gallery[galleryIndex],
                            width: 72,
                            height: 72,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: -4,
                          right: -4,
                          child: GestureDetector(
                            onTap: () => context
                                .read<NewPostCubit>()
                                .removeSelected(galleryIndex),
                            child: const CircleAvatar(
                              radius: 9,
                              backgroundColor: Colors.black,
                              child: Icon(
                                Icons.close,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                maxLines: 5,
                minLines: 4,
                onChanged: context.read<NewPostCubit>().captionChanged,
                decoration: InputDecoration(
                  hintText: 'Write a caption.',
                  hintStyle: KolekText.sans(
                    size: 14,
                    color: KolekColors.neutral400,
                  ),
                  border: InputBorder.none,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${state.caption.length}/${NewPostData.maxCaptionLength}',
                  style: KolekText.mono(
                    size: 10,
                    color: KolekColors.neutral400,
                  ),
                ),
              ),
              const Divider(height: 28),
              ...NewPostData.settings.map(
                (label) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(_iconFor(label), size: 22),
                  title: Text(label, style: KolekText.sans(size: 14)),
                  trailing: const Icon(Icons.chevron_right, size: 20),
                  onTap: () {},
                ),
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.fromLTRB(16, 18, 12, 12),
                decoration: BoxDecoration(
                  color: KolekColors.neutral100,
                  border: Border.all(color: KolekColors.neutral200),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const KolekTextLogo(height: 18),
                          const SizedBox(height: 10),
                          Text(
                            NewPostData.footerTagline,
                            style: KolekText.sans(
                              size: 13,
                              weight: FontWeight.w600,
                              height: 1.25,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: 28,
                            height: 2,
                            color: KolekColors.neutral900,
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      NewPostData.footerArt,
                      width: 84,
                      height: 96,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
