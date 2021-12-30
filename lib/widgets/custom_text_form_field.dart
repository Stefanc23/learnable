import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String initialValue;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final double innerPadding;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomTextFormField(
      {Key? key,
      required this.controller,
      this.hintText = 'Label',
      this.initialValue = '',
      this.validator,
      this.obscureText = false,
      this.keyboardType,
      this.innerPadding = 16.0,
      this.enabled = true,
      this.prefixIcon,
      this.suffixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        obscureText: obscureText,
        keyboardType: keyboardType,
        enabled: enabled,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(innerPadding),
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(),
          labelStyle: Theme.of(context).textTheme.bodyText2,
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.bodyText2,
          focusColor: Theme.of(context).primaryColor,
          errorStyle: const TextStyle(
            color: Color(0xffff0000),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
