import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../views/views.dart';

class HomeScreen extends StatefulWidget {
  static const name = 'home-screen';
  final int pageIndex;
  const HomeScreen({super.key, required this.pageIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  late PageController pageController;
  late final viewRoutes = <Widget>[
    const HomeView(),
    const PopularsView(),
    FavoritesView(
      pageController: pageController,
    ),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(keepPage: true);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children:
              List.generate(viewRoutes.length, (index) => viewRoutes[index]),
        ),
        extendBody: true,
        /* IndexedStack(
        index: widget.pageIndex,
        children: viewRoutes,
      ) */
        bottomNavigationBar: (viewRoutes.length <= 3)
            ? CustomBottomNavigation(
                currentIndex: widget.pageIndex, pageController: pageController)
            : null);
  }

  @override
  bool get wantKeepAlive => true;
}
