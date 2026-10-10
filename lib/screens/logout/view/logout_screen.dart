import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../routes/app_route.dart';
import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../bloc/logout_bloc.dart';
import '../bloc/logout_event.dart';
import '../bloc/logout_state.dart';
import '../data/logout_data.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: BlocListener<LogoutBloc, LogoutState>(
          listenWhen: (prev, next) => !prev.loggingOut && next.loggingOut,
          listener: (context, state) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.signIn,
                  (_) => false,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _LogoutAppBar(),
              Divider(
                height: 1,
                thickness: 0.5,
                color: AppearancePage.line(context),
              ),
              const Expanded(child: _LogoutBody()),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// App bar — back arrow + "Log Out"
// ─────────────────────────────────────────────────────────────────────────

class _LogoutAppBar extends StatelessWidget {
  const _LogoutAppBar();

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints:
            const BoxConstraints(minWidth: 40, minHeight: 40),
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back, size: 24, color: fg),
          ),
          const SizedBox(width: 4),
          Text(
            LogoutData.appBarTitle,
            style: KolekText.sans(
              size: 20,
              weight: FontWeight.w600,
              height: 1.0,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Body — logo + copy + buttons, with logout.svg pinned to the bottom
// ─────────────────────────────────────────────────────────────────────────

class _LogoutBody extends StatelessWidget {
  const _LogoutBody();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ── Bottom decoration: logout.svg stretches to fill the width
        //    and sits flush against the bottom edge.
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: SvgPicture.asset(
            LogoutData.bottomDecorationAsset,
            width: double.infinity,
            height: 260,
            fit: BoxFit.fill,
            alignment: Alignment.bottomCenter,
          ),
        ),

        // ── Content, vertically centered above the decoration.
        Positioned.fill(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 24, 18, 240),
              child: const _ContentBlock(),
            ),
          ),
        ),
      ],
    );
  }
}

class _ContentBlock extends StatelessWidget {
  const _ContentBlock();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Logo: logo_textUnder.svg ──────────────────────────────
        SvgPicture.asset(
          LogoutData.logoAsset,
          height: 96,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 44),

        // ── Heading ──────────────────────────────────────────────
        Text(
          LogoutData.heading,
          textAlign: TextAlign.center,
          style: KolekText.sans(
            size: 22,
            weight: FontWeight.w600,
            height: 1.2,
            color: AppearancePage.foreground(context),
          ),
        ),
        const SizedBox(height: 12),

        // ── Subtitle ─────────────────────────────────────────────
        Text(
          LogoutData.subtitle,
          textAlign: TextAlign.center,
          style: KolekText.sans(
            size: 13,
            weight: FontWeight.w400,
            height: 1.5,
            color: AppearancePage.muted(context),
          ),
        ),
        const SizedBox(height: 44),

        // ── Buttons ──────────────────────────────────────────────
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 34),
          child: _ButtonsBlock(),
        ),
      ],
    );
  }
}

class _ButtonsBlock extends StatelessWidget {
  const _ButtonsBlock();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _OutlineButton(
          label: LogoutData.confirmLabel,
          onTap: () =>
              context.read<LogoutBloc>().add(const LogoutConfirmed()),
        ),
        const SizedBox(height: 14),
        _OutlineButton(
          label: LogoutData.cancelLabel,
          onTap: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Outline button
// ─────────────────────────────────────────────────────────────────────────

class _OutlineButton extends StatelessWidget {
  const _OutlineButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);
    final line = AppearancePage.line(context);

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          foregroundColor: fg,
          backgroundColor: AppearancePage.background(context),
          side: BorderSide(color: line),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          textStyle: KolekText.sans(
            size: 15,
            weight: FontWeight.w500,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}