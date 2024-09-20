import 'package:defood/models/product.dart';
import 'package:defood/ui/common/ui_helpers.dart';
import 'package:defood/ui/views/products/widgets/product_card_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class ProductCard extends StackedView<ProductCardModel> {
  const ProductCard(this.product, {super.key});

  final ProductModel product;

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
        child: ExpansionTile(
          initiallyExpanded: true,
          expandedAlignment: Alignment.centerLeft,
          expandedCrossAxisAlignment: CrossAxisAlignment.start,
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          collapsedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          title: Text(product.name),
          // subtitle: Text(
          //   'Expiration date: ${DateFormat('dd-MM-yyyy').format(
          //     product.expirationDate,
          //   )}\nExpiration type: ${product.expirationType}',
          // ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Expiration date:\n${DateFormat('dd-MM-yyyy').format(
                      product.expirationDate,
                    )}'),
                    verticalSpaceTiny,
                    Text('Expiration type:\n${product.expirationType}'),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price:\n${product.price} PLN'),
                    verticalSpaceTiny,
                    Text('Amount:\n${product.amount}')
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Created:\n${DateFormat('dd-MM-yyyy HH:mm').format(
                        product.createdAt,
                      )}',
                    ),
                    verticalSpaceTiny,
                    Text(
                      'Updated:\n${DateFormat('dd-MM-yyyy HH:mm').format(
                        product.updatedAt,
                      )}',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  ProductCardModel viewModelBuilder(BuildContext context) => ProductCardModel();
}
