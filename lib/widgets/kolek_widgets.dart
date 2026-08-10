import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/kolek_colors.dart';
import 'screen_background.dart';

abstract final class KolekText {
  static TextStyle mono({
    double size = 16,
    FontWeight weight = FontWeight.w400,
    Color color = KolekColors.neutral900,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.ibmPlexMono(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle sans({
    double size = 16,
    FontWeight weight = FontWeight.w500,
    Color color = KolekColors.neutral900,
    double? height,
  }) {
    return GoogleFonts.inter(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
    );
  }
}

class KolekLogo extends StatelessWidget {
  const KolekLogo({super.key, this.size = 32});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/logo_k.svg',
      width: size,
      height: size,
    );
  }
}

class KolekButton extends StatelessWidget {
  const KolekButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.backgroundColor = KolekColors.blue600,
    this.foregroundColor = KolekColors.neutral50,
    this.borderColor,
    this.icon,
  });

  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
            side: borderColor == null
                ? BorderSide.none
                : BorderSide(color: borderColor!),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[icon!, const SizedBox(width: 10)],
            Text(
              label,
              style: KolekText.sans(
                size: 16,
                weight: FontWeight.w500,
                color: foregroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class KolekField extends StatelessWidget {
  const KolekField({
    required this.label,
    required this.hint,
    super.key,
    this.obscureText = false,
    this.onVisibilityPressed,
    this.keyboardType,
  });

  final String label;
  final String hint;
  final bool obscureText;
  final VoidCallback? onVisibilityPressed;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: KolekText.mono(size: 12, color: KolekColors.neutral800),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 56,
          child: TextFormField(
            initialValue: hint,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: KolekText.mono(size: 14),
            decoration: InputDecoration(
              filled: true,
              fillColor: KolekColors.neutral50,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 17,
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: KolekColors.neutral300),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: KolekColors.blue600),
              ),
              suffixIcon: onVisibilityPressed == null
                  ? null
                  : IconButton(
                      onPressed: onVisibilityPressed,
                      icon: Icon(
                        obscureText
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: KolekColors.neutral700,
                        size: 23,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

class AuthBackButton extends StatelessWidget {
  const AuthBackButton({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints.tightFor(width: 32, height: 32),
      icon: const Icon(
        Icons.arrow_back,
        size: 22,
        color: KolekColors.neutral700,
      ),
    );
  }
}

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    required this.routeName,
    required this.child,
    super.key,
    this.showBack = true,
  });

  final String routeName;
  final Widget child;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KolekColors.neutral50,
      body: SafeArea(
        child: Stack(
          children: [
            ScreenBackground(routeName: routeName),
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                      maxWidth: 400,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        if (showBack)
                          AuthBackButton(
                            onPressed: () => Navigator.of(context).pop(),
                          )
                        else
                          const KolekLogo(),
                        child,
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AuthHeading extends StatelessWidget {
  const AuthHeading({required this.title, required this.subtitle, super.key});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: KolekText.mono(
              size: 50,
              weight: FontWeight.w600,
              height: 1.1,
              letterSpacing: -3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: KolekText.mono(
              size: 14,
              weight: FontWeight.w500,
              color: KolekColors.neutral600,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class AuthLinkRow extends StatelessWidget {
  const AuthLinkRow({
    required this.text,
    required this.link,
    required this.onPressed,
    super.key,
  });

  final String text;
  final String link;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            text,
            style: KolekText.mono(size: 14, color: KolekColors.neutral400),
          ),
        ),
        const SizedBox(width: 8),
        InkWell(
          onTap: onPressed,
          child: Text(
            link,
            style: KolekText.mono(size: 14, color: KolekColors.blue600),
          ),
        ),
      ],
    );
  }
}

class UnderlinedLink extends StatelessWidget {
  const UnderlinedLink({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onPressed,
        child: Text(
          label,
          style: KolekText.mono(
            size: 14,
            color: KolekColors.neutral500,
          ).copyWith(decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}
