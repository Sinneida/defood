import 'package:defood/models/errors/base/app_error.dart';

final class UpdateError extends AppError {
  UpdateError(super.message, [super.reason]);
}
