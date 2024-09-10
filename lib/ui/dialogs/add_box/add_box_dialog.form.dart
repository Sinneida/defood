// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:defood/ui/dialogs/add_box/add_box_dialog_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String BoxNameValueKey = 'boxName';

final Map<String, TextEditingController> _AddBoxDialogTextEditingControllers =
    {};

final Map<String, FocusNode> _AddBoxDialogFocusNodes = {};

final Map<String, String? Function(String?)?> _AddBoxDialogTextValidations = {
  BoxNameValueKey: AddBoxValidators.validateBoxName,
};

mixin $AddBoxDialog {
  TextEditingController get boxNameController =>
      _getFormTextEditingController(BoxNameValueKey);

  FocusNode get boxNameFocusNode => _getFormFocusNode(BoxNameValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_AddBoxDialogTextEditingControllers.containsKey(key)) {
      return _AddBoxDialogTextEditingControllers[key]!;
    }

    _AddBoxDialogTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _AddBoxDialogTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_AddBoxDialogFocusNodes.containsKey(key)) {
      return _AddBoxDialogFocusNodes[key]!;
    }
    _AddBoxDialogFocusNodes[key] = FocusNode();
    return _AddBoxDialogFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    boxNameController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    boxNameController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          BoxNameValueKey: boxNameController.text,
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

    for (var controller in _AddBoxDialogTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _AddBoxDialogFocusNodes.values) {
      focusNode.dispose();
    }

    _AddBoxDialogTextEditingControllers.clear();
    _AddBoxDialogFocusNodes.clear();
  }
}

extension ValueProperties on FormStateHelper {
  bool get hasAnyValidationMessage => this
      .fieldsValidationMessages
      .values
      .any((validation) => validation != null);

  bool get isFormValid {
    if (!_autoTextFieldValidation) this.validateForm();

    return !hasAnyValidationMessage;
  }

  String? get boxNameValue => this.formValueMap[BoxNameValueKey] as String?;

  set boxNameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({BoxNameValueKey: value}),
    );

    if (_AddBoxDialogTextEditingControllers.containsKey(BoxNameValueKey)) {
      _AddBoxDialogTextEditingControllers[BoxNameValueKey]?.text = value ?? '';
    }
  }

  bool get hasBoxName =>
      this.formValueMap.containsKey(BoxNameValueKey) &&
      (boxNameValue?.isNotEmpty ?? false);

  bool get hasBoxNameValidationMessage =>
      this.fieldsValidationMessages[BoxNameValueKey]?.isNotEmpty ?? false;

  String? get boxNameValidationMessage =>
      this.fieldsValidationMessages[BoxNameValueKey];
}

extension Methods on FormStateHelper {
  setBoxNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[BoxNameValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    boxNameValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      BoxNameValueKey: getValidationMessage(BoxNameValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _AddBoxDialogTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _AddBoxDialogTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      BoxNameValueKey: getValidationMessage(BoxNameValueKey),
    });
