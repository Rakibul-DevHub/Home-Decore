import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/app_route.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../cubit/new_post_cubit.dart';
import '../data/new_post_data.dart';
import 'new_post_details_screen.dart';

class NewPostMediaScreen extends StatelessWidget {
  const NewPostMediaScreen({super.key});

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
              final cubit = context.read<NewPostCubit>();
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  settings: const RouteSettings(name: AppRoute.newPostDetails),
                  builder: (_) => BlocProvider.value(
                    value: cubit,
                    child: const NewPostDetailsScreen(),
                  ),
                ),
              );
            },
            child: Text(
              'Next',
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
          final preview = NewPostData.gallery[state.previewIndex];
          return Column(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(preview, fit: BoxFit.cover),
                    Positioned(
                      right: 12,
                      bottom: 12,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.open_in_full,
                          size: 16,
                          color: KolekColors.neutral900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Row(
                  children: [
                    Text('Recent', style: KolekText.sans(size: 14)),
                    const Icon(Icons.keyboard_arrow_down, size: 18),
                    const Spacer(),
                    const Icon(Icons.photo_camera_outlined, size: 22),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  itemCount: NewPostData.gallery.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemBuilder: (context, index) {
                    final selected = state.selectedIndexes.contains(index);
                    final badge = selected
                        ? state.selectedIndexes.indexOf(index) + 1
                        : null;
                    return GestureDetector(
                      onTap: () {
                        context.read<NewPostCubit>().toggleImage(index);
                        context.read<NewPostCubit>().setPreview(index);
                      },
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            NewPostData.gallery[index],
                            fit: BoxFit.cover,
                          ),
                          if (selected)
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: KolekColors.blue600,
                                  width: 3,
                                ),
                              ),
                            ),
                          if (badge != null)
                            Positioned(
                              top: 6,
                              right: 6,
                              child: CircleAvatar(
                                radius: 11,
                                backgroundColor: KolekColors.blue600,
                                child: Text(
                                  '$badge',
                                  style: KolekText.sans(
                                    size: 11,
                                    color: Colors.white,
                                    weight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
