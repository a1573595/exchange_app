import 'package:exchange_app/src/data/repository/exchange_repository.dart';
import 'package:exchange_app/src/ui/page/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/repository/fake_exchange_repository.dart';
import '../../util/test_util.dart';

void main() {
  group("Home page test", () {
    testWidgets("BottomNavigationBar change page", (widgetTester) async {
      await widgetTester.pumpWidget(buildTestWidget(
        widget: const HomePage(),
      ));

      final bnb = find.byType(BottomNavigationBar);
      final bnbItemRate = find.descendant(of: bnb, matching: find.text("Rate"));
      final bnbItemRateConvert = find.descendant(of: bnb, matching: find.text("Convert"));

      expect(bnb, findsOneWidget);
      expect(bnbItemRate, findsOneWidget);
      expect(bnbItemRateConvert, findsOneWidget);
      expect(find.byType(RatePage), findsOneWidget);
      expect(find.byType(ConvertPage), findsNothing);

      await widgetTester.tap(bnbItemRateConvert);
      await widgetTester.pump();

      expect(find.byType(RatePage), findsNothing);
      expect(find.byType(ConvertPage), findsOneWidget);
    });

    testWidgets("BottomNavigationBar change to second page", (widgetTester) async {
      await widgetTester.pumpWidget(buildTestWidget(
        overrides: [
          exchangeRepository.overrideWith((ref) => FakeExchangeRepository()),
        ],
        widget: const HomePage(),
      ));

      final bnb = find.byType(BottomNavigationBar);
      final bnbItemRateConvert = find.descendant(of: bnb, matching: find.text("Convert"));

      final element = widgetTester.element(find.byType(HomePage));
      final container = ProviderScope.containerOf(element);

      await widgetTester.tap(bnbItemRateConvert);
      await widgetTester.pump();

      expect(container.read(pagePositionProvider.notifier).state, 1);
    });
  });
}
