import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sausage_roll_app/views/product_info_view.dart';

void main() {
  testWidgets("Test Category View Page", (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ProductInfoView(),
        ),
      );
      expect(find.byType(Scaffold, skipOffstage: false), findsOneWidget);
    });
  });
}
