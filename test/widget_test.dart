import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kolek/main.dart';
import 'package:kolek/screens/main_shell/view/main_shell_screen.dart';
import 'package:kolek/screens/shop/view/shop_screen.dart';
import 'package:kolek/screens/splash/view/splash_screen.dart';

void main() {
  testWidgets('splash advances to onboarding and auth flow', (
    WidgetTester tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(440, 956);
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      const KolekApp(splashDuration: Duration(milliseconds: 10)),
    );

    expect(find.byType(SplashScreen), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 10));
    await tester.pumpAndSettle();
    expect(find.text('01'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);
    expect(find.textContaining('Discover'), findsOneWidget);
    expect(find.textContaining('REAL PEOPLE.'), findsOneWidget);

    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome\nback'), findsOneWidget);

    await tester.tap(find.text('Sign up'));
    await tester.pumpAndSettle();
    expect(find.text('Create\naccount'), findsOneWidget);
  });

  testWidgets('mock sign in opens main shell and shop', (
    WidgetTester tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(440, 956);
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      const KolekApp(splashDuration: Duration(milliseconds: 10)),
    );
    await tester.pump(const Duration(milliseconds: 10));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Sign In'));
    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    expect(find.byType(MainShellScreen), findsOneWidget);
    expect(find.text('Ronald Richards'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('bottom-nav-1')));
    await tester.pumpAndSettle();
    expect(find.text('Popular Searches'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('popular-Ceramic Vase')));
    await tester.pumpAndSettle();
    expect(find.byType(ShopScreen), findsOneWidget);
    expect(find.text('Shop'), findsOneWidget);
  });
}
