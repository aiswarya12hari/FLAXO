import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';

class LocationBadge extends StatelessWidget {
  final String locationName;

  const LocationBadge({super.key, required this.locationName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFFDDDDDD), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/svg/gridicons_location.svg',
            width: 18,
            height: 18,
            colorFilter: const ColorFilter.mode(
              Color(0xFF333B69),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            locationName,
            style: AppStyle.text(size: 13, color: Color(0xFF333B69)),
          ),
        ],
      ),
    );
  }
}
