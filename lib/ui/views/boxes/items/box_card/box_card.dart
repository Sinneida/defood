import 'package:defood/models/box.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'box_card_model.dart';

class BoxCard extends StackedView<BoxCardModel> {
  const BoxCard(this.box, this.removeBox, {super.key});

  final BoxModel box;
  final void Function(int id) removeBox;

  @override
  Widget builder(
    BuildContext context,
    BoxCardModel viewModel,
    Widget? child,
  ) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.errorContainer,
        ),
        child: const Padding(
          padding: EdgeInsets.only(right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Icon(Icons.delete)],
          ),
        ),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          viewModel.deleteBox(box, removeBox);
        }
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        surfaceTintColor: Theme.of(context).colorScheme.primary,
        child: ListTile(
          onTap: () => viewModel.openBoxDetails(box),
          leading: const Icon(Icons.ac_unit),
          title: Text(box.name),
          subtitle: Text(
            box.products == null ? 'No products' : '${box.products!.length} products',
          ),
        ),
      ),
    );
  }

  @override
  BoxCardModel viewModelBuilder(
    BuildContext context,
  ) =>
      BoxCardModel();
}
