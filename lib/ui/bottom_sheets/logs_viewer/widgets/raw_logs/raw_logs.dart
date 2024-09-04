import 'package:defood/ui/bottom_sheets/logs_viewer/widgets/raw_logs/raw_logs_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

class RawLogs extends StackedView<RawLogsModel> {
  const RawLogs({super.key, required this.logs});

  final List<String> logs;

  @override
  Widget builder(BuildContext context, RawLogsModel viewModel, Widget? child) {
    return Text.rich(
      TextSpan(children: [
        for (final line in logs)
          TextSpan(children: [
            TextSpan(
              text: '$line\n\n',
              style: GoogleFonts.jetBrainsMono(),
            ),
          ])
      ]),
    );
  }

  @override
  RawLogsModel viewModelBuilder(BuildContext context) => RawLogsModel();
}
