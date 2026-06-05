import 'package:flutter/material.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  /// Validation
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  State<CustomTextField> createState() =>
      _CustomTextFieldState();
}

class _CustomTextFieldState
    extends State<CustomTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();

    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppStyle.text(
            size: 14,
            weight: FontWeight.w500,
            color: const Color(0xFF6B7280),
          ),
        ),

        const SizedBox(height: 8),

        SizedBox(
          height: 78,
          child: TextFormField(
            controller: widget.controller,

            obscureText: _isObscured,

            keyboardType: widget.keyboardType,

            validator: widget.validator,

            style: AppStyle.text(
              size: 14,
              weight: FontWeight.w400,
              color: const Color(0xFF111827),
            ),

            decoration: InputDecoration(
              hintText: widget.hintText,

              hintStyle: AppStyle.text(
                size: 14,
                weight: FontWeight.w400,
                color: const Color(0xFF9CA3AF),
              ),

              prefixIcon: Icon(
                widget.prefixIcon,
                color: AppStyle.primaryColor,
                size: 20,
              ),

              suffixIcon: widget.obscureText
                  ? IconButton(
                      icon: Icon(
                        _isObscured
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color:
                            AppStyle.primaryColor,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscured =
                              !_isObscured;
                        });
                      },
                    )
                  : null,

              filled: true,
              fillColor: Colors.white,

              contentPadding:
                  const EdgeInsets.symmetric(
                vertical: 16,
              ),

              errorStyle: AppStyle.text(
                size: 12,
                color: Colors.red,
                weight: FontWeight.w400,
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppStyle.primaryColor,
                  width: 1,
                ),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppStyle.primaryColor,
                  width: 1.2,
                ),
              ),

              errorBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
              ),

              focusedErrorBorder:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1.2,
                ),
              ),

              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}