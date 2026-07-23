import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:watchman/main.dart';
import 'package:watchman/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:watchman/services/gate_provider.dart';

void main() {
  testWidgets('Login screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => GateProvider(),
        child: const MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );

    // Verify that the login screen is shown.
    expect(find.text('LOGIN'), findsOneWidget);
    expect(find.text('WATCHMAN'), findsOneWidget);

    // Verify that the login button is present.
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
