import 'package:flutter/material.dart';
import 'dart:async';

import 'package:gym_user/WIDGETS/appstyle.dart';

class LiveClockWidget extends StatefulWidget {
  const LiveClockWidget({super.key});

  @override
  State<LiveClockWidget> createState() => _LiveClockWidgetState();
}

class _LiveClockWidgetState extends State<LiveClockWidget> {
  late DateTime _now;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(DateTime dt) {
    final hour = dt.hour > 12
        ? dt.hour - 12
        : (dt.hour == 0 ? 12 : dt.hour);
    final minute = dt.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String _amPm(DateTime dt) => dt.hour >= 12 ? 'PM' : 'AM';

  String _formatDate(DateTime dt) {
    const days = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday',
      'Friday', 'Saturday', 'Sunday'
    ];
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${days[dt.weekday - 1]}, ${months[dt.month - 1]} ${dt.day}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              _formatTime(_now),
              
              style: AppStyle.text(size: 44, weight: FontWeight.w600, color: Color(0xFF232323), height: 1),
            ),
            const SizedBox(width: 6),
            Text(
              _amPm(_now),
              
              style: AppStyle.text(size: 24, weight: FontWeight.w600, color: Color(0xFF232323)),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          _formatDate(_now),
          
          style: AppStyle.text(size: 13, color: Color(0xFF333B69), weight: FontWeight.w300),
        ),
      ],
    );
  }
}