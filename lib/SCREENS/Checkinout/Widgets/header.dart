import 'package:flutter/material.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final String? avatarImagePath;
  final VoidCallback? onLogout;
  final VoidCallback? onProfile;

  const HomeHeader({
    super.key,
    required this.userName,
    this.avatarImagePath,
    this.onLogout,
    this.onProfile,
  });

  Future<void> _showLogoutDialog(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 32),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFFF6A00).withOpacity(0.12),
                ),
                child: const Icon(
                  Icons.logout_rounded,
                  color: Color(0xFFFF6A00),
                  size: 32,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Logout',
                style: AppStyle.text(
                  size: 22,
                  weight: FontWeight.w700,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Are you sure you want to log out?',
                textAlign: TextAlign.center,
                style: AppStyle.text(
                  size: 14,
                  weight: FontWeight.w400,
                  color: const Color(0xFF888888),
                ),
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(ctx, false),
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color(0xFFE0E0E0),
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'No',
                            style: AppStyle.text(
                              size: 16,
                              weight: FontWeight.w600,
                              color: const Color(0xFF1A1A1A),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(ctx, true),
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6A00),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            'Yes',
                            style: AppStyle.text(
                              size: 16,
                              weight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (confirmed == true && onLogout != null) {
      onLogout!();
    }
  }

  void _showSettingsMenu(BuildContext context) {
    final RenderBox button =
        context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject()
            as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(
          Offset(button.size.width - 160, button.size.height + 8),
          ancestor: overlay,
        ),
        button.localToGlobal(
          Offset(button.size.width, button.size.height + 8),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    showMenu<String>(
      context: context,
      position: position,
      color: Colors.white,
      elevation: 12,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      items: [
        /// Profile Option
        PopupMenuItem<String>(
          value: 'profile',
          padding: EdgeInsets.zero,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEEE5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    color: Color(0xFFFF6A00),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Profile',
                  style: AppStyle.text(
                    size: 14,
                    weight: FontWeight.w500,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
          ),
        ),

        /// Divider
        const PopupMenuItem<String>(
          enabled: false,
          padding: EdgeInsets.zero,
          height: 1,
          child: Divider(
            height: 1,
            color: Color(0xFFF0F0F0),
            indent: 16,
            endIndent: 16,
          ),
        ),

        /// Logout Option
        PopupMenuItem<String>(
          value: 'logout',
          padding: EdgeInsets.zero,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEEE5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.logout_rounded,
                    color: Color(0xFFFF6A00),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Logout',
                  style: AppStyle.text(
                    size: 14,
                    weight: FontWeight.w500,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ).then((value) {
      if (value == 'logout') {
        _showLogoutDialog(context);
      } else if (value == 'profile') {
        if (onProfile != null) onProfile!();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// Welcome Text
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back,',
              style: AppStyle.text(
                size: 14,
                color: const Color(0xFF232323),
                weight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              userName,
              style: AppStyle.text(
                size: 22,
                weight: FontWeight.w600,
                color: const Color(0xFFFF6A00),
              ),
            ),
          ],
        ),

        /// Avatar + Settings
        Row(
          children: [
            /// Avatar Circle
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFE0E0E0),
                  width: 2,
                ),
                image: avatarImagePath != null
                    ? DecorationImage(
                        image: AssetImage(avatarImagePath!),
                        fit: BoxFit.cover,
                      )
                    : null,
                color: avatarImagePath == null
                    ? const Color(0xFFFF6B00)
                    : null,
              ),
              child: avatarImagePath == null
                  ? Center(
                      child: Text(
                        userName.isNotEmpty
                            ? userName[0].toUpperCase()
                            : 'U',
                        style: AppStyle.text(
                          size: 18,
                          color: Colors.white,
                          weight: FontWeight.bold,
                        ),
                      ),
                    )
                  : null,
            ),

            const SizedBox(width: 10),

            /// Settings Button
            Builder(
              builder: (btnContext) => GestureDetector(
                onTap: () => _showSettingsMenu(btnContext),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEEE5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFFFD5B8),
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.settings_rounded,
                    color: Color(0xFFFF6A00),
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}