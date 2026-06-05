// lib/SCREENS/Profile/Widgets/profile_avatar.dart

import 'package:flutter/material.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final String fullName;
  final String admissionNo;
  final String gymName;

  const ProfileAvatar({
    super.key,
    required this.imageUrl,
    required this.fullName,
    required this.admissionNo,
    required this.gymName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Avatar
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFFF6A00), width: 3),
            color: const Color(0xFFFFEEE5),
          ),
          child: ClipOval(
            child: imageUrl.isNotEmpty
                ? Image.network(
                    'https://gymsoftware.archanastones.in$imageUrl',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _fallbackIcon(fullName),
                  )
                : _fallbackIcon(fullName),
          ),
        ),

        const SizedBox(height: 14),

        // Full Name
        Text(
          fullName,
          style: AppStyle.text(
            size: 22,
            weight: FontWeight.w700,
            color: const Color(0xFF1A1A1A),
          ),
        ),

        const SizedBox(height: 4),

        // Admission No
        Text(
          admissionNo,
          style: AppStyle.text(
            size: 13,
            weight: FontWeight.w400,
            color: const Color(0xFF888888),
          ),
        ),

        const SizedBox(height: 8),

        // Gym Name Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            color: const Color(0xFFFFEEE5),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: const Color(0xFFFFD5B8)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.fitness_center,
                  color: Color(0xFFFF6A00), size: 13),
              const SizedBox(width: 5),
              Text(
                gymName,
                style: AppStyle.text(
                  size: 12,
                  weight: FontWeight.w500,
                  color: const Color(0xFFFF6A00),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _fallbackIcon(String name) {
    return Container(
      color: const Color(0xFFFF6A00),
      child: Center(
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : 'U',
          style: const TextStyle(
            fontSize: 36,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}