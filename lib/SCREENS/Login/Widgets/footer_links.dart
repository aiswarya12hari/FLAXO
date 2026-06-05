import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';

class FooterLinks extends StatelessWidget {
  final VoidCallback? onForgotPassword;
  final VoidCallback? onTermsOfService;
  final VoidCallback? onPrivacyPolicy;

  const FooterLinks({
    super.key,
    this.onForgotPassword,
    this.onTermsOfService,
    this.onPrivacyPolicy,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Forgot Password Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Forgot Password ? ',
              
              style: AppStyle.text(size: 14, color: Color(0xFF6B7280)),
            ),
            GestureDetector(
              onTap: onForgotPassword,
              child:  Text(
                'Contact Admin',
                
                style: AppStyle.text(size: 14, weight: FontWeight.w600, color: Color(0xFFFF6A00)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        // Terms & Privacy Row
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              
              style: AppStyle.text(size: 12, color: Color(0xFF6B7280), height: 1.5),
            children: [
              const TextSpan(text: 'By clicking Continue, you agree to our\n'),
              TextSpan(
                text: 'Terms of Service',
                
                style: AppStyle.text(color: Color(0xFFFF6B00), weight: FontWeight.w500),
                recognizer: TapGestureRecognizer()..onTap = onTermsOfService,
              ),
              const TextSpan(text: ' and '),
              TextSpan(
                text: 'Privacy Policy',
                
                style: AppStyle.text(color: Color(0xFFFF6A00), weight: FontWeight.w500),
                recognizer: TapGestureRecognizer()..onTap = onPrivacyPolicy,
              ),
            ],
          ),
        ),
      ],
    );
  }
}