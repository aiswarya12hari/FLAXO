// lib/SCREENS/Profile/Widgets/profile_section_card.dart

import 'package:flutter/material.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';

class ProfileSectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const ProfileSectionCard({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyle.text(
              size: 13,
              weight: FontWeight.w700,
              color: const Color(0xFFFF6A00),
            ),
          ),
          const SizedBox(height: 4),
          const Divider(color: Color(0xFFF0F0F0)),
          ...children,
        ],
      ),
    );
  }
}