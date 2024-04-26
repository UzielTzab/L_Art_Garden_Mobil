import 'package:flutter/services.dart';

class DateTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;
    if ((newValue.text.length == 4 || newValue.text.length == 7) &&
        oldValue.text.length < newValue.text.length) {
      newText += '-';
    } else if ((oldValue.text.length == 5 || oldValue.text.length == 8) &&
        oldValue.text.length > newValue.text.length) {
      newText = newText.substring(0, newText.length - 1);
    }
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
