// import 'dart:convert';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:gym_user/CORE/Services/sharedpreference.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// enum VerificationStatus { scanning, success, failed }

// class VerificationProvider with ChangeNotifier {
//   CameraController? _cameraController;
//   bool _isCameraInitialized = false;
//   VerificationStatus _status = VerificationStatus.scanning;
//   bool _isProcessing = false;
//   String? _errorMessage;
//   String? _capturedImagePath;

//   CameraController? get cameraController => _cameraController;
//   bool get isCameraInitialized => _isCameraInitialized;
//   VerificationStatus get status => _status;
//   bool get isProcessing => _isProcessing;
//   String? get errorMessage => _errorMessage;
//   String? get capturedImagePath => _capturedImagePath;

//   /// Initialize Camera
//   Future<void> initCamera() async {
//     try {
//       final cameras = await availableCameras();
//       if (cameras.isEmpty) return;

//       final frontCam = cameras.firstWhere(
//         (c) => c.lensDirection == CameraLensDirection.front,
//         orElse: () => cameras.first,
//       );

//       _cameraController = CameraController(
//         frontCam,
//         ResolutionPreset.high,
//         enableAudio: false,
//       );

//       await _cameraController!.initialize();
//       _isCameraInitialized = true;
//       notifyListeners();
//     } catch (e) {
//       debugPrint('Camera Error: $e');
//     }
//   }

//   /// Get Device Location
//   Future<Position?> _getLocation() async {
//     try {
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) return null;
//       }
//       if (permission == LocationPermission.deniedForever) return null;

//       return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//     } catch (e) {
//       debugPrint('Location Error: $e');
//       return null;
//     }
//   }

//   /// Capture Face + Call Check-In API
//   Future<void> performCheckIn() async {
//     if (_isProcessing) return;

//     _isProcessing = true;
//     _errorMessage = null;
//     notifyListeners();

//     try {
//       // 1. Capture face image
//       if (_cameraController == null || !_isCameraInitialized) {
//         throw Exception('Camera not ready');
//       }

//       final XFile imageFile = await _cameraController!.takePicture();
//       _capturedImagePath = imageFile.path;
//       notifyListeners();

//       // 2. Get location
//       final position = await _getLocation();
//       final latitude = position?.latitude.toString() ?? '0.0';
//       final longitude = position?.longitude.toString() ?? '0.0';

//       print("$latitude $longitude");
//       print("suiiiiiii");

//       // 3. Get auth token
//       final token = await SharedPrefService.getAccessToken();

//       // 4. Build multipart request
//       final uri = Uri.parse(
//         'https://gymsoftware.archanastones.in/api/user/checkin/',
//       );

//       final request = http.MultipartRequest('POST', uri)
//         ..headers['Authorization'] = 'Bearer $token'
//         ..fields['latitude'] = latitude
//         ..fields['longitude'] = longitude
//         ..files.add(
//           await http.MultipartFile.fromPath('face_image', imageFile.path),
//         );

//       final streamedResponse = await request.send();
//       final response = await http.Response.fromStream(streamedResponse);

//       debugPrint('CheckIn Response: ${response.statusCode} ${response.body}');

