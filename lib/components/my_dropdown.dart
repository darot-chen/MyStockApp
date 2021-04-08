import 'package:flutter/material.dart';
import 'package:my_stock/models/categories_model.dart';

class MyDropDown extends StatelessWidget {
  final List<Category> items;
  final double height;
  final Widget hintText;
  final Widget icon;
  final String value;
  final Function onChanged;
  final Function onSaved;
  final Function validator;

  MyDropDown({
    this.height,
    this.hintText,
    this.icon,
    this.items,
    this.value,
    this.onChanged,
    this.onSaved,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      itemHeight: height,
      items: List.generate(
        items.length,
        (index) {
          return DropdownMenuItem(
            child: Text(
              items[index].name,
            ),
            value: items[index].id,
          );
        },
      ),
      hint: hintText,
      validator: validator,
      icon: icon,
      onChanged: onChanged,
      onSaved: onSaved,
      decoration: InputDecoration(
        fillColor: Color(0xFFE1E1E1),
        filled: true,
        isDense: true,
        hintStyle: TextStyle(color: Color(0xFF4B5B75)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
    );
  }
}
