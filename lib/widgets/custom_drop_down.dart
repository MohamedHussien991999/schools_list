import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown(
      {super.key,
      required this.selectedValue,
      required this.onChanged,
      required this.validateDropdown,
      required this.items, 
      required this.labelText,
       required this.hintText
       });
  final String? selectedValue;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validateDropdown;
  final List<DropdownMenuItem<String>>? items;
  final String labelText;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue ,
      onChanged: onChanged,
      items: items,
      hint: Text(hintText),
      validator: validateDropdown,
      decoration:  InputDecoration(
        labelText: hintText,
      ),
    );
  }
}
