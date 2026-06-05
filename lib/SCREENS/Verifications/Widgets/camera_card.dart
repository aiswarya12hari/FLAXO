import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:gym_user/PROVIDERS/VERIFICATION%20PAGE/verification_provider.dart';

class CameraCard extends StatelessWidget {
  final CameraController? controller;
  final bool isInitialized;
  final VerificationStatus status;
  final double cameraHeight;
  final String? capturedImagePath;

  const CameraCard({
    super.key,
    required this.controller,
    required this.isInitialized,
    required this.status,
    required this.cameraHeight,
    this.capturedImagePath,
  });

  Color get _borderColor {
    switch (status) {
      case VerificationStatus.success:
        return Colors.green;
      case VerificationStatus.failed:
        return Colors.red;
      case VerificationStatus.scanning:
        return Colors.white24;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        width: 292,
        height: 406,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23),
          border: Border.all(
            color: _borderColor,
            width: 3,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: _buildCameraContent(),
        ),
      ),
    );
  }

  Widget _buildCameraContent() {
    // Show captured image while processing or after result
    if (capturedImagePath != null) {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..scale(-1.0, 1.0),
        child: Image.file(
          File(capturedImagePath!),
          fit: BoxFit.cover,
        ),
      );
    }

    // Live camera preview
    if (isInitialized && controller != null) {
      return CameraPreview(controller!);
    }

    // Loading placeholder
    return Container(
      color: const Color(0xFF2A2A2A),
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.white38,
          strokeWidth: 2,
        ),
      ),
    );
  }
}