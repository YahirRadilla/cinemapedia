import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatefulWidget {
  final int currentIndex;
  const CustomBottomNavigation({super.key, required this.currentIndex});

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  final PageController _pageController = PageController(initialPage: 0);

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        return context.go('/home/$index');
      case 1:
        _pageController.animateToPage(1,
            duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
        return context.go('/home/$index');
      case 2:
        return context.go('/home/$index');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return AnimatedNotchBottomBar(
      pageController: _pageController,
      itemLabelStyle: const TextStyle(color: Colors.white, fontSize: 12),
      showBlurBottomBar: true,
      blurOpacity: 0.2,
      blurFilterX: 5.0,
      blurFilterY: 10.0,
      bottomBarItems: [
        BottomBarItem(
          inActiveItem: Icon(
            Icons.home,
            color: colors.secondary,
          ),
          activeItem: Icon(
            Icons.home_filled,
            color: colors.primary,
          ),
          itemLabel: 'Inicio',
        ),
        BottomBarItem(
          inActiveItem: Icon(
            Icons.thumbs_up_down_outlined,
            color: colors.secondary,
          ),
          activeItem: Icon(
            Icons.thumbs_up_down_outlined,
            color: colors.primary,
          ),
          itemLabel: 'Populares',
        ),
        BottomBarItem(
          inActiveItem: Icon(
            Icons.favorite_outline,
            color: colors.secondary,
          ),
          activeItem: Icon(
            Icons.favorite_outline,
            color: colors.primary,
          ),
          itemLabel: 'Favoritos',
        ),
      ],
      onTap: (value) {
        print(value);

        onItemTapped(context, value);
      },
    );

    /* return BottomNavigationBar(
        elevation: 0,
        currentIndex: currentIndex,
        onTap: (value) => onItemTapped(context, value),
        
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_max,
            ),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.thumbs_up_down_outlined), label: 'Populares'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline), label: 'Favoritos')
        ]); */
  }
}
