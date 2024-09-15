import 'dart:ui';

import 'package:defood/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'add_product_dialog_model.dart';

// ignore: must_be_immutable
class AddProductDialog extends StackedView<AddProductDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  AddProductDialog({
    super.key,
    required this.request,
    required this.completer,
  });

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
  }

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
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Expiration date',
                      style: TextStyle(
                        fontSize: Theme.of(context).textTheme.labelLarge?.fontSize ?? 16,
                      ),
                    ),
                    verticalSpaceTiny,
                    FilledButton.tonalIcon(
                      label: Text(
                        viewModel.formatDate(selectedDate),
                      ),
                      onPressed: () => _selectDate(context),
                      icon: const Icon(
                        Icons.calendar_today_rounded,
                        size: 16,
                      ),
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
  AddProductDialogModel viewModelBuilder(BuildContext context) => AddProductDialogModel();
}
