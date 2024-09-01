import 'package:defood/app/app.locator.dart';
import 'package:defood/services/auth_service.dart';
import 'package:stacked/stacked.dart';

class UserCardModel extends BaseViewModel {
  final _auth = locator<AuthService>();

  String? get avatarUrl {
    return _auth.account?.user?.userMetadata?['avatar_url'];
  }

  String? get userName {
    return _auth.account?.user?.userMetadata?['name'];
  }

  String? get userEmail {
    return _auth.account?.user?.email;
  }
}
