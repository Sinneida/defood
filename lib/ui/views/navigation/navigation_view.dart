import 'package:animations/animations.dart';
import 'package:defood/ui/views/boxes/boxes_view.dart';
import 'package:defood/ui/views/products/products_view.dart';
import 'package:defood/ui/views/recipes/recipes_view.dart';
import 'package:defood/ui/views/schedule/schedule_view.dart';
import 'package:defood/ui/views/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:defood/gen/strings.g.dart';

import 'navigation_viewmodel.dart';

class NavigationView extends StackedView<NavigationViewModel> {
  const NavigationView({super.key});

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return const BoxesView();
      case 1:
        return const ProductsView();
      case 2:
        return const RecipesView();
      case 3:
        return const ScheduleView();
      case 4:
        return const SettingsView();
      default:
        return const BoxesView();
    }
  }

  @override
  Widget builder(
    BuildContext context,
    NavigationViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return FadeThroughTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: getViewForIndex(viewModel.currentIndex),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) {
          viewModel.setIndex(value);
        },
        selectedIndex: viewModel.currentIndex,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.inbox),
            label: t.boxes.name,
          ),
          const NavigationDestination(
            icon: Icon(Icons.shopping_basket_outlined),
            label: 'Products',
          ),
          NavigationDestination(
            icon: const Icon(Icons.receipt),
            label: t.recipes.name,
          ),
          NavigationDestination(
            icon: const Icon(Icons.schedule),
            label: t.schedule.name,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings),
            label: t.settings.name,
          ),
        ],
      ),
    );
  }

  @override
  NavigationViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      NavigationViewModel();
}
