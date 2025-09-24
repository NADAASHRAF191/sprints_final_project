import 'colors.dart';
import 'package:flutter/material.dart';


abstract class FormFieldStyle {
  static OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: AppColors.textFieldBackground),
  );
}
