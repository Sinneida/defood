import 'package:animations/animations.dart';
import 'package:defood/ui/views/boxes/boxes_view.dart';
import 'package:defood/ui/views/recipes/recipes_view.dart';
import 'package:defood/ui/views/schedule/schedule_view.dart';
import 'package:defood/ui/views/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'navigation_viewmodel.dart';

class NavigationView extends StackedView<NavigationViewModel> {
  const NavigationView({Key? key}) : super(key: key);

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return const BoxesView();
      case 1:
        return const RecipesView();
      case 2:
        return const ScheduleView();
      case 3:
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
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.inbox),
            label: 'Boxes',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt),
            label: 'Recipes',
          ),
          NavigationDestination(
            icon: Icon(Icons.schedule),
            label: 'Schedule',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
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
