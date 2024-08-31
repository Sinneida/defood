import 'package:stacked/stacked.dart';

class AddBoxDialogModel extends FormViewModel {
  final message = 'Box is an abstraction of a place, where you keep your food products.';
  // final urlMessage = '';
  // final appMessage = 'messenger';
}

class AddBoxValidators {
  static String? validateBoxName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter box name';
    }
    return null;
  }
}
