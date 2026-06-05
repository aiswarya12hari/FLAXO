// lib/SCREENS/Profile/Widgets/profile_info_tile.dart

import 'package:flutter/material.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';

class ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileInfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon box
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFFFEEE5),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(icon, color: const Color(0xFFFF6A00), size: 18),
          ),

          const SizedBox(width: 14),

          // Label + Value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppStyle.text(
                    size: 11,
                    weight: FontWeight.w400,
                    color: const Color(0xFF888888),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value.isNotEmpty ? value : '—',
                  style: AppStyle.text(
                    size: 14,
                    weight: FontWeight.w500,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}