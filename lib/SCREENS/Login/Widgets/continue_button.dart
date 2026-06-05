import 'package:flutter/material.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';

class ContinueButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final bool isLoading;

  const ContinueButton({
    super.key,
    required this.onPressed,
    this.label = "Log in",
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        // Disable button while loading
        onPressed: isLoading ? null : onPressed,

        style: ElevatedButton.styleFrom(
          backgroundColor: AppStyle.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),

        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : Text(
                label,
                style: AppStyle.text(
                  size: 18,
                  weight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}