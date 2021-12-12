import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.controller,
    this.hintText = 'Label',
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.innerPadding = 16.0,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final double innerPadding;

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
        ),
      ),
    );
  }
}
