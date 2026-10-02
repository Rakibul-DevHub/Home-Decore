import 'package:flutter/services.dart';

/// Thin wrapper around the native `kolek/system_ui` method channel.
///
/// The native side owns system-bar visibility via `WindowInsetsController`.
/// Flutter's `SystemChrome` cannot express "status visible, nav hidden,
/// swipe reveals nav transiently" — that combination needs the platform API.
class SystemUiChannel {
  const SystemUiChannel._();

  static const _channel = MethodChannel('kolek/system_ui');

  /// Status bar on, nav bar hidden, swipe reveals nav briefly.
  static Future<void> enterStickyNav() =>
      _channel.invokeMethod<void>('enterStickyNav');

  /// Both bars hidden — for full-screen media viewers.
  static Future<void> enterFullscreen() =>
      _channel.invokeMethod<void>('enterFullscreen');

  /// Both bars visible permanently.
  static Future<void> showAllBars() =>
      _channel.invokeMethod<void>('showAllBars');
}