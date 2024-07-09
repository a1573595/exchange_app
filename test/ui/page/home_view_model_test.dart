import 'package:exchange_app/src/ui/page/bean/convert_ui_state.dart';
import 'package:exchange_app/src/ui/page/home_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../data/data_source/data_source.dart';
import '../../util/test_util.dart';

void main() {
  group("Home view model", () {
    test("ConvertUiStateNotifier init state", () async {
      final list = DataSource.getExchangeList();

      final container = createContainer(
        overrides: [
          exchangeListProvider.overrideWith((ref) => Future.value(list)),
        ],
      );

      await container.read(exchangeListProvider.future);

      final uiState = container.read(convertUiStateProvider);
      expect(uiState, ConvertUiState.byDefault(exchange: list.first));
    });

    test("ConvertUiStateNotifier update amount text", () async {
      final list = DataSource.getExchangeList();
      const amountText = "123.456789";

      final container = createContainer(
        overrides: [
          exchangeListProvider.overrideWith((ref) => Future.value(list)),
        ],
      );

      await container.read(exchangeListProvider.future);

      container.read(convertUiStateProvider.notifier).updateAmountText(amountText);

      final uiState = container.read(convertUiStateProvider);
      expect(uiState.amountText, amountText);
      expect(uiState.resultText, "123.4567890");
    });

    test("ConvertUiStateNotifier switch exchange", () async {
      final list = DataSource.getExchangeList();
      const amountText = "123.456789";

      final container = createContainer(
        overrides: [
          exchangeListProvider.overrideWith((ref) => Future.value(list)),
        ],
      );

      await container.read(exchangeListProvider.future);

      container.read(convertUiStateProvider.notifier).updateAmountText(amountText);
      container.read(convertUiStateProvider.notifier).updateToExchange(list.last);

      expect(container.read(convertUiStateProvider).resultText, "243.309784251");

      container.read(convertUiStateProvider.notifier).switchExchange();
      expect(container.read(convertUiStateProvider).resultText, "62.6426874");
    });
  });
}
