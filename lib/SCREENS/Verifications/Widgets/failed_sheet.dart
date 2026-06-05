import 'package:flutter/material.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';

class FailedSheet extends StatelessWidget {
  final VoidCallback onTryAgain;
  final VoidCallback onBack;
  final String message;

  const FailedSheet({
    super.key,
    required this.onTryAgain,
    required this.onBack,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Text(
          'Check-in Failed ❌',
          style: AppStyle.text(
            context: context,
            size: 20,
            weight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: screenHeight * 0.007),

        Text(
          message,
          textAlign: TextAlign.center,
          style: AppStyle.text(
            context: context,
            size: 14,
            color: Colors.white70,
          ),
        ),
        SizedBox(height: screenHeight * 0.025),

        // ── Try Again ──
        SizedBox(
          width: double.infinity,
          height: screenHeight * 0.065,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.08),
              ),
              elevation: 0,
            ),
            onPressed: onTryAgain,
            child: Text(
              'Try Again',
              style: AppStyle.text(
                context: context,
                size: 17,
                weight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),

        SizedBox(height: screenHeight * 0.012),

        // ── Back ──
        SizedBox(
          width: double.infinity,
          height: screenHeight * 0.056,
          child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.08),
                side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
              ),
            ),
            onPressed: onBack,
            child: Text(
              'Back',
              style: AppStyle.text(
                context: context,
                size: 15,
                weight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
          ),
        ),
      ],
    );
  }
}