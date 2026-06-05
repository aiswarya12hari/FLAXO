// import 'package:flutter/material.dart';
// import 'package:gym_user/PROVIDERS/VERIFICATION PAGE/verification_provider.dart';
// import 'package:gym_user/SCREENS/Verifications/Widgets/camera_card.dart';
// import 'package:gym_user/WIDGETS/appstyle.dart';
// import 'package:provider/provider.dart';

// import 'widgets/failed_sheet.dart';
// import 'widgets/success_sheet.dart';

// class VerificationScreen extends StatefulWidget {
//   final String userName;
//   final String userAvatar;
//   final bool isCheckIn;

//   const VerificationScreen({
//     super.key,
//     required this.userName,
//     required this.userAvatar,
//     required this.isCheckIn,
//   });

//   @override
//   State<VerificationScreen> createState() => _VerificationScreenState();
// }

// class _VerificationScreenState extends State<VerificationScreen> {
//   @override
//   void initState() {
//     super.initState();

//     Future.microtask(() {
//       final provider = context.read<VerificationProvider>();
//       provider.resetVerification();
//       provider.initCamera();
//     });
//   }

//   @override
//   void dispose() {
//     context.read<VerificationProvider>().disposeCamera();
//     super.dispose();
//   }

//   void _onContinue() => Navigator.pop(context, true);
//   void _onBack() => Navigator.pop(context, false);

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<VerificationProvider>(context);
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Container(
//         decoration: const BoxDecoration(
//           color: Color(0xD9000000),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 32),

//                 /// Camera Card — centered
//                 CameraCard(
//                   controller: provider.cameraController,
//                   isInitialized: provider.isCameraInitialized,
//                   status: provider.status,
//                   cameraHeight: screenHeight * 0.48,
//                   capturedImagePath: provider.capturedImagePath,
//                 ),

//                 const SizedBox(height: 20),

//                 /// Status-based bottom section
//                 if (provider.status == VerificationStatus.scanning)
//                   _buildScanningState(provider),

//                 if (provider.status == VerificationStatus.success)
//                   SuccessSheet(onContinue: _onContinue),

//                 if (provider.status == VerificationStatus.failed)
//                   FailedSheet(
//                     message: provider.errorMessage ?? 'Verification failed',
//                     onTryAgain: () => provider.resetVerification(),
//                     onBack: _onBack,
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildScanningState(VerificationProvider provider) {
//     return Column(
//       children: [
//         Center(
//           child: Text(
//             provider.isProcessing ? 'Verifying...' : 'Scanning face...',
//             style: AppStyle.text(
//               size: 14,
//               weight: FontWeight.w400,
//               color: Colors.white54,
//             ),
//           ),
//         ),

//         const SizedBox(height: 20),

//         SizedBox(
//           width: double.infinity,
//           height: 54,
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.orange,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               elevation: 0,
//             ),
//             onPressed: provider.isProcessing
//                 ? null
//                 : () => provider.performCheckIn(),
//             child: provider.isProcessing
//                 ? const SizedBox(
//                     width: 22,
//                     height: 22,
//                     child: CircularProgressIndicator(
//                       color: Colors.white,
//                       strokeWidth: 2.5,
//                     ),
//                   )
//                 : Text(
//                     widget.isCheckIn ? 'Check In' : 'Check Out',
//                     style: AppStyle.text(
//                       size: 17,
//                       weight: FontWeight.w700,
//                       color: Colors.white,
//                     ),
//                   ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:gym_user/PROVIDERS/VERIFICATION PAGE/verification_provider.dart';
import 'package:gym_user/SCREENS/Verifications/Widgets/camera_card.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';
import 'package:provider/provider.dart';

import 'widgets/failed_sheet.dart';
import 'widgets/success_sheet.dart';

class VerificationScreen extends StatefulWidget {
  final String userName;
  final String userAvatar;
  final bool isCheckIn;

  const VerificationScreen({
    super.key,
    required this.userName,
    required this.userAvatar,
    required this.isCheckIn,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final provider = context.read<VerificationProvider>();
      provider.resetVerification();
      provider.initCamera();
    });
  }

  @override
  void dispose() {
    context.read<VerificationProvider>().disposeCamera();
    super.dispose();
  }

  void _onContinue() => Navigator.pop(context, true);
  void _onBack() => Navigator.pop(context, false);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<VerificationProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xD9000000),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),

                /// Camera Card — centered
                CameraCard(
                  controller: provider.cameraController,
                  isInitialized: provider.isCameraInitialized,
                  status: provider.status,
                  cameraHeight: screenHeight * 0.48,
                  capturedImagePath: provider.capturedImagePath,
                ),

                const SizedBox(height: 20),

                /// Status-based bottom section
                if (provider.status == VerificationStatus.scanning)
                  _buildScanningState(provider),

                if (provider.status == VerificationStatus.success)
                  SuccessSheet(
                    onContinue: _onContinue,
                    isAlreadyCheckedIn: provider.isAlreadyCheckedIn,
                  ),

                if (provider.status == VerificationStatus.failed)
                  FailedSheet(
                    message: provider.errorMessage ?? 'Verification failed',
                    onTryAgain: () => provider.resetVerification(),
                    onBack: _onBack,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScanningState(VerificationProvider provider) {
    return Column(
      children: [
        Center(
          child: Text(
            provider.isProcessing ? 'Verifying...' : 'Scanning face...',
            style: AppStyle.text(
              size: 14,
              weight: FontWeight.w400,
              color: Colors.white54,
            ),
          ),
        ),

        const SizedBox(height: 20),

        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 0,
            ),
            onPressed: provider.isProcessing
                ? null
                : () => provider.performCheckIn(),
            child: provider.isProcessing
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : Text(
                    widget.isCheckIn ? 'Check In' : 'Check Out',
                    style: AppStyle.text(
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