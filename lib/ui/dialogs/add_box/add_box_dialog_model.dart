import 'package:stacked/stacked.dart';

class AddBoxDialogModel extends FormViewModel {
  final message =
      'Please provide a name for a new box. Box is a place where you keep your food products, i.e. fridge, closet or drawer.';
}

class AddBoxValidators {
  static String? validateBoxName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter box name';
    }
    return null;
  }
}
