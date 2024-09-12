import 'dart:async';

import 'package:defood/ui/views/camera/camera_viewmodel.dart';
import 'package:defood/ui/views/camera/items/scanner_buttons.dart';
import 'package:defood/ui/views/camera/items/scanner_error.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:stacked/stacked.dart';

class CameraView extends StackedView<CameraViewModel> {
  const CameraView({super.key});

  @override
  Widget builder(BuildContext context, CameraViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan barcode'),
        centerTitle: true,
        elevation: 1,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ToggleFlashlightButton(controller: viewModel.controller),
            // Expanded(child: Center(child: _buildBarcode(viewModel.barcode))),
            AnalyzeImageFromGalleryButton(controller: viewModel.controller),
          ],
        ),
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: viewModel.controller,
            errorBuilder: (context, error, child) {
              return ScannerErrorWidget(error: error);
            },
            onDetect: (barcodes) => viewModel.handleBarcode(barcodes),
            fit: BoxFit.fitWidth,
          ),
        ],
      ),
    );
  }

  @override
  CameraViewModel viewModelBuilder(BuildContext context) => CameraViewModel();

  @override
  void onViewModelReady(CameraViewModel viewModel) {
    super.onViewModelReady(viewModel);
    unawaited(viewModel.controller.start());
  }

  @override
  Future<void> onDispose(CameraViewModel viewModel) async {
    super.onDispose(viewModel);
    await viewModel.controller.dispose();
  }
}
