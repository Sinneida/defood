import 'package:defood/ui/widgets/settings/common/item_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'show_logs_model.dart';

class ShowLogs extends StackedView<ShowLogsModel> {
  const ShowLogs({super.key});

  @override
  Widget builder(
    BuildContext context,
    ShowLogsModel viewModel,
    Widget? child,
  ) {
    return InkWell(
      onTap: () => viewModel.showLogsViewer(),
      onLongPress: () => viewModel.showLogsViewer(raw: true),
      child: const ItemWrapper(
        mainText: 'Show logs',
      ),
    );
  }

  @override
  ShowLogsModel viewModelBuilder(
    BuildContext context,
  ) =>
      ShowLogsModel();
}
