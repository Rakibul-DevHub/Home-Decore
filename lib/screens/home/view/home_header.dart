part of 'home_screen.dart';

class _KolekHeader extends StatelessWidget {
  const _KolekHeader();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // Hide on scroll down, come back on scroll up.
      floating: true,
      snap: true,

      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppearancePage.background(context),
      foregroundColor: AppearancePage.foreground(context),
      systemOverlayStyle: AppearancePage.overlay(context),
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
          colorFilter: AppearancePage.iconFilter(context),
        ),
      ),
      title: SvgPicture.asset(
        'assets/icons/text_logo.svg',
        height: 22,
        fit: BoxFit.contain,
      ),
      actions: [
        // // ⚠️ TEMPORARY: theme toggle. Remove once a real appearance
        // // settings screen exists.
        // IconButton(
        //   tooltip: 'Toggle theme (temp)',
        //   onPressed: AppearancePage.toggleThemeMode,
        //   icon: Icon(
        //     AppearancePage.isDark(context)
        //         ? Icons.light_mode_outlined
        //         : Icons.dark_mode_outlined,
        //     size: 22,
        //     color: AppearancePage.icon(context),
        //   ),
        // ),
        IconButton(
          onPressed: () =>
              Navigator.of(context).pushNamed(AppRoute.notifications),
          icon: SvgPicture.asset(
            'assets/icons/notification_active.svg',
            width: 24,
            height: 24,
            colorMapper: NotificationLineMapper(AppearancePage.icon(context)),
          ),
        ),
        const SizedBox(width: 2),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(
          height: 1,
          thickness: 1,
          color: AppearancePage.line(context),
        ),
      ),
    );
  }
}
