import 'dart:async';

import 'package:defood/ui/views/camera/camera_viewmodel.dart';
import 'package:defood/ui/views/camera/items/scanner_buttons.dart';
import 'package:defood/ui/views/camera/items/scanner_error.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:stacked/stacked.dart';

class CameraView extends StackedView<CameraViewModel> with WidgetsBindingObserver {
  const CameraView({super.key});

  Widget _buildBarcode(Barcode? value) {
    if (value == null) {
      return const Text(
        'Scan something!',
        overflow: TextOverflow.fade,
        style: TextStyle(color: Colors.white),
      );
    }

    return Text(
      value.displayValue ?? 'No display value.',
      overflow: TextOverflow.fade,
      style: const TextStyle(color: Colors.white),
    );
  }

  @override
  Widget builder(BuildContext context, CameraViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan barcode')),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: viewModel.controller,
            errorBuilder: (context, error, child) {
              return ScannerErrorWidget(error: error);
            },
            fit: BoxFit.contain,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 100,
              color: Colors.black.withOpacity(0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ToggleFlashlightButton(controller: viewModel.controller),
                  StartStopMobileScannerButton(controller: viewModel.controller),
                  Expanded(child: Center(child: _buildBarcode(viewModel.barcode))),
                  SwitchCameraButton(controller: viewModel.controller),
                  AnalyzeImageFromGalleryButton(controller: viewModel.controller),
                ],
              ),
            ),
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
    WidgetsBinding.instance.addObserver(this);

    viewModel.subscription =
        viewModel.controller.barcodes.listen(viewModel.handleBarcode);

    unawaited(viewModel.controller.start());
  }

  @override
  Future<void> onDispose(CameraViewModel viewModel) async {
    super.onDispose(viewModel);
    WidgetsBinding.instance.removeObserver(this);
    unawaited(viewModel.subscription?.cancel());
    viewModel.subscription = null;
    await viewModel.controller.dispose();
  }
}

// class CameraView extends StatefulWidget {
//   const CameraView({super.key});

//   @override
//   State<CameraView> createState() => _CameraViewState();
// }

// class _CameraViewState extends State<CameraView> with WidgetsBindingObserver {
//   final MobileScannerController controller = MobileScannerController(
//     autoStart: false,
//     torchEnabled: true,
//     useNewCameraSelector: true,
//   );

//   Barcode? _barcode;
//   StreamSubscription<Object?>? _subscription;

//   Widget _buildBarcode(Barcode? value) {
//     if (value == null) {
//       return const Text(
//         'Scan something!',
//         overflow: TextOverflow.fade,
//         style: TextStyle(color: Colors.white),
//       );
//     }

//     return Text(
//       value.displayValue ?? 'No display value.',
//       overflow: TextOverflow.fade,
//       style: const TextStyle(color: Colors.white),
//     );
//   }

//   void _handleBarcode(BarcodeCapture barcodes) {
//     if (mounted) {
//       setState(() {
//         _barcode = barcodes.barcodes.firstOrNull;
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);

//     _subscription = controller.barcodes.listen(_handleBarcode);

//     unawaited(controller.start());
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (!controller.value.isInitialized) {
//       return;
//     }

//     switch (state) {
//       case AppLifecycleState.detached:
//       case AppLifecycleState.hidden:
//       case AppLifecycleState.paused:
//         return;
//       case AppLifecycleState.resumed:
//         _subscription = controller.barcodes.listen(_handleBarcode);

//         unawaited(controller.start());
//       case AppLifecycleState.inactive:
//         unawaited(_subscription?.cancel());
//         _subscription = null;
//         unawaited(controller.stop());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Scan barcode')),
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           MobileScanner(
//             controller: controller,
//             errorBuilder: (context, error, child) {
//               return ScannerErrorWidget(error: error);
//             },
//             fit: BoxFit.contain,
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               alignment: Alignment.bottomCenter,
//               height: 100,
//               color: Colors.black.withOpacity(0.4),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ToggleFlashlightButton(controller: controller),
//                   StartStopMobileScannerButton(controller: controller),
//                   Expanded(child: Center(child: _buildBarcode(_barcode))),
//                   SwitchCameraButton(controller: controller),
//                   AnalyzeImageFromGalleryButton(controller: controller),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Future<void> dispose() async {
//     WidgetsBinding.instance.removeObserver(this);
//     unawaited(_subscription?.cancel());
//     _subscription = null;
//     super.dispose();
//     await controller.dispose();
//   }
// }
