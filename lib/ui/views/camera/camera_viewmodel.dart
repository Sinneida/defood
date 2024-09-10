import 'dart:async';

import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:stacked/stacked.dart';

class CameraViewModel extends BaseViewModel {
  final controller = MobileScannerController(
    autoStart: false,
    torchEnabled: true,
    useNewCameraSelector: true,
  );

  Barcode? barcode;
  StreamSubscription<Object?>? subscription;

  void handleBarcode(BarcodeCapture barcodes) {
    if (initialised) {
      barcode = barcodes.barcodes.firstOrNull;
      rebuildUi();
    }
  }
}
