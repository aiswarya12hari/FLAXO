// lib/SCREENS/Profile/Widgets/membership_card.dart

import 'package:flutter/material.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';

class MembershipCard extends StatelessWidget {
  final String packageName;
  final String startDate;
  final String endDate;
  final String status;
  final int daysRemaining;
  final String paidAmount;
  final String paymentMethod;

  const MembershipCard({
    super.key,
    required this.packageName,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.daysRemaining,
    required this.paidAmount,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = status == 'Active';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6A00), Color(0xFFFF8C38)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF6A00).withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: package + status badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                packageName,
                style: AppStyle.text(
                  size: 17,
                  weight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: AppStyle.text(
                    size: 11,
                    weight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Dates row
          Row(
            children: [
              _dateChip('Start', startDate),
              const SizedBox(width: 12),
              const Icon(Icons.arrow_forward, color: Colors.white54, size: 16),
              const SizedBox(width: 12),
              _dateChip('End', endDate),
            ],
          ),

          const SizedBox(height: 16),

          // Divider
          Container(height: 1, color: Colors.white24),

          const SizedBox(height: 16),

          // Bottom row: paid + days
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '₹$paidAmount',
                    style: AppStyle.text(
                      size: 18,
                      weight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    paymentMethod,
                    style: AppStyle.text(
                      size: 11,
                      weight: FontWeight.w400,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$daysRemaining',
                    style: AppStyle.text(
                      size: 22,
                      weight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'days left',
                    style: AppStyle.text(
                      size: 11,
                      weight: FontWeight.w400,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── In _dateChip() — replace both TextStyle(...) with AppStyle.text() ──

  Widget _dateChip(String label, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyle.text(
            // ← was TextStyle(...)
            size: 10,
            weight: FontWeight.w400,
            color: Colors.white60,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          date,
          style: AppStyle.text(
            // ← was TextStyle(...)
            size: 13,
            weight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
