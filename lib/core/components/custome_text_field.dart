import 'package:flutter/material.dart';
import 'spaces.dart';

class CustomTextField extends StatelessWidget {
  final String? validator;
  final TextEditingController controller;
  final String label;
  final Function(String value)? onChanged;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool showLabel;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final int maxLines;
  final InputDecoration? decoration;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType,
    this.showLabel = true,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.maxLines = 1,
    this.decoration,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          Text(
            label,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.03,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SpaceHeight(3.0),
        ],
        TextFormField(
          autovalidateMode: AutovalidateMode.disabled,
          validator: (vl) {
            if (validator != null && (vl == null || vl.isEmpty)) {
              return validator;
            }
            return null;
          },
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardType,
          readOnly: readOnly,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: readOnly
                ? const Icon(Icons.lock_outline, size: 18, color: Colors.grey)
                : suffixIcon,
            filled: true,
            fillColor: readOnly ? Colors.grey.shade100 : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            hintText: label,
            errorStyle: const TextStyle(height: 1),
          ),

        ),
      ],
    );
  }
}
