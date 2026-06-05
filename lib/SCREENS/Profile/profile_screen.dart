// lib/SCREENS/Profile/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:gym_user/PROVIDERS/Profile%20Page/profile_provider.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';
import 'package:provider/provider.dart';

import 'Widgets/membership_card.dart';
import 'Widgets/profile_avatar.dart';
import 'Widgets/profile_info_tile.dart';
import 'Widgets/profile_section_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<ProfileProvider>().loadProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios,
                  color: Color(0xFF1A1A1A), size: 20),
            ),
            title: Text(
              'My Profile',
              style: AppStyle.text(
                size: 16,
                weight: FontWeight.w500,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            centerTitle: true,
          ),

          body: provider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFFFF6A00),
                  ),
                )
              : provider.errorMessage != null
                  ? _buildError(provider)
                  : _buildBody(provider),
        );
      },
    );
  }

  Widget _buildError(ProfileProvider provider) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.wifi_off_rounded,
              color: Color(0xFFFF6A00), size: 48),
          const SizedBox(height: 12),
          Text(
            provider.errorMessage!,
            style: AppStyle.text(
              size: 14,
              weight: FontWeight.w400,
              color: const Color(0xFF888888),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6A00),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: provider.loadProfile,
            child: const Text('Retry',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(ProfileProvider provider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        children: [
          /// Avatar + Name
          ProfileAvatar(
            imageUrl: provider.faceImage1,
            fullName: provider.fullName,
            admissionNo: provider.admissionNo,
            gymName: provider.gymName,
          ),

          const SizedBox(height: 24),

          /// Membership Card
          MembershipCard(
            packageName: provider.packageName,
            startDate: provider.startDate,
            endDate: provider.endDate,
            status: provider.membershipStatus,
            daysRemaining: provider.daysRemaining,
            paidAmount: provider.paidAmount,
            paymentMethod: provider.paymentMethod,
          ),

          const SizedBox(height: 20),

          /// Personal Info
          ProfileSectionCard(
            title: 'Personal Information',
            children: [
              ProfileInfoTile(
                icon: Icons.email_outlined,
                label: 'Email',
                value: provider.email,
              ),
              ProfileInfoTile(
                icon: Icons.phone_outlined,
                label: 'Phone',
                value: provider.phoneNumber,
              ),
              ProfileInfoTile(
                icon: Icons.cake_outlined,
                label: 'Date of Birth',
                value: provider.formattedDob,
              ),
              ProfileInfoTile(
                icon: Icons.person_outline,
                label: 'Gender',
                value: provider.gender,
              ),
              ProfileInfoTile(
                icon: Icons.bloodtype_outlined,
                label: 'Blood Group',
                value: provider.bloodGroup,
              ),
              ProfileInfoTile(
                icon: Icons.home_outlined,
                label: 'Address',
                value: provider.presentAddress,
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// Payment Info
          ProfileSectionCard(
            title: 'Payment Details',
            children: [
              ProfileInfoTile(
                icon: Icons.receipt_outlined,
                label: 'Total Amount',
                value: '₹${provider.totalAmount}',
              ),
              ProfileInfoTile(
                icon: Icons.discount_outlined,
                label: 'Discount',
                value: '₹${provider.discountAmount}',
              ),
              ProfileInfoTile(
                icon: Icons.payments_outlined,
                label: 'Final Amount',
                value: '₹${provider.finalAmount}',
              ),
              ProfileInfoTile(
                icon: Icons.check_circle_outline,
                label: 'Paid Amount',
                value: '₹${provider.paidAmount}',
              ),
              ProfileInfoTile(
                icon: Icons.credit_card_outlined,
                label: 'Payment Method',
                value: provider.paymentMethod,
              ),
            ],
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}