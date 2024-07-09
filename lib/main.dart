import 'package:exchange_app/src/data/local/hive_helper.dart';
import 'package:exchange_app/src/ui/l10n/l10n.dart';
import 'package:exchange_app/src/ui/page/home_view_model.dart';
import 'package:exchange_app/src/ui/style/widget_style.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await HiveHelper.init();

  runApp(const ProviderScope(
    child: ExchangeApp(),
  ));
}

class ExchangeApp extends StatelessWidget {
  const ExchangeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Exchange",
      supportedLocales: L10n.supportedLocales,
      localizationsDelegates: L10n.localizationsDelegates,
      home: const HomePage(),
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: WidgetStyle.textFieldRadius,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: WidgetStyle.textFieldRadius,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: WidgetStyle.textFieldRadius,
          ),
        ),
      ),
    );
  }
}
