import 'package:flutter_background_sms/src/handlers/sms_result_handler.dart';
import 'package:flutter_background_sms/src/services/sms_services/sms_service_interface.dart';

/// Handles sending SMS specifically for Android.
class AndroidSmsSender {
  final ISmsService smsService; /// Interface for sending SMS.

  /// Creates an instance of [AndroidSmsSender].
  ///
  /// Requires [smsService] to manage SMS actions.
  AndroidSmsSender({
    required this.smsService,
  });

  /// Sends an SMS for Android.
  ///
  /// [simSlot]: The SIM slot to use for sending SMS.
  /// [appName]: The name of the application sending the SMS.
  /// [shortCode]: The recipient's shortcode.
  /// [callBack]: A callback function to handle the result of the SMS sending action.
  ///
  /// Returns a boolean indicating the success of the SMS sending action.
  Future<bool> sendSms({
    required int simSlot,
    required String appName,
    required String shortCode,
    required SmsResultCallback callBack,
  }) async {
    return await smsService.sendAndroidSms(
      simSlot: simSlot,
      appName: appName,
      shortCode: shortCode,
      callBack: callBack,
    );
  }
}
