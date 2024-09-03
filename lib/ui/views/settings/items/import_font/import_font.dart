import 'dart:ui';

import 'package:defood/ui/widgets/settings/common/item_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'import_font_model.dart';

class ImportFont extends StackedView<ImportFontModel> {
  const ImportFont({super.key});

  @override
  Widget builder(
    BuildContext context,
    ImportFontModel viewModel,
    Widget? child,
  ) {
    return InkWell(
      onTap: () => viewModel.showImportFontDialog(),
      child: ItemWrapper(
        mainText: 'Import font',
        trailingWidget: IconButton.filledTonal(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 6,
                    sigmaY: 6,
                  ),
                  child: AlertDialog(
                    backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
                    title: const Text('How to import?'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(viewModel.fontImportMessage),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          icon: const Icon(Icons.info_outline),
        ),
      ),
    );
  }

  @override
  ImportFontModel viewModelBuilder(
    BuildContext context,
  ) =>
      ImportFontModel();
}
