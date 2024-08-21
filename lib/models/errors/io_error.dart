import 'package:defood/models/errors/base/app_error.dart';

final class IOError extends AppError {
  IOError(super.message, [super.reason]);
}
