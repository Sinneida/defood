import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

// expiration date, expiration type, price?, amount

class AddProductDialogModel extends BaseViewModel {
  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;
  set selectedDate(DateTime value) {
    _selectedDate = value;
    rebuildUi();
  }

  String formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }
}
