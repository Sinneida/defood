import 'package:defood/app/app.locator.dart';
import 'package:defood/services/auth_service.dart';
import 'package:stacked/stacked.dart';

class BoxesViewModel extends BaseViewModel {
  final _auth = locator<AuthService>();

  String? get avatar {
    return _auth.account?.user?.userMetadata?['avatar_url'];
  }
}
