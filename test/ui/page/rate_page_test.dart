import 'package:exchange_app/src/ui/page/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../data/data_source/data_source.dart';
import '../../util/test_util.dart';

void main() {
  group("Rate page test", () {
    testWidgets("Loading data", (widgetTester) async {
      await widgetTester.pumpWidget(buildTestWidget(
        overrides: [
          exchangeListProvider.overrideWith((ref) => Future.value([])),
        ],
        widget: const RatePage(),
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
        widget: const RatePage(),
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
        widget: const RatePage(),
      ));
      await widgetTester.pump();

      final listview = find.byType(ListView);
      final listTitle = find.byKey(ValueKey(list.first.id));

      expect(listview, findsOneWidget);
      expect(listTitle, findsOneWidget);
    });
  });
}
