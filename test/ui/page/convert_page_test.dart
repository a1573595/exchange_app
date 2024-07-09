import 'package:exchange_app/src/ui/page/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../data/data_source/data_source.dart';
import '../../util/test_util.dart';

void main() {
  group("Convert page test", () {
    testWidgets("Loading data", (widgetTester) async {
      await widgetTester.pumpWidget(buildTestWidget(
        overrides: [
          exchangeListProvider.overrideWith((ref) => Future.value([])),
        ],
        widget: const ConvertPage(),
      ));

      final circularProgressIndicator =
          find.descendant(of: find.byType(Center), matching: find.byType(CircularProgressIndicator));
      expect(circularProgressIndicator, findsOneWidget);
    });

    testWidgets("Load data failed", (widgetTester) async {
      await widgetTester.pumpWidget(buildTestWidget(
        overrides: [
          exchangeListProvider.overrideWith((ref) => Future.delayed(Duration.zero)),
        ],
        widget: const ConvertPage(),
      ));

      final errorText = find.descendant(of: find.byType(Center), matching: find.byType(Text));
      expect(errorText, findsOneWidget);
    });

    testWidgets("Load data succeed", (widgetTester) async {
      final list = DataSource.getExchangeList();

      await widgetTester.pumpWidget(buildTestWidget(
        overrides: [
          exchangeListProvider.overrideWith((ref) => Future.value(list)),
        ],
        widget: const ConvertPage(),
      ));
      await widgetTester.pump();

      final amountTextField = find.byType(TextFormField);
      final switchIconButton = find.byType(IconButton);

      expect(amountTextField, findsOneWidget);
      expect(switchIconButton, findsOneWidget);
    });

    testWidgets("Exchange picker", (widgetTester) async {
      final list = DataSource.getExchangeList();

      await widgetTester.pumpWidget(buildTestWidget(
        overrides: [
          exchangeListProvider.overrideWith((ref) => Future.value(list)),
        ],
        widget: const ConvertPage(),
      ));
      await widgetTester.pump();

      final inkwell = find.byType(InkWell).first;
      await widgetTester.tap(inkwell);
      await widgetTester.pump();
      final picker = find.byType(CupertinoPicker);

      expect(inkwell, findsOneWidget);
      expect(picker, findsOneWidget);
    });
  });
}