//       final data = jsonDecode(response.body);

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         if (data['success'] == true) {
//           _status = VerificationStatus.success;

//           final checkin = data['checkin'];

//           final prefs = await SharedPreferences.getInstance();

//           await prefs.setString(
//             'check_in_time',
//             checkin['check_in_time'] ?? '',
//           );

//           await prefs.setString(
//             'check_out_time',
//             checkin['check_out_time'] ?? '',
//           );

//           await prefs.setString(
//             'total_hours',
//             checkin['duration_formatted'] ?? '0h 0m',
//           );
//         } else {
//           _errorMessage = data['message'] ?? 'Check-in failed.';
//           _status = VerificationStatus.failed;
//         }
//       } else {
//         _errorMessage =
//             data['message'] ?? 'Server error: ${response.statusCode}';
//         _status = VerificationStatus.failed;
//       }
//     } catch (e) {
//       debugPrint('CheckIn Error: $e');
//       _errorMessage = 'Something went wrong. Please try again.';
//       _status = VerificationStatus.failed;
//     }

//     _isProcessing = false;
//     notifyListeners();
//   }

//   void setStatus(VerificationStatus status) {
//     _status = status;
//     notifyListeners();
//   }

//   void resetVerification() {
//     _status = VerificationStatus.scanning;
//     _errorMessage = null;
//     _isProcessing = false;
//     _capturedImagePath = null;
//     notifyListeners();
//   }

//   Future<void> disposeCamera() async {
//     await _cameraController?.dispose();
//   }
// }


import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gym_user/CORE/Services/sharedpreference.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

enum VerificationStatus { scanning, success, failed }

class VerificationProvider with ChangeNotifier {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  VerificationStatus _status = VerificationStatus.scanning;
  bool _isProcessing = false;
  String? _errorMessage;
  String? _capturedImagePath;
  bool _isAlreadyCheckedIn = false;

  CameraController? get cameraController => _cameraController;
  bool get isCameraInitialized => _isCameraInitialized;
  VerificationStatus get status => _status;
  bool get isProcessing => _isProcessing;
  String? get errorMessage => _errorMessage;
  String? get capturedImagePath => _capturedImagePath;
  bool get isAlreadyCheckedIn => _isAlreadyCheckedIn;

  /// Initialize Camera
  Future<void> initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return;

      final frontCam = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _cameraController = CameraController(
        frontCam,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _cameraController!.initialize();
      _isCameraInitialized = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Camera Error: $e');
    }
  }

  /// Get Device Location
  Future<Position?> _getLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return null;
      }
      if (permission == LocationPermission.deniedForever) return null;

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      debugPrint('Location Error: $e');
      return null;
    }
  }

  /// Capture Face + Call Check-In API
  Future<void> performCheckIn() async {
    if (_isProcessing) return;

    _isProcessing = true;
    _errorMessage = null;
    _isAlreadyCheckedIn = false;
    notifyListeners();

    try {
      // 1. Capture face image
      if (_cameraController == null || !_isCameraInitialized) {
        throw Exception('Camera not ready');
      }

      final XFile imageFile = await _cameraController!.takePicture();
      _capturedImagePath = imageFile.path;
      notifyListeners();

      // 2. Get location
      final position = await _getLocation();
      final latitude = position?.latitude.toString() ?? '0.0';
      final longitude = position?.longitude.toString() ?? '0.0';

      print("$latitude $longitude");
      print("suiiiiiii");

      // 3. Get auth token
      final token = await SharedPrefService.getAccessToken();

      // 4. Build multipart request
      final uri = Uri.parse(
        'https://gymsoftware.archanastones.in/api/user/checkin/',
      );

      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..fields['latitude'] = latitude
        ..fields['longitude'] = longitude
        ..files.add(
          await http.MultipartFile.fromPath('face_image', imageFile.path),
        );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      debugPrint('CheckIn Response: ${response.statusCode} ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (data['success'] == true) {
          _status = VerificationStatus.success;

          final checkin = data['checkin'];

          final prefs = await SharedPreferences.getInstance();

          await prefs.setString(
            'check_in_time',
            checkin['check_in_time'] ?? '',
          );

          await prefs.setString(
            'check_out_time',
            checkin['check_out_time'] ?? '',
          );

          await prefs.setString(
            'total_hours',
            checkin['duration_formatted'] ?? '0h 0m',
          );
        } else {
          final message = data['message'] ?? '';

          // Already checked in → show success instead of failed
          if (message.toString().toLowerCase().contains('already checked in')) {
            _isAlreadyCheckedIn = true;
            _status = VerificationStatus.success;
          } else {
            _errorMessage = message.isNotEmpty ? message : 'Check-in failed.';
            _status = VerificationStatus.failed;
          }
        }
      } else {
        final message = data['message'] ?? '';

        // Already checked in can also come as 400
        if (message.toString().toLowerCase().contains('already checked in')) {
          _isAlreadyCheckedIn = true;
          _status = VerificationStatus.success;
        } else {
          _errorMessage =
              message.isNotEmpty ? message : 'Server error: ${response.statusCode}';
          _status = VerificationStatus.failed;
        }
      }
    } catch (e) {
      debugPrint('CheckIn Error: $e');
      _errorMessage = 'Something went wrong. Please try again.';
      _status = VerificationStatus.failed;
    }

    _isProcessing = false;
    notifyListeners();
  }

  void setStatus(VerificationStatus status) {
    _status = status;
    notifyListeners();
  }

  void resetVerification() {
    _status = VerificationStatus.scanning;
    _errorMessage = null;
    _isProcessing = false;
    _capturedImagePath = null;
    _isAlreadyCheckedIn = false;
    notifyListeners();
  }

  Future<void> disposeCamera() async {
    await _cameraController?.dispose();
  }
}