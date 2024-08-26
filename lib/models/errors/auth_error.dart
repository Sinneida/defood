import 'package:defood/models/errors/base/app_error.dart';

final class AuthError extends AppError {
  AuthError(super.message, [super.reason]);
}
