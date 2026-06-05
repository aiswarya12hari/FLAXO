import 'package:flutter/material.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';

class LocationRow extends StatelessWidget {
  final String locationName;

  const LocationRow({
    super.key,
    required this.locationName,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.location_on,
              color: Colors.orange,
              size: 14,
            ),
            const SizedBox(width: 5),
            Text(
              locationName,
              style: AppStyle.text(
                size: 12,
                weight: FontWeight.w400,
                color: Colors.white60,
              ),
            ),
          ],
        ),
      ),
    );
  }
}