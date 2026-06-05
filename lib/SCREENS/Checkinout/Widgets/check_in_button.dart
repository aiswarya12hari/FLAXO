import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gym_user/WIDGETS/appstyle.dart';

class CheckInButton extends StatefulWidget {
  final bool isCheckedIn;
  final VoidCallback onTap;

  const CheckInButton({
    super.key,
    required this.isCheckedIn,
    required this.onTap,
  });

  @override
  State<CheckInButton> createState() => _CheckInButtonState();
}

class _CheckInButtonState extends State<CheckInButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ── Layer 1: Outermost light grey circle ──
          Container(
            width: 285,
            height: 245,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xCCFFFDFD),
            ),
          ),

          // ── Layer 2: White/near-white ring ──
          Container(
            width: 239,
            height: 238,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFD9D9D9),
            ),
          ),

          // ── Layer 3 + Layer 4: Both rotating together ──
          AnimatedBuilder(
            animation: _rotationController,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationController.value * 2 * 3.14159265,
                child: child,
              );
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                // ── Layer 3: Soft glow ring (now rotating) ──
                Container(
                  width: 210,
                  height: 210,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      // colors: widget.isCheckedIn
                      //     ? [
                      //         const Color(0xFFFFDDCC), // light orange top
                      //         const Color(0xFFFFCCB3), // mid orange
                      //         const Color(0xFFFFB347), // warm orange bottom
                      //       ]
                      //     : [
                      //         const Color(0xFFD4F5DC), // light green top
                      //         const Color(0xFFB8E6C1), // mid green
                      //         const Color(0xFF8ED4A0), // deeper green bottom
                      //       ],
                      colors: [
                        const Color(0xFFD4F5DC),
                        const Color(0xFFB8E6C1),
                        const Color(0xFF8ED4A0),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),

                // ── Layer 4: Main gradient button (rotating) ──
                Container(
                  width: 196,
                  height: 196,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      // colors: widget.isCheckedIn
                      //     ? [
                      //         const Color(0xFFFFB347),
                      //         const Color(0xFFFF8C00),
                      //         const Color(0xFFE65C00),
                      //       ]
                      //     : [const Color(0xFF5DD16F), const Color(0xFF1E8C34)],
                      colors: [
                        const Color(0xFF5DD16F),
                        const Color(0xFF1E8C34),
                      ],
                      stops: widget.isCheckedIn ? [0.0, 0.5, 1.0] : null,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        // color:
                        //     (widget.isCheckedIn
                        //             ? const Color(0xFFFF6A00)
                        //             : const Color(0xFF2EAD47))
                        //         .withOpacity(0.5),
                        color: const Color(0xFF2EAD47).withOpacity(0.5),
                        blurRadius: 24,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Layer 5: Icon + Text (always stays still) ──
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/svg/Vector (3).svg',
                width: 46,
                height: 46,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                // widget.isCheckedIn ? 'Check Out' : 'Check In',
                'Check In',
                style: AppStyle.text(
                  size: 18,
                  weight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}