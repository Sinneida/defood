import 'package:defood/app/app.locator.dart';
import 'package:defood/utils/notification_helper.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CameraViewModel extends BaseViewModel with NotificationHelper {
  final _nav = locator<NavigationService>();

  final controller = MobileScannerController(
    autoStart: false,
    torchEnabled: false,
    useNewCameraSelector: true,
    formats: const [BarcodeFormat.ean13, BarcodeFormat.ean8],
  );

  void handleBarcode(BarcodeCapture barcodes) {
    final barcode = barcodes.barcodes.firstOrNull;
    if (barcode == null) {
      notifyInfo('Wrong barcode');
    }
    _nav.back(result: barcode);
  }
}
