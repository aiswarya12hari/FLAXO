// import 'package:flutter/material.dart';
// import 'package:gym_user/PROVIDERS/Checkin%20Page/checkinprovider.dart';
// import 'package:gym_user/SCREENS/Profile/profile_screen.dart';
// import 'package:gym_user/WIDGETS/appstyle.dart';
// import 'package:provider/provider.dart';

// import 'package:gym_user/SCREENS/Login/login_screen.dart';
// import 'package:gym_user/SCREENS/Verifications/verification.dart';

// import 'Widgets/header.dart';
// import 'Widgets/live_clock_widget.dart';
// import 'Widgets/check_in_button.dart';
// import 'Widgets/location_badge.dart';
// import 'Widgets/attendance_stats_row.dart';

// class CheckinoutScreen extends StatefulWidget {
//   const CheckinoutScreen({super.key});

//   @override
//   State<CheckinoutScreen> createState() => _CheckinoutScreenState();
// }

// class _CheckinoutScreenState extends State<CheckinoutScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       context.read<CheckinProvider>().loadUserData();
//     });
//   }

//   Future<void> _handleRefresh() async {
//     await context.read<CheckinProvider>().loadUserData();
//   }

//   Future<void> _handleCheckInOut() async {
//     final provider = context.read<CheckinProvider>();

//     final result = await Navigator.push<bool>(
//       context,
//       PageRouteBuilder<bool>(
//         opaque: false,
//         barrierColor: Colors.transparent,
//         pageBuilder: (context, _, __) => VerificationScreen(
//           userName: provider.userName,
//           userAvatar: '',
//           isCheckIn: true,
//         ),
//         transitionsBuilder: (context, animation, _, child) {
//           return FadeTransition(opacity: animation, child: child);
//         },
//       ),
//     );

//     if (result == true && mounted) {
//       // provider.updateAttendance();
//     }
//   }

//   Future<void> _handleLogout() async {
//     await context.read<CheckinProvider>().logout();

//     if (!mounted) return;

//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (_) => const LoginScreen()),
//       (route) => false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Responsive helper
//     final sh = MediaQuery.of(context).size.height;

//     return Consumer<CheckinProvider>(
//       builder: (context, provider, child) {
//         return Scaffold(
//           backgroundColor: const Color(0xFFF0F0F0),
//           body: SafeArea(
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: AppStyle.text(context: context, size: 20).fontSize ?? 20,
//                 vertical: sh * 0.04, // 4% of screen height instead of fixed 35
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   /// Header
//                   HomeHeader(
//                     userName: provider.userName,
//                     onLogout: _handleLogout,
//                     onProfile: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const ProfileScreen(),
//                         ),
//                       );
//                     },
//                   ),

//                   SizedBox(height: sh * 0.045), // ~40px on 375 screen

//                   /// Live Clock
//                   const LiveClockWidget(),

//                   SizedBox(height: sh * 0.055), // ~50px on 375 screen

//                   /// Check In Button
//                   CheckInButton(isCheckedIn: false, onTap: _handleCheckInOut),

//                   SizedBox(height: sh * 0.035), // ~30px on 375 screen

//                   /// Gym Name
//                   LocationBadge(locationName: provider.gymName),

//                   const Spacer(),

//                   /// Attendance Stats
//                   AttendanceStatsRow(
//                     checkInTime: provider.checkInTime,
//                     // totalHours: provider.totalHours,
//                     // checkOutTime: provider.checkOutTime,
//                   ),

//                   SizedBox(height: sh * 0.02), // ~18px on 375 screen
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:gym_user/PROVIDERS/Checkin%20Page/checkinprovider.dart';
import 'package:gym_user/SCREENS/Profile/profile_screen.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';
import 'package:provider/provider.dart';

import 'package:gym_user/SCREENS/Login/login_screen.dart';
import 'package:gym_user/SCREENS/Verifications/verification.dart';

import 'Widgets/header.dart';
import 'Widgets/live_clock_widget.dart';
import 'Widgets/check_in_button.dart';
import 'Widgets/location_badge.dart';
import 'Widgets/attendance_stats_row.dart';

class CheckinoutScreen extends StatefulWidget {
  const CheckinoutScreen({super.key});

  @override
  State<CheckinoutScreen> createState() => _CheckinoutScreenState();
}

class _CheckinoutScreenState extends State<CheckinoutScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<CheckinProvider>().loadUserData();
    });
  }

  Future<void> _handleRefresh() async {
    await context.read<CheckinProvider>().loadUserData();
  }

  Future<void> _handleCheckInOut() async {
    final provider = context.read<CheckinProvider>();

    final result = await Navigator.push<bool>(
      context,
      PageRouteBuilder<bool>(
        opaque: false,
        barrierColor: Colors.transparent,
        pageBuilder: (context, _, __) => VerificationScreen(
          userName: provider.userName,
          userAvatar: '',
          isCheckIn: true,
        ),
        transitionsBuilder: (context, animation, _, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );

    if (result == true && mounted) {
      // provider.updateAttendance();
    }
  }

  Future<void> _handleLogout() async {
    await context.read<CheckinProvider>().logout();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Responsive helper
    final sh = MediaQuery.of(context).size.height;

    return Consumer<CheckinProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xFFF0F0F0),
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: _handleRefresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppStyle.text(context: context, size: 20).fontSize ?? 20,
                        vertical: sh * 0.04,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// Header
                          HomeHeader(
                            userName: provider.userName,
                            onLogout: _handleLogout,
                            onProfile: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ProfileScreen(),
                                ),
                              );
                            },
                          ),

                          SizedBox(height: sh * 0.045),

                          /// Live Clock
                          const LiveClockWidget(),

                          SizedBox(height: sh * 0.055),

                          /// Check In Button
                          CheckInButton(isCheckedIn: false, onTap: _handleCheckInOut),

                          SizedBox(height: sh * 0.035),

                          /// Gym Name
                          LocationBadge(locationName: provider.gymName),

                          const Spacer(),

                          /// Attendance Stats
                          AttendanceStatsRow(
                            checkInTime: provider.checkInTime,
                            // totalHours: provider.totalHours,
                            // checkOutTime: provider.checkOutTime,
                          ),

                          SizedBox(height: sh * 0.02),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}