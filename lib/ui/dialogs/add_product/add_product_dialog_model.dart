import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:stacked/stacked.dart';
import 'package:intl/intl.dart';

part 'add_product_dialog_model.mapper.dart';

@MappableEnum()
enum ExpirationType {
  soft,
  hard,
  custom,
  notApply,
}

typedef ProductDto = ({
  String name,
  String amount,
  num? price,
  DateTime expirationDate,
  ExpirationType expirationType,
});

class AddProductDialogModel extends FormViewModel {
  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;
  set selectedDate(DateTime value) {
    _selectedDate = value;
    rebuildUi();
  }

  ExpirationType expirationType = ExpirationType.soft;

  Product? product;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
    }
    rebuildUi();
  }

  String formattedDate() {
    return 'Expiration date: ${DateFormat('dd-MM-yyyy').format(_selectedDate)}';
  }
}

class AddProductValidators {
  static String? validateProductName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter product name';
    }
    return null;
  }

  static String? validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter valid price';
    }
    return null;
  }

  static String? validateAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter valid amount';
    }
    return null;
  }
}
