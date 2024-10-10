import 'package:flutter/services.dart';
import 'package:flutter_background_sms/src/services/sms_services/sms_service.dart';
import 'package:url_launcher/url_launcher.dart';

/// A class responsible for sending SMS on different platforms.
class SmsSender {

  /// Sends an SMS and processes the response from the native platform.
  Future<bool> sendAndroidSms({
    required String appName,
    required String hashedBody,
    required int simSlot,
    required String shortCode,
  }) async {
    try {
      final result = await SmsService.platform.invokeMethod('sendSMS', {
        'phoneNumber': shortCode, // Recipient's phone number
        'message': "$appName,$hashedBody", // Constructed message body
        'simSlot': simSlot, // SIM slot (0 for SIM1, 1 for SIM2)
      });
      return result; // Return the result of the SMS sending operation
    } on PlatformException catch (e) {
      throw FormatException("Failed to send SMS: '${e.message}'.");
    }
  }

  /// Launches the iOS SMS app to send a message.
  Future<void> launchIosSmsApp(String appName, String hashedBody, String phoneNumber) async {
    final Uri smsUri = Uri(
      scheme: 'sms', // SMS URI scheme
      path: phoneNumber, // Recipient's phone number
      queryParameters: {'body': "$appName,${Uri.encodeComponent(hashedBody)}"}, // Message body
    );

    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri); // Launch the SMS app
    } else {
      throw Exception('Could not launch SMS app');
    }
  }
}
