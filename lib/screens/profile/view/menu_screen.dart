import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../bloc/menu_bloc.dart';
import '../bloc/menu_event.dart';
import '../bloc/menu_state.dart';
import '../data/menu_data.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  /// Row id → route name. Extend as more screens are wired.
  static const _routes = <String, String>{
    // 'saved': AppRoute.saved,
    // 'orders': AppRoute.orders,
    // 'selling': AppRoute.selling,
    // 'offers': AppRoute.offers,
    // 'settings': AppRoute.settings,
    // 'invite': AppRoute.invite,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: BlocListener<MenuBloc, MenuState>(
          listenWhen: (prev, next) => prev.loggingOut != next.loggingOut,
          listener: (context, state) {
            if (!state.loggingOut) return;
            // TODO: navigate to the login route once it exists.
            // Navigator.of(context).pushNamedAndRemoveUntil(
            //   AppRoute.login,
            //   (_) => false,
            // );
          },
          child: Column(
            children: [
              const _MenuHeader(),
              const Divider(
                height: 1,
                thickness: 0.5,
                color: KolekColors.neutral200,
              ),
              const _UserCard(),
              const Divider(
                height: 1,
                thickness: 0.5,
                color: KolekColors.neutral200,
              ),
              Expanded(
                child: BlocBuilder<MenuBloc, MenuState>(
                  builder: (context, state) {
                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: state.items.length,
                      separatorBuilder: (_, _) => Divider(
                        height: 1,
                        thickness: 0.5,
                        indent: 18,
                        endIndent: 18,
                        color: AppearancePage.line(context),
                      ),
                      itemBuilder: (context, index) {
                        final item = state.items[index];
                        return _MenuRow(
                          item: item,
                          onTap: () {
                            context
                                .read<MenuBloc>()
                                .add(MenuItemTapped(item.id));
                            final route = _routes[item.id];
                            if (route != null) {
                              Navigator.of(context).pushNamed(route);
                            }
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              const _LogoutFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Header — back arrow + "Menu"
// ─────────────────────────────────────────────────────────────────────────

class _MenuHeader extends StatelessWidget {
  const _MenuHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 6, 18, 12),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back,
              size: 22,
              color: AppearancePage.icon(context),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            'Menu',
            style: TextStyle(
              fontFamily: 'GeneralSans-Medium',
              fontSize: 26,
              fontWeight: FontWeight.w500,
              height: 1.0,
              color: AppearancePage.foreground(context),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// User card — avatar + name + handle
// ─────────────────────────────────────────────────────────────────────────

class _UserCard extends StatelessWidget {
  const _UserCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              MenuData.userAvatar,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  MenuData.userName,
                  style: TextStyle(
                    fontFamily: 'GeneralSans-Medium',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                    color: AppearancePage.foreground(context),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  MenuData.userHandle,
                  style: TextStyle(
                    fontFamily: 'IBMPlexMono-Regular',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                    color: AppearancePage.muted(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Menu row — icon + title + subtitle + chevron
// ─────────────────────────────────────────────────────────────────────────

class _MenuRow extends StatelessWidget {
  const _MenuRow({required this.item, required this.onTap});

  final MenuItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
        child: Row(
          children: [
            SvgPicture.asset(
              item.iconAsset,
              width: 22,
              height: 22,
              colorFilter: AppearancePage.iconFilter(context),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontFamily: 'GeneralSans-Medium',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                      color: AppearancePage.foreground(context),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.subtitle,
                    style: TextStyle(
                      fontFamily: 'IBMPlexMono-Regular',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 1.3,
                      color: AppearancePage.muted(context),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Icon(
              Icons.chevron_right,
              size: 22,
              color: AppearancePage.icon(context),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Logout + version footer
// ─────────────────────────────────────────────────────────────────────────

class _LogoutFooter extends StatelessWidget {
  const _LogoutFooter();

  static const _logoutColor = Color(0xFFE5484D);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 16),
      child: Column(
        children: [
          InkWell(
            onTap: () =>
                context.read<MenuBloc>().add(const MenuLogoutRequested()),
            borderRadius: BorderRadius.circular(6),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.logout, size: 18, color: _logoutColor),
                  SizedBox(width: 8),
                  Text(
                    'Log Out',
                    style: TextStyle(
                      fontFamily: 'GeneralSans-Medium',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      height: 1.0,
                      color: _logoutColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            MenuData.versionFooter,
            style: TextStyle(
              fontFamily: 'IBMPlexMono-Regular',
              fontSize: 11,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.4,
              color: AppearancePage.muted(context),
            ),
          ),
        ],
      ),
    );
  }
}