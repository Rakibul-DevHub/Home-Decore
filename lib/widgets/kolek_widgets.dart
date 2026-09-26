import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/kolek_colors.dart';
import 'screen_background.dart';

/// Bundled font families from pubspec.yaml.
abstract final class KolekFonts {
  static const ibmPlexMono = 'IBMPlexMono-Regular';
  static const generalSans = 'GeneralSans-Regular';
  static const generalSansSemibold = 'GeneralSans-Semibold';
}

/// Text styles using local fonts — every option is customizable per call.
abstract final class KolekText {
  static TextStyle mono({
    double size = 16,
    FontWeight weight = FontWeight.w400,
    Color color = KolekColors.neutral900,
    double? height,
    double? letterSpacing,
    double? wordSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    FontStyle fontStyle = FontStyle.normal,
    TextBaseline? textBaseline,
    String? fontFamily,
    List<FontFeature>? fontFeatures,
    List<Shadow>? shadows,
    Color? backgroundColor,
    Paint? foreground,
    Paint? background,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
  }) {
    return _style(
      fontFamily: fontFamily ?? KolekFonts.ibmPlexMono,
      size: size,
      weight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      fontStyle: fontStyle,
      textBaseline: textBaseline,
      fontFeatures: fontFeatures,
      shadows: shadows,
      backgroundColor: backgroundColor,
      foreground: foreground,
      background: background,
      leadingDistribution: leadingDistribution,
      locale: locale,
    );
  }

  static TextStyle sans({
    double size = 16,
    FontWeight weight = FontWeight.w500,
    Color color = KolekColors.neutral900,
    double? height,
    double? letterSpacing,
    double? wordSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    FontStyle fontStyle = FontStyle.normal,
    TextBaseline? textBaseline,
    String? fontFamily,
    List<FontFeature>? fontFeatures,
    List<Shadow>? shadows,
    Color? backgroundColor,
    Paint? foreground,
    Paint? background,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
  }) {
    return _style(
      fontFamily: fontFamily ?? KolekFonts.generalSans,
      size: size,
      weight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      fontStyle: fontStyle,
      textBaseline: textBaseline,
      fontFeatures: fontFeatures,
      shadows: shadows,
      backgroundColor: backgroundColor,
      foreground: foreground,
      background: background,
      leadingDistribution: leadingDistribution,
      locale: locale,
    );
  }

  static TextStyle _style({
    required String fontFamily,
    required double size,
    required FontWeight weight,
    required Color color,
    double? height,
    double? letterSpacing,
    double? wordSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    FontStyle fontStyle = FontStyle.normal,
    TextBaseline? textBaseline,
    List<FontFeature>? fontFeatures,
    List<Shadow>? shadows,
    Color? backgroundColor,
    Paint? foreground,
    Paint? background,
    TextLeadingDistribution? leadingDistribution,
    Locale? locale,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      fontStyle: fontStyle,
      textBaseline: textBaseline,
      fontFeatures: fontFeatures,
      shadows: shadows,
      backgroundColor: backgroundColor,
      foreground: foreground,
      background: background,
      leadingDistribution: leadingDistribution,
      locale: locale,
    );
  }
}

class KolekLogo extends StatelessWidget {
  const KolekLogo({super.key, this.size = 32});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/logo.svg',
      width: size,
      height: size,
    );
  }
}

/// Top-center wordmark from `assets/icons/text_logo.svg`.
class KolekTextLogo extends StatelessWidget {
  const KolekTextLogo({super.key, this.height = 20});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/text_logo.svg',
      height: height,
      fit: BoxFit.contain,
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
    this.labelStyle,
  });

  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final Widget? icon;
  final TextStyle? labelStyle;

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
              style: (labelStyle ??
                      KolekText.sans(
                        size: 16,
                        weight: FontWeight.w500,
                        color: foregroundColor,
                      ))
                  .copyWith(color: foregroundColor),
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
    this.labelStyle,
    this.inputStyle,
  });

  final String label;
  final String hint;
  final bool obscureText;
  final VoidCallback? onVisibilityPressed;
  final TextInputType? keyboardType;
  final TextStyle? labelStyle;
  final TextStyle? inputStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: labelStyle ??
              KolekText.mono(size: 12, color: KolekColors.neutral800),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 56,
          child: TextFormField(
            initialValue: hint,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: inputStyle ?? KolekText.mono(size: 14),
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
    this.showLogo = true,
    this.scrollable = true,
  });

  final String routeName;
  final Widget child;
  final bool showBack;

  /// When [showBack] is true, places [KolekLogo] under the back button.
  /// When [showBack] is false, shows the logo in place of the back button.
  final bool showLogo;

  /// When false, content fills the screen height and does not scroll.
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KolekColors.neutral50,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            ScreenBackground(routeName: routeName),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (showBack)
                          AuthBackButton(
                            onPressed: () => Navigator.of(context).pop(),
                          )
                        else if (showLogo)
                          const KolekLogo(),
                        if (showBack && showLogo) ...[
                          const SizedBox(height: 16),
                          const KolekLogo(),
                        ],
                      ],
                    ),
                  ),
                  // Logo / back stay pinned above the scroll area.
                  if (scrollable)
                    Expanded(
                      child: SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: const EdgeInsets.only(bottom: 24),
                        child: child,
                      ),
                    )
                  else
                    Expanded(child: child),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthHeading extends StatelessWidget {
  const AuthHeading({
    required this.title,
    required this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    super.key,
  });

  final String title;
  final String subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle ??
                KolekText.mono(
                  size: 50,
                  weight: FontWeight.w600,
                  height: 1.1,
                  letterSpacing: -3,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: subtitleStyle ??
                KolekText.mono(
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
    this.textStyle,
    this.linkStyle,
    super.key,
  });

  final String text;
  final String link;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final TextStyle? linkStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            text,
            style: textStyle ??
                KolekText.mono(size: 14, color: KolekColors.neutral400),
          ),
        ),
        const SizedBox(width: 8),
        InkWell(
          onTap: onPressed,
          child: Text(
            link,
            style: linkStyle ??
                KolekText.mono(size: 14, color: KolekColors.blue600),
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
