// import 'package:flutter/material.dart';
// import 'package:gym_user/WIDGETS/appstyle.dart';

// class VerificationHeader extends StatelessWidget {
//   final String userName;
//   final String userAvatar;
//   final VoidCallback onBack;

//   const VerificationHeader({
//     super.key,
//     required this.userName,
//     required this.userAvatar,
//     required this.onBack,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         // ── Back button ──
//         GestureDetector(
//           onTap: onBack,
//           child: const Icon(
//             Icons.arrow_back_ios,
//             color: Colors.white,
//             size: 20,
//           ),
//         ),

//         const SizedBox(width: 10),

//         // ── Welcome + Name ──
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Welcome Back,',
//               style: AppStyle.text(
//                 size: 12,
//                 weight: FontWeight.w400,
//                 color: Colors.white60,
//               ),
//             ),
//             Text(
//               userName,
//               style: AppStyle.text(
//                 size: 18,
//                 weight: FontWeight.w700,
//                 color: Colors.orange,
//               ),
//             ),
//           ],
//         ),

//         const Spacer(),

//         // ── Avatar ──
//         CircleAvatar(
//           radius: 26,
//           backgroundColor: Colors.grey.shade700,
//           backgroundImage:
//               userAvatar.isNotEmpty ? NetworkImage(userAvatar) : null,
//           child: userAvatar.isEmpty
//               ? const Icon(Icons.person, color: Colors.white, size: 26)
//               : null,
//         ),
//       ],
//     );
//   }
// }