import 'dart:ui';

import 'package:defood/ui/common/ui_helpers.dart';
import 'package:defood/ui/dialogs/add_product/add_product_dialog.form.dart';
import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'add_product_dialog_model.dart';
import 'package:flutter/services.dart';

@FormView(
  fields: [
    FormTextField(
      name: 'productName',
      validator: AddProductValidators.validateProductName,
    ),
    FormTextField(
      name: 'amount',
      validator: AddProductValidators.validateAmount,
    ),
    FormTextField(
      name: 'price',
      validator: AddProductValidators.validatePrice,
    ),
  ],
)
class AddProductDialog extends StackedView<AddProductDialogModel> with $AddProductDialog {
  final DialogRequest request;
  final Function(DialogResponse<ProductDto?>) completer;

  const AddProductDialog({
    super.key,
    required this.request,
    required this.completer,
  });

  @override
  Widget builder(
    BuildContext context,
    AddProductDialogModel viewModel,
    Widget? child,
  ) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 6,
        sigmaY: 6,
      ),
      child: AlertDialog(
        title: const Text('New product'),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        alignment: Alignment.bottomCenter,
        scrollable: true,
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: productNameController,
                decoration: inputDecoration('Product name'),
              ),
              verticalSpaceMedium,
              TextFormField(
                controller: amountController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                decoration: inputDecoration('Amount'),
              ),
              verticalSpaceMedium,
              TextFormField(
                controller: priceController,
                inputFormatters: [viewModel.currencyFormatter],
                keyboardType: TextInputType.number,
                decoration: inputDecoration('Price'),
              ),
              verticalSpaceMedium,
              Card(
                clipBehavior: Clip.antiAlias,
                color: Theme.of(context).colorScheme.surfaceDim,
                child: const ExpansionTile(
                  title: Text('Expiration types'),
                  expandedAlignment: Alignment.centerLeft,
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  childrenPadding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  leading: Icon(Icons.info_outline),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Soft: Best before'),
                        Text('Hard: Expiration date'),
                        Text('Custom: Your own amount of days before product expires'),
                        Text("Not Apply: Expiration date doesn't apply to this product"),
                      ],
                    )
                  ],
                ),
              ),
              verticalSpaceMedium,
              DropdownButtonFormField<ExpirationType>(
                value: ExpirationType.soft,
                decoration: inputDecoration('Expiration type'),
                items: const [
                  DropdownMenuItem(
                    value: ExpirationType.soft,
                    child: Text('Soft'),
                  ),
                  DropdownMenuItem(
                    value: ExpirationType.hard,
                    child: Text('Hard'),
                  ),
                  DropdownMenuItem(
                    enabled: false,
                    value: ExpirationType.custom,
                    child: Text('Custom'),
                  ),
                  DropdownMenuItem(
                    value: ExpirationType.notApply,
                    child: Text('Not Apply'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    viewModel.expirationType = value;
                  }
                },
              ),
              verticalSpaceMedium,
              Row(
                children: [
                  Expanded(
                    child: FilledButton.tonalIcon(
                      label: Text(
                        viewModel.formattedDate(),
                      ),
                      onPressed: () => viewModel.selectDate(context),
                      icon: const Icon(
                        Icons.calendar_today_rounded,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              completer(DialogResponse<ProductDto?>(confirmed: true, data: null));
            },
            child: const Text('Cancel'),
          ),
          if (!viewModel.hasAnyValidationMessage)
            FilledButton(
              onPressed: () {
                final ProductDto value = (
                  name: viewModel.productNameValue!.trim(),
                  amount: viewModel.amountValue!.trim(),
                  price: viewModel.currencyFormatter.getUnformattedValue(),
                  expirationDate: viewModel.selectedDate,
                  expirationType: viewModel.expirationType,
                );
                viewModel.clearForm();
                completer(
                  DialogResponse<ProductDto>(confirmed: true, data: value),
                );
              },
              child: const Text('Add'),
            )
          else
            const FilledButton(
              onPressed: null,
              child: Text('Add'),
            )
        ],
      ),
    );
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(75),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
      label: Text(label),
      filled: true,
      isDense: true,
    );
  }

  @override
  AddProductDialogModel viewModelBuilder(BuildContext context) => AddProductDialogModel();

  @override
  void onViewModelReady(AddProductDialogModel viewModel) {
    syncFormWithViewModel(viewModel);
    viewModel.product = (request.data != null && request.data is Product)
        ? request.data as Product
        : null;
    productNameController.text =
        viewModel.product?.productNameInLanguages?[OpenFoodFactsLanguage.POLISH] ?? '';
  }

  @override
  void onDispose(AddProductDialogModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }
}
