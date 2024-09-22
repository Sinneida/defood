import 'package:defood/app/app.locator.dart';
import 'package:defood/utils/logger_helper.dart';
import 'package:defood/utils/notification_helper.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CameraViewModel extends BaseViewModel with NotificationHelper, LoggerHelper {
  final _nav = locator<NavigationService>();
  bool _camera = false;

  final controller = MobileScannerController(
    autoStart: false,
    torchEnabled: false,
    useNewCameraSelector: false,
    formats: const [BarcodeFormat.ean13, BarcodeFormat.ean8],
  );

  Future<void> requestCameraPermission() async {
    final result = await Permission.camera.request();
    _camera = result.isGranted;
  }

  Future<void> init() async {
    try {
      _camera = await Permission.camera.status.isGranted;
      if (!_camera) {
        await requestCameraPermission();
        if (_camera) {
          _nav.back();
        }
      }
    } catch (e) {
      logError('Cannot init vire', e);
    }
  }

  void handleBarcode(BarcodeCapture barcodes) {
    final barcode = barcodes.barcodes.firstOrNull;
    if (barcode == null) {
      notifyInfo('Wrong barcode');
    }
    _nav.back(result: barcode);
  }
}
