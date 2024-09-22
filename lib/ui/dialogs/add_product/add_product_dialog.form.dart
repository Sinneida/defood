// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:defood/ui/dialogs/add_product/add_product_dialog_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String ProductNameValueKey = 'productName';
const String AmountValueKey = 'amount';
const String PriceValueKey = 'price';

final Map<String, TextEditingController> _AddProductDialogTextEditingControllers = {};

final Map<String, FocusNode> _AddProductDialogFocusNodes = {};

final Map<String, String? Function(String?)?> _AddProductDialogTextValidations = {
  ProductNameValueKey: AddProductValidators.validateProductName,
  AmountValueKey: AddProductValidators.validateAmount,
  PriceValueKey: AddProductValidators.validatePrice,
};

mixin $AddProductDialog {
  TextEditingController get productNameController =>
      _getFormTextEditingController(ProductNameValueKey);
  TextEditingController get amountController =>
      _getFormTextEditingController(AmountValueKey);
  TextEditingController get priceController =>
      _getFormTextEditingController(PriceValueKey);

  FocusNode get productNameFocusNode => _getFormFocusNode(ProductNameValueKey);
  FocusNode get amountFocusNode => _getFormFocusNode(AmountValueKey);
  FocusNode get priceFocusNode => _getFormFocusNode(PriceValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_AddProductDialogTextEditingControllers.containsKey(key)) {
      return _AddProductDialogTextEditingControllers[key]!;
    }

    _AddProductDialogTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _AddProductDialogTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_AddProductDialogFocusNodes.containsKey(key)) {
      return _AddProductDialogFocusNodes[key]!;
    }
    _AddProductDialogFocusNodes[key] = FocusNode();
    return _AddProductDialogFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    productNameController.addListener(() => _updateFormData(model));
    amountController.addListener(() => _updateFormData(model));
    priceController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    productNameController.addListener(() => _updateFormData(model));
    amountController.addListener(() => _updateFormData(model));
    priceController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          ProductNameValueKey: productNameController.text,
          AmountValueKey: amountController.text,
          PriceValueKey: priceController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _AddProductDialogTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _AddProductDialogFocusNodes.values) {
      focusNode.dispose();
    }

    _AddProductDialogTextEditingControllers.clear();
    _AddProductDialogFocusNodes.clear();
  }
}

extension ValueProperties on FormStateHelper {
  bool get hasAnyValidationMessage =>
      this.fieldsValidationMessages.values.any((validation) => validation != null);

  bool get isFormValid {
    if (!_autoTextFieldValidation) this.validateForm();

    return !hasAnyValidationMessage;
  }

  String? get productNameValue => this.formValueMap[ProductNameValueKey] as String?;
  String? get amountValue => this.formValueMap[AmountValueKey] as String?;
  String? get priceValue => this.formValueMap[PriceValueKey] as String?;

  set productNameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({ProductNameValueKey: value}),
    );

    if (_AddProductDialogTextEditingControllers.containsKey(ProductNameValueKey)) {
      _AddProductDialogTextEditingControllers[ProductNameValueKey]?.text = value ?? '';
    }
  }

  set amountValue(String? value) {
    this.setData(
      this.formValueMap..addAll({AmountValueKey: value}),
    );

    if (_AddProductDialogTextEditingControllers.containsKey(AmountValueKey)) {
      _AddProductDialogTextEditingControllers[AmountValueKey]?.text = value ?? '';
    }
  }

  set priceValue(String? value) {
    this.setData(
      this.formValueMap..addAll({PriceValueKey: value}),
    );

    if (_AddProductDialogTextEditingControllers.containsKey(PriceValueKey)) {
      _AddProductDialogTextEditingControllers[PriceValueKey]?.text = value ?? '';
    }
  }

  bool get hasProductName =>
      this.formValueMap.containsKey(ProductNameValueKey) &&
      (productNameValue?.isNotEmpty ?? false);
  bool get hasAmount =>
      this.formValueMap.containsKey(AmountValueKey) && (amountValue?.isNotEmpty ?? false);
  bool get hasPrice =>
      this.formValueMap.containsKey(PriceValueKey) && (priceValue?.isNotEmpty ?? false);

  bool get hasProductNameValidationMessage =>
      this.fieldsValidationMessages[ProductNameValueKey]?.isNotEmpty ?? false;
  bool get hasAmountValidationMessage =>
      this.fieldsValidationMessages[AmountValueKey]?.isNotEmpty ?? false;
  bool get hasPriceValidationMessage =>
      this.fieldsValidationMessages[PriceValueKey]?.isNotEmpty ?? false;

  String? get productNameValidationMessage =>
      this.fieldsValidationMessages[ProductNameValueKey];
  String? get amountValidationMessage => this.fieldsValidationMessages[AmountValueKey];
  String? get priceValidationMessage => this.fieldsValidationMessages[PriceValueKey];
}

extension Methods on FormStateHelper {
  setProductNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ProductNameValueKey] = validationMessage;
  setAmountValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[AmountValueKey] = validationMessage;
  setPriceValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PriceValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    productNameValue = '';
    amountValue = '';
    priceValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      ProductNameValueKey: getValidationMessage(ProductNameValueKey),
      AmountValueKey: getValidationMessage(AmountValueKey),
      PriceValueKey: getValidationMessage(PriceValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _AddProductDialogTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _AddProductDialogTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) => model.setValidationMessages({
      ProductNameValueKey: getValidationMessage(ProductNameValueKey),
      AmountValueKey: getValidationMessage(AmountValueKey),
      PriceValueKey: getValidationMessage(PriceValueKey),
    });
