import 'package:defood/ui/bottom_sheets/logs_viewer/logs_viewer_model.dart';
import 'package:defood/ui/bottom_sheets/logs_viewer/widgets/log_formatter/log_formatter.dart';
import 'package:defood/ui/bottom_sheets/logs_viewer/widgets/raw_logs/raw_logs.dart';
import 'package:defood/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

Future<T?> showLogsViewSheet<T>({bool raw = false}) {
  return showModalBottomSheet<T>(
    useSafeArea: true,
    useRootNavigator: true,
    isScrollControlled: true,
    context: StackedService.navigatorKey!.currentContext!,
    builder: (context) {
      return ViewModelBuilder.reactive(
        viewModelBuilder: () => LogsViewerModel(),
        onViewModelReady: (viewModel) => viewModel.getLogs(),
        builder: (context, viewModel, child) {
          return Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  'Logs',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                verticalSpaceMedium,
                Expanded(
                  child: Material(
                    type: MaterialType.card,
                    surfaceTintColor: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(16),
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Scrollbar(
                        interactive: true,
                        child: SingleChildScrollView(
                          reverse: true,
                          child: viewModel.log.isEmpty
                              ? Text(
                                  'No logs',
                                  style: GoogleFonts.jetBrainsMono(),
                                )
                              : raw == true
                                  ? RawLogs(logs: viewModel.log)
                                  : LogFormatter(
                                      logs: viewModel.log,
                                    ),
                        ),
                      ),
                    ),
                  ),
                ),
                verticalSpaceMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilledButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
