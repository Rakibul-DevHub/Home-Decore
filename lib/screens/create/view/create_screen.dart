import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../routes/app_route.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../data/create_data.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 8, 10, 0),
              child: Row(
                children: [
                  const KolekTextLogo(height: 20),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.cancel, size: 28),
                  ),
                ],
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight - 24,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        CreateData.title,
                                        softWrap: true,
                                        style: KolekText.sans(
                                          size: 34,
                                          weight: FontWeight.w700,
                                          height: 1.05,
                                        ),
                                      ),
                                      const SizedBox(height: 14),
                                      Text(
                                        CreateData.subtitle,
                                        softWrap: true,
                                        style: KolekText.mono(
                                          size: 11,
                                          color: KolekColors.neutral600,
                                          height: 1.45,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                SizedBox(
                                  width: 110,
                                  height: 132,
                                  child: Image.asset(
                                    CreateData.heroImage,
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, _, _) => const ColoredBox(
                                      color: KolekColors.neutral100,
                                      child: Icon(
                                        Icons.image_outlined,
                                        color: KolekColors.neutral400,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const SizedBox(height: 28),
                            _CreateActionCard(
                              title: CreateData.createPostTitle,
                              subtitle: CreateData.createPostSubtitle,
                              onTap: () => Navigator.of(
                                context,
                              ).pushNamed(AppRoute.newPost),
                            ),
                            const SizedBox(height: 12),
                            _CreateActionCard(
                              title: CreateData.listProductTitle,
                              subtitle: CreateData.listProductSubtitle,
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'List a Product coming soon',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
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

class _CreateActionCard extends StatelessWidget {
  const _CreateActionCard({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 18, 12, 18),
          decoration: BoxDecoration(
            border: Border.all(color: KolekColors.neutral900, width: 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: KolekText.sans(
                        size: 16,
                        weight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      softWrap: true,
                      style: KolekText.mono(
                        size: 10,
                        color: KolekColors.neutral600,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SvgPicture.asset(
                'assets/icons/arrow_right.svg',
                width: 18,
                height: 18,
                colorFilter: const ColorFilter.mode(
                  KolekColors.neutral900,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
