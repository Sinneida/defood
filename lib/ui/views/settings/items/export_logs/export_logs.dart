import 'package:defood/ui/widgets/settings/common/item_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'export_logs_model.dart';

class ExportLogs extends StackedView<ExportLogsModel> {
  const ExportLogs({super.key});

  @override
  Widget builder(
    BuildContext context,
    ExportLogsModel viewModel,
    Widget? child,
  ) {
    return InkWell(
      onTap: () => viewModel.exportLogs(),
      child: const ItemWrapper(
        mainText: 'Export logs',
        secondaryText: 'Save ZIP file with logs in Downloads/DeFood',
      ),
    );
  }

  @override
  ExportLogsModel viewModelBuilder(
    BuildContext context,
  ) =>
      ExportLogsModel();
}
