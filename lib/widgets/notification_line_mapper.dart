import 'dart:ui';

import 'package:flutter_svg/flutter_svg.dart';

import '../theme/kolek_colors.dart';

class NotificationLineMapper extends ColorMapper {
  const NotificationLineMapper(this.line);

  final Color line;

  @override
  Color substitute(
      String? id,
      String elementName,
      String attributeName,
      Color color,
      ) {
    if (color == KolekColors.blue600) return color;
    return line;
  }

  @override
  bool operator ==(Object other) =>
      other is NotificationLineMapper && other.line == line;

  @override
  int get hashCode => line.hashCode;
}
