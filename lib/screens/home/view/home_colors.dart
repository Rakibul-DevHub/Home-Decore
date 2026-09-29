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

  static _HomeColors of(BuildContext context) {
    return _HomeColors(
      canvas: AppearancePage.background(context),
      field: AppearancePage.field(context),
      line: AppearancePage.line(context),
      muted: AppearancePage.muted(context),
      secondary: AppearancePage.secondary(context),
      icon: AppearancePage.icon(context),
      text: AppearancePage.foreground(context),
      menu: AppearancePage.menu(context),
      dark: AppearancePage.isDark(context),
    );
  }

  SystemUiOverlayStyle get overlay => AppearancePage.overlayFor(dark);

  ColorFilter get iconFilter => ColorFilter.mode(icon, BlendMode.srcIn);

  ColorFilter get textFilter => ColorFilter.mode(text, BlendMode.srcIn);
}
