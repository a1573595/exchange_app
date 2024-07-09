part of 'home_view_model.dart';

class RatePage extends ConsumerWidget {
  const RatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: ref.watch(exchangeListProvider).when(
            data: (data) => _RateBody(data),
            error: (error, stackTrace) => Center(
              child: Text(error.toString()),
            ),
            loading: () => const _LoadingBody(),
          ),
    );
  }
}

class _LoadingBody extends StatelessWidget {
  const _LoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _RateBody extends StatelessWidget {
  const _RateBody(this.list, {super.key});

  final List<Exchange> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _RateTitle(),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(
              left: WidgetStyle.p16,
              right: WidgetStyle.p16,
              bottom: kBottomNavigationBarHeight,
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (context, index) => ListTile(
              key: ValueKey(list[index].id),
              minLeadingWidth: 0,
              contentPadding: EdgeInsets.zero,
              leading: CachedNetworkImage(
                height: WidgetStyle.p32,
                width: WidgetStyle.p32,
                imageUrl: list[index].currencyIcon,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.fitWidth,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${list[index].currency} / TWD"),
                  Text(thousandsSeparatorFormat.format(list[index].twdPrice)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RateTitle extends StatelessWidget {
  const _RateTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const SizedBox(
        width: WidgetStyle.p32,
      ),
      title: Row(
        children: [
          Text(
            L10n.current.currency,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Spacer(),
          Text(
            L10n.current.price,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
