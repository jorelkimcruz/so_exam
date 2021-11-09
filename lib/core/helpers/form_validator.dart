/// same function signature as FormTextField's validator;
typedef FormFieldValidator<T> = String? Function(T? value);

abstract class FieldValidator<T> {
  FieldValidator(this.errorText);

  /// checks the input against the given conditions
  bool isValid(T value);

  /// the errorText to display when the validation fails
  final String errorText;

  /// call is a special function that makes a class callable
  /// returns null if the input is valid otherwise it returns the provided error errorText
  String? call(T value) {
    return isValid(value) ? null : errorText;
  }
}

abstract class TextFieldValidator extends FieldValidator<String?> {
  TextFieldValidator(String errorText) : super(errorText);

  // return false if you want the validator to return error
  // message when the value is empty.
  bool get ignoreEmptyValues => true;

  @override
  String? call(String? value) {
    return (ignoreEmptyValues && value!.isEmpty) ? null : super.call(value);
  }

  /// helper function to check if an input matches a given pattern
  bool hasMatch(String pattern, String input, {bool caseSensitive: true}) =>
      RegExp(pattern, caseSensitive: caseSensitive).hasMatch(input);
}

class RequiredValidator extends TextFieldValidator {
  RequiredValidator({required String errorText}) : super(errorText);

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {
    return value!.isNotEmpty;
  }

  @override
  String? call(String? value) {
    return isValid(value) ? null : errorText;
  }
}

class MaxLengthValidator extends TextFieldValidator {
  MaxLengthValidator(this.max, {required String errorText}) : super(errorText);

  @override
  bool isValid(String? value) {
    return value!.length <= max;
  }

  final int max;
}

class MinLengthValidator extends TextFieldValidator {
  MinLengthValidator(this.min, {required String errorText}) : super(errorText);

  @override
  bool get ignoreEmptyValues => false;

  final int min;

  @override
  bool isValid(String? value) {
    return value!.length >= min;
  }
}

class MultiValidator extends FieldValidator<String?> {
  MultiValidator(this.validators) : super(_errorText);

  final List<FieldValidator> validators;
  static String _errorText = '';

  @override
  bool isValid(dynamic value) {
    for (final FieldValidator validator in validators) {
      if (validator.call(value) != null) {
        _errorText = validator.errorText;
        return false;
      }
    }
    return true;
  }

  @override
  String? call(dynamic value) {
    return isValid(value) ? null : _errorText;
  }
}
