part of 'home_view_model.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = usePageController();

    final pages = useMemoized(() => const [
          RatePage(),
          ConvertPage(),
        ]);

    ref.listen(pagePositionProvider, (previous, next) {
      controller.jumpToPage(next);
    });

    return TwicePopScope(
      child: Scaffold(
        body: PageView.builder(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: pages.length,
          itemBuilder: (context, index) => pages[index],
        ),
        bottomNavigationBar: const _BottomNavigationBar(),
      ),
    );
  }
}

class _BottomNavigationBar extends HookConsumerWidget {
  const _BottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      currentIndex: ref.watch(pagePositionProvider),
      onTap: (index) => ref.read(pagePositionProvider.notifier).state = index,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money),
          label: 'Rate',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calculate),
          label: 'Convert',
        ),
      ],
    );
  }
}
