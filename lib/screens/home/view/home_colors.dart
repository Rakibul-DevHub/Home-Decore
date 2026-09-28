part of 'home_screen.dart';

class _HomeColors {
  const _HomeColors({
    required this.canvas,
    required this.field,
    required this.line,
    required this.muted,
    required this.secondary,
    required this.icon,
    required this.text,
    required this.menu,
    required this.dark,
  });

  final Color canvas;
  final Color field;
  final Color line;
  final Color muted;
  final Color secondary;
  final Color icon;
  final Color text;
  final Color menu;
  final bool dark;

  static const light = _HomeColors(
    canvas: KolekColors.neutral50,
    field: KolekColors.neutral100,
    line: KolekColors.neutral200,
    muted: KolekColors.neutral500,
    secondary: KolekColors.neutral600,
    icon: KolekColors.neutral700,
    text: KolekColors.neutral900,
    menu: Color(0xFFF4F4F4),
    dark: false,
  );

  static const night = _HomeColors(
    canvas: Color(0xFF0A0A0A),
    field: Color(0xFF1C1C1C),
    line: Color(0xFF2A2A2A),
    muted: Color(0xFFA3A3A3),
    secondary: Color(0xFFD4D4D4),
    icon: Color(0xFFE8E8E8),
    text: Color(0xFFFAFAFA),
    menu: Color(0xFF171717),
    dark: true,
  );

  static _HomeColors of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? night : light;
  }

  SystemUiOverlayStyle get overlay {
    return (dark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark)
        .copyWith(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
        );
  }

  ColorFilter get iconFilter => ColorFilter.mode(icon, BlendMode.srcIn);

  ColorFilter get textFilter => ColorFilter.mode(text, BlendMode.srcIn);
}
