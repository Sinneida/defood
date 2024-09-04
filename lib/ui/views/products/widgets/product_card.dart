import 'package:defood/models/product.dart';
import 'package:defood/ui/views/products/widgets/product_card_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class ProductCard extends StackedView<ProductCardModel> {
  const ProductCard(this.product, {super.key});

  final Product product;

  @override
  Widget builder(BuildContext context, ProductCardModel viewModel, Widget? child) {
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
        // if (direction == DismissDirection.endToStart) {
        //   viewModel.deleteBox(box, removeBox);
        // }
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        surfaceTintColor: Theme.of(context).colorScheme.primary,
        child: ListTile(
          title: Text(product.name),
          subtitle: Text(
            DateFormat('dd-mm-yyyy').format(
              product.expirationDate,
            ),
          ),
        ),
      ),
    );
  }

  @override
  ProductCardModel viewModelBuilder(BuildContext context) => ProductCardModel();
}
