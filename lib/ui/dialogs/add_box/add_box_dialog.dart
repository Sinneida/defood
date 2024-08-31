import 'package:defood/ui/common/ui_helpers.dart';
import 'package:defood/ui/dialogs/add_box/add_box_dialog.form.dart';
import 'package:defood/ui/widgets/form/validation_error_message.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'add_box_dialog_model.dart';

@FormView(
  fields: [
    FormTextField(
      name: 'boxName',
      validator: AddBoxValidators.validateBoxName,
    )
  ],
)
class AddBoxDialog extends StackedView<AddBoxDialogModel> with $AddBoxDialog {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const AddBoxDialog({
    super.key,
    required this.request,
    required this.completer,
  });

  @override
  Widget builder(
    BuildContext context,
    AddBoxDialogModel viewModel,
    Widget? child,
  ) {
    return AlertDialog(
      title: const Text('Add box'),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            text: TextSpan(
              text: viewModel.message,
              // children: [
              //   TextSpan(
              //     text: viewModel.urlMessage,
              //     style: TextStyle(
              //       fontStyle: FontStyle.italic,
              //       fontWeight: FontWeight.w400,
              //       color: Theme.of(context).colorScheme.onSurface,
              //     ),
              //   ),
              //   TextSpan(
              //     text: viewModel.appMessage,
              //     style: TextStyle(
              //       fontWeight: FontWeight.w600,
              //       color: Theme.of(context).colorScheme.onSurface,
              //     ),
              //   ),
              // ],
            ),
          ),
          verticalSpaceMedium,
          TextFormField(
            controller: boxNameController,
            decoration: InputDecoration(
              // fillColor: Theme.of(context).colorScheme.surfaceTint.withAlpha(50),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(75),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              label: const Text('App name'),
              filled: true,
              isDense: true,
            ),
          ),
          if (viewModel.hasBoxNameValidationMessage) ...[
            verticalSpaceTiny,
            ValidationErrorMessage(viewModel.boxNameValidationMessage!),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            viewModel.clearForm();
            completer(DialogResponse<String?>(confirmed: true, data: null));
          },
          child: const Text('Cancel'),
        ),
        if (!viewModel.hasAnyValidationMessage)
          FilledButton(
            onPressed: () {
              viewModel.clearForm();
              completer(DialogResponse<String>(
                confirmed: true,
                data: boxNameController.value.text,
              ));
            },
            child: const Text('Add'),
          )
        else
          const FilledButton(
            onPressed: null,
            child: Text('Add'),
          )
      ],
    );
  }

  @override
  AddBoxDialogModel viewModelBuilder(BuildContext context) => AddBoxDialogModel();
}
