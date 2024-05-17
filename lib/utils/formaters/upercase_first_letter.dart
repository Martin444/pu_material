import 'package:flutter/services.dart';

class UppercaseFirstLetterFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;
    final formattedText = _capitalizeFirstLetter(newText);
    return newValue.copyWith(text: formattedText);
  }

  String _capitalizeFirstLetter(String text) {
    return text.split(' ').map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1);
      } else {
        return '';
      }
    }).join(' ');
  }
}
