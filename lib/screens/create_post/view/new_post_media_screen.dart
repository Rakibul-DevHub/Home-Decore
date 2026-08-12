import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/app_route.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../cubit/new_post_cubit.dart';
import '../data/new_post_data.dart';
import 'new_post_details_screen.dart';

class NewPostMediaScreen extends StatefulWidget {
  const NewPostMediaScreen({super.key});

  @override
  State<NewPostMediaScreen> createState() => _NewPostMediaScreenState();
}

class _NewPostMediaScreenState extends State<NewPostMediaScreen> {
  bool _isFullScreen = false;

  static const _overlayStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.transparent,
  );

  @override
  void dispose() {
    _restoreSystemUi();
    super.dispose();
  }

  Future<void> _enterFullScreen() async {
    setState(() => _isFullScreen = true);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  Future<void> _exitFullScreen() async {
    setState(() => _isFullScreen = false);
    await _restoreSystemUi();
  }

  Future<void> _restoreSystemUi() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(_overlayStyle);
  }

  void _openDetails(BuildContext context) {
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
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isFullScreen,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && _isFullScreen) {
          _exitFullScreen();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _isFullScreen
            ? null
            : AppBar(
                backgroundColor: Colors.white,
                scrolledUnderElevation: 0,
                systemOverlayStyle: _overlayStyle,
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
                    onPressed: () => _openDetails(context),
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

            if (_isFullScreen) {
              return _FullScreenPreview(
                imagePath: preview,
                onClose: _exitFullScreen,
              );
            }

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
                        child: Material(
                          color: Colors.white,
                          shape: const CircleBorder(),
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: _enterFullScreen,
                            child: const SizedBox(
                              width: 32,
                              height: 32,
                              child: Icon(
                                Icons.open_in_full,
                                size: 16,
                                color: KolekColors.neutral900,
                              ),
                            ),
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
      ),
    );
  }
}

class _FullScreenPreview extends StatelessWidget {
  const _FullScreenPreview({
    required this.imagePath,
    required this.onClose,
  });

  final String imagePath;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + 8,
            left: 8,
            child: IconButton(
              onPressed: onClose,
              style: IconButton.styleFrom(
                backgroundColor: Colors.black54,
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.close, size: 22),
            ),
          ),
          Positioned(
            right: 12,
            bottom: MediaQuery.paddingOf(context).bottom + 12,
            child: Material(
              color: Colors.white,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onClose,
                child: const SizedBox(
                  width: 36,
                  height: 36,
                  child: Icon(
                    Icons.close_fullscreen,
                    size: 18,
                    color: KolekColors.neutral900,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
