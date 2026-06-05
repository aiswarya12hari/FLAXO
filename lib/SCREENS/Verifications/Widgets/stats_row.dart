import 'package:flutter/material.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';

class StatsRow extends StatelessWidget {
  final String checkInTime;
  final String totalHours;
  final String checkOutTime;

  const StatsRow({
    super.key,
    required this.checkInTime,
    required this.totalHours,
    required this.checkOutTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStat(checkInTime, 'Check in'),
          _buildDivider(),
          _buildStat(totalHours, 'Total Hours'),
          _buildDivider(),
          _buildStat(checkOutTime, 'Check out'),
        ],
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: AppStyle.text(
            size: 16,
            weight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppStyle.text(
            size: 11,
            weight: FontWeight.w400,
            color: Colors.white54,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 32,
      width: 1,
      color: Colors.white12,
    );
  }
}