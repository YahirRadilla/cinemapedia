import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final PageController pageController;
  const CustomBottomNavigation(
      {super.key, required this.currentIndex, required this.pageController});

  void onItemTapped(BuildContext context, int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastEaseInToSlowEaseOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AnimatedNotchBottomBar(
      pageController: pageController,
      itemLabelStyle: const TextStyle(color: Colors.white, fontSize: 12),
      notchColor: Colors.black45,
      color: Colors.black87,
      bottomBarItems: [
        BottomBarItem(
          inActiveItem: Icon(
            Icons.home,
            color: colors.secondary,
          ),
          activeItem: Icon(
            Icons.home_max,
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
            Icons.thumbs_up_down,
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
            Icons.favorite,
            color: colors.primary,
          ),
          itemLabel: 'Favoritos',
        ),
      ],
      onTap: (value) {
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
