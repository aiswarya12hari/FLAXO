// import 'package:flutter/material.dart';
// import 'package:gym_user/WIDGETS/appstyle.dart';

// class SuccessSheet extends StatelessWidget {
//   final VoidCallback onContinue;

//   const SuccessSheet({super.key, required this.onContinue});

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Column(
//       children: [
//         // ── Success icon + text ──
//         Text(
//           'Success 🎉',
//           style: AppStyle.text(
//             context: context,
//             size: 22,
//             weight: FontWeight.w700,
//             color: Colors.white,
//           ),
//         ),
//         SizedBox(height: screenHeight * 0.007),

//         Text(
//           "You're checked in.",
//           style: AppStyle.text(
//             context: context,
//             size: 14,
//             weight: FontWeight.w400,
//             color: Colors.white60,
//           ),
//         ),
//         SizedBox(height: screenHeight * 0.025),

//         // ── Continue button ──
//         SizedBox(
//           width: double.infinity,
//           height: screenHeight * 0.065,
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.orange,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(screenWidth * 0.08),
//               ),
//               elevation: 0,
//             ),
//             onPressed: onContinue,
//             child: Text(
//               'Continue',
//               style: AppStyle.text(
//                 context: context,
//                 size: 17,
//                 weight: FontWeight.w700,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';

class SuccessSheet extends StatelessWidget {
  final VoidCallback onContinue;
  final bool isAlreadyCheckedIn;

  const SuccessSheet({
    super.key,
    required this.onContinue,
    this.isAlreadyCheckedIn = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        // ── Success icon + text ──
        Text(
          isAlreadyCheckedIn ? 'Already Checked In 👋' : 'Success 🎉',
          style: AppStyle.text(
            context: context,
            size: 22,
            weight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: screenHeight * 0.007),

        Text(
          isAlreadyCheckedIn
              ? "You've already checked in today."
              : "You're checked in.",
          style: AppStyle.text(
            context: context,
            size: 14,
            weight: FontWeight.w400,
            color: Colors.white60,
          ),
        ),
        SizedBox(height: screenHeight * 0.025),

        // ── Continue button ──
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
            onPressed: onContinue,
            child: Text(
              'Continue',
              style: AppStyle.text(
                context: context,
                size: 17,
                weight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}