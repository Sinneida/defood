import 'package:defood/app/app.locator.dart';
import 'package:defood/services/auth_service.dart';
import 'package:stacked/stacked.dart';

class UserCardModel extends BaseViewModel {
  final _auth = locator<AuthService>();

  String? get avatarUrl {
    return _auth.avatarUrl;
  }

  String? get userName {
    return _auth.userName;
  }

  String? get userEmail {
    return _auth.userEmail;
  }
}
