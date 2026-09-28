part of 'home_screen.dart';

class _KolekHeader extends StatelessWidget implements PreferredSizeWidget {
  const _KolekHeader();

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final colors = _HomeColors.of(context);
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: colors.canvas,
      systemOverlayStyle: colors.overlay,
      centerTitle: true,
      leading: IconButton(
        onPressed: () async {
          final result = await Navigator.of(context).pushNamed(AppRoute.search);
          if (result == AppRoute.shop && context.mounted) {
            context.read<MainShellCubit>().switchTab(1);
          }
        },
        icon: SvgPicture.asset(
          'assets/icons/search.svg',
          width: 22,
          height: 22,
          colorFilter: colors.iconFilter,
        ),
      ),
      title: SvgPicture.asset(
        'assets/icons/text_logo.svg',
        height: 22,
        fit: BoxFit.contain,
        colorFilter: colors.textFilter,
      ),
      actions: [
        IconButton(
          onPressed: () =>
              Navigator.of(context).pushNamed(AppRoute.notifications),
          icon: SvgPicture.asset(
            'assets/icons/notification_active.svg',
            width: 24,
            height: 24,
            colorFilter: colors.iconFilter,
          ),
        ),
        const SizedBox(width: 2),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(height: 1, thickness: 1, color: colors.line),
      ),
    );
  }
}
