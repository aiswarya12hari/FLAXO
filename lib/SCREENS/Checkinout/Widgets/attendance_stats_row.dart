import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';

class AttendanceStatItem extends StatelessWidget {
  final String svgPath;
  final String value;
  final String label;

  const AttendanceStatItem({
    super.key,
    required this.svgPath,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          svgPath,
          width: 34,
          height: 34,
          colorFilter: const ColorFilter.mode(
            Color(0xFFFF6B00),
            BlendMode.srcIn,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          value.isEmpty ? '--:--' : value,
          style: AppStyle.text(
            size: 18,
            weight: FontWeight.w700,
            color: const Color(0xFF232323),
          ),
        ),

        const SizedBox(height: 4),

        Text(
          label,
          style: AppStyle.text(
            size: 12,
            color: const Color(0xFF333B69),
          ),
        ),
      ],
    );
  }
}

class AttendanceStatsRow extends StatelessWidget {
  final String checkInTime;

  const AttendanceStatsRow({
    super.key,
    required this.checkInTime,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AttendanceStatItem(
        svgPath: 'assets/svg/Vector.svg',
        value: checkInTime,
        label: 'Check in',
      ),
    );
  }
}