part of 'home_view_model.dart';

class ConvertPage extends ConsumerWidget {
  const ConvertPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: ref.watch(exchangeListProvider).when(
            data: (data) => const _ConvertBody(),
            error: (error, stackTrace) => Center(
              child: Text(error.toString()),
            ),
            loading: () => const _LoadingBody(),
          ),
    );
  }
}

class _ConvertBody extends StatelessWidget {
  const _ConvertBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(
        left: WidgetStyle.p16,
        top: WidgetStyle.p16,
        right: WidgetStyle.p16,
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              L10n.current.amount,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(
            height: WidgetStyle.p8,
          ),
          const _AmountTextField(),
          const SizedBox(
            height: WidgetStyle.p32,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      L10n.current.from,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        return _ExchangeCard(
                          exchange: ref.watch(convertUiStateProvider).fromExchange,
                          onChanged: ref.read(convertUiStateProvider.notifier).updateFromExchange,
                        );
                      },
                    ),
                  ],
                ),
              ),
              Consumer(
                builder: (context, ref, child) {
                  return IconButton(
                    onPressed: ref.read(convertUiStateProvider.notifier).switchExchange,
                    icon: const Icon(
                      Icons.change_circle,
                      size: 64,
                    ),
                  );
                },
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      L10n.current.to,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        return _ExchangeCard(
                          exchange: ref.watch(convertUiStateProvider).toExchange,
                          onChanged: ref.read(convertUiStateProvider.notifier).updateToExchange,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: WidgetStyle.p32,
          ),
          const _RateText(),
          const SizedBox(
            height: WidgetStyle.p64,
          ),
          const _FromCurrencyText(),
          const SizedBox(
            height: WidgetStyle.p16,
          ),
          Text(
            "≈",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: WidgetStyle.p16,
          ),
          const _ResultText(),
        ],
      ),
    );
  }
}

class _AmountTextField extends HookConsumerWidget {
  const _AmountTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text: ref.read(convertUiStateProvider).amountText);

    return TextFormField(
      controller: controller,
      textAlign: TextAlign.end,
      textInputAction: TextInputAction.done,
      inputFormatters: [
        LengthLimitingTextInputFormatter(12),
        FilteringTextInputFormatter.allow(digitsWithDot),
      ],
      onChanged: ref.read(convertUiStateProvider.notifier).updateAmountText,
    );
  }
}

class _ExchangeCard extends HookConsumerWidget {
  const _ExchangeCard({
    super.key,
    required this.exchange,
    required this.onChanged,
  });

  final Exchange exchange;
  final Function(Exchange) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final children = useMemoized(() => {for (final i in ref.read(exchangeListProvider).requireValue) i: i.currency});

    final onTap = useCallback(
        () => showPickerSheet(context, children: children, initialValue: exchange).then((value) {
              if (value != null) {
                onChanged(value);
              }
            }),
        [exchange]);

    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(WidgetStyle.p8),
          child: Row(
            children: [
              CachedNetworkImage(
                height: Theme.of(context).textTheme.headlineMedium!.fontSize,
                width: Theme.of(context).textTheme.headlineMedium!.fontSize,
                imageUrl: exchange.currencyIcon,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                exchange.currency,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RateText extends ConsumerWidget {
  const _RateText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fromExchange = ref.watch(convertUiStateProvider.select((value) => value.fromExchange));
    final toExchange = ref.watch(convertUiStateProvider.select((value) => value.toExchange));
    final rateText = ref.watch(convertUiStateProvider.select((value) => value.rateText));

    return Text(
      "1 ${fromExchange.currency} ≈ $rateText ${toExchange.currency}",
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class _FromCurrencyText extends ConsumerWidget {
  const _FromCurrencyText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final amountText = ref.watch(convertUiStateProvider.select((value) => value.amountText));
    final fromExchange = ref.watch(convertUiStateProvider.select((value) => value.fromExchange));

    return Text(
      "$amountText ${fromExchange.currency}",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class _ResultText extends ConsumerWidget {
  const _ResultText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultText = ref.watch(convertUiStateProvider.select((value) => value.resultText));
    final toExchange = ref.watch(convertUiStateProvider.select((value) => value.toExchange));

    return Text(
      "$resultText ${toExchange.currency}",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}
