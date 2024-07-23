import 'package:flutter/material.dart';

class StyledTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;

  const StyledTextField({super.key, this.hintText, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary
      ),
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.tertiary
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary
          )
        ),
        fillColor: Theme.of(context).colorScheme.secondary,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary
        )
      ),
    );
  }
}