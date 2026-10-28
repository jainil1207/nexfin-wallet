import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nexfin_wallet/main.dart';

void main() {
  testWidgets('Kitchen Sink App builds successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const KitchenSinkApp());

    // Verify that our transaction list header is on the screen.
    expect(find.text('Recent Transactions'), findsOneWidget);

    // Verify that the bottom navigation icons exist.
    expect(find.byIcon(Icons.home_filled), findsOneWidget);
    expect(find.byIcon(Icons.pie_chart_rounded), findsOneWidget);
    expect(find.byIcon(Icons.account_balance_wallet_rounded), findsOneWidget);
    expect(find.byIcon(Icons.person_rounded), findsOneWidget);
  });
}
