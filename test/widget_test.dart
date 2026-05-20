import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  testWidgets('Portfolio theme toggle test', (WidgetTester tester) async {
    // Disable VisibilityDetector's internal timer for tests
    VisibilityDetectorController.instance.updateInterval = Duration.zero;

    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: const PortfolioApp(),
      ),
    );

    await tester.pump();

    // Verify that the portfolio title is shown (Navbar + Projects section title)
    expect(find.text('PORTFOLIO'), findsAtLeastNWidgets(1));
    
    final themeProvider = tester.element(find.byType(PortfolioApp)).read<ThemeProvider>();
    expect(themeProvider.isDarkMode, true);

    // Find and tap the theme toggle
    final themeToggle = find.byIcon(Icons.light_mode);
    expect(themeToggle, findsOneWidget);

    await tester.tap(themeToggle);
    await tester.pump(const Duration(milliseconds: 100));

    // Verify brightness changed
    expect(themeProvider.isDarkMode, false);

    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });
}
