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

  String _captionCountLabel(int length) {
    final max = NewPostData.maxCaptionLength;
    final maxLabel = max >= 1000
        ? '${max ~/ 1000},${(max % 1000).toString().padLeft(3, '0')}'
        : '$max';
    return '$length/$maxLabel';
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
          icon: Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: KolekColors.neutral950,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.close, size: 16, color: Colors.white),
          ),
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
                height: 86,
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
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            NewPostData.gallery[galleryIndex],
                            width: 68,
                            height: 78,
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
              const SizedBox(height: 12),
              TextField(
                maxLines: 4,
                minLines: 3,
                onChanged: context.read<NewPostCubit>().captionChanged,
                style: KolekText.sans(size: 14),
                decoration: InputDecoration(
                  hintText: 'Write a caption',
                  hintStyle: KolekText.sans(
                    size: 14,
                    color: KolekColors.neutral400,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  _captionCountLabel(state.caption.length),
                  style: KolekText.mono(
                    size: 10,
                    color: KolekColors.neutral400,
                  ),
                ),
              ),
              const Divider(height: 1, thickness: 1, color: KolekColors.neutral200),
              ...NewPostData.settings.map(
                (label) => Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      minLeadingWidth: 28,
                      visualDensity: const VisualDensity(vertical: -1),
                      leading: Icon(_iconFor(label), size: 22),
                      title: Text(label, style: KolekText.sans(size: 14)),
                      trailing: const Icon(Icons.chevron_right, size: 20),
                      onTap: () {},
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: KolekColors.neutral200,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const _FooterBrandCard(),
            ],
          );
        },
      ),
    );
  }
}

class _FooterBrandCard extends StatelessWidget {
  const _FooterBrandCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 132,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: KolekColors.neutral200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned(
            left: 16,
            top: 18,
            right: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const KolekTextLogo(height: 20),
                const SizedBox(height: 10),
                Text(
                  NewPostData.footerTagline,
                  style: KolekText.sans(
                    size: 13,
                    weight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: 26,
                  height: 3,
                  color: KolekColors.neutral900,
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            bottom: -4,
            child: Image.asset(
              NewPostData.footerArt,
              height: 128,
              fit: BoxFit.contain,
              alignment: Alignment.bottomRight,
            ),
          ),
        ],
      ),
    );
  }
}
