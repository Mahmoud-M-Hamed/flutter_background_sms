import 'package:flutter/services.dart';
import 'package:flutter_background_sms/src/handlers/sms_result_handler.dart';
import 'package:flutter_background_sms/src/services/sms_services/sms_sender_service.dart';
import 'package:flutter_background_sms/src/services/sms_services/sms_service_interface.dart';
import 'package:flutter_background_sms/src/services/storage_service/secure_storage.dart';
import 'package:flutter_background_sms/src/utils/message_preparer_Util.dart';

/// A service class responsible for sending SMS messages on both Android and iOS platforms.
class SmsService implements ISmsService {
  /// Reference to the method channel for sending SMS.
  static const platform = MethodChannel('SEND_SMS_METHOD_CHANNEL');

  final SecureStorage _secureStorage = SecureStorage();
  final MessagePreparer _messagePreparer;
  final SmsSender _smsSender;
  final SmsResultHandler _resultHandler;

  /// Constructs an instance of [SmsService].
  ///
  /// Initializes the [MessagePreparer], [SmsSender], and [SmsResultHandler] services.
  SmsService()
      : _messagePreparer = MessagePreparer(SecureStorage()),
        _smsSender = SmsSender(),
        _resultHandler = SmsResultHandler();

  /// Sends an SMS message via Android.
  ///
  /// Takes the necessary parameters to send an SMS and notifies the developer
  /// of the result through the provided callback.
  ///
  /// Parameters:
  /// - [simSlot]: The SIM slot to use for sending the SMS (0 for SIM1, 1 for SIM2).
  /// - [callBack]: A callback function that receives a map with the result of the SMS sending attempt.
  /// - [shortCode]: The recipient's phone number or shortcode to which the SMS will be sent.
  /// - [appName]: The name of the application sending the SMS.
  ///
  /// Returns:
  /// - A [Future] that resolves to a [bool], indicating whether the SMS was sent successfully.
  @override
  Future<bool> sendAndroidSms({
    required int simSlot,
    required SmsResultCallback callBack,
    required String shortCode,
    required String appName,
  }) async {
    try {
      /// Prepare the message body for sending.
      final String hashedBody = await _messagePreparer.prepareMessage();

      /// Send the SMS using the specified SIM slot.
      final bool result = await _smsSender.sendAndroidSms(
        appName: appName,
        hashedBody: hashedBody,
        simSlot: simSlot,
        shortCode: shortCode,
      );

      /// Retrieve the UUID from secure storage.
      String? uuid = await _secureStorage.retrieveKey();

      /// Notify the developer using the success result map.
      final callbackSuccessResult = _resultHandler.callbackSuccessResult(uuid: uuid, status: result);
      callBack(callbackSuccessResult);
      return result;
    } catch (e) {
      /// Notify the developer using the failure result map.
      final callbackFailureResult = _resultHandler.callbackFailureResult(exception: e);
      callBack(callbackFailureResult);
      return false;
    }
  }

  /// Sends an SMS message via iOS.
  ///
  /// Takes the necessary parameters to send an SMS and notifies the developer
  /// of the result through the provided callback.
  ///
  /// Parameters:
  /// - [callBack]: A callback function that receives a map with the result of the SMS sending attempt.
  /// - [shortCode]: The recipient's phone number or shortcode to which the SMS will be sent.
  /// - [appName]: The name of the application sending the SMS.
  ///
  /// Returns:
  /// - A [Future] that resolves to void.
  @override
  Future<void> sendIosSms({
    required SmsResultCallback callBack,
    required String shortCode,
    required String appName,
  }) async {
    try {
      /// Prepare the message body for sending.
      final String hashedBody = await _messagePreparer.prepareMessage();

      /// Launch the iOS SMS app with the prepared message.
      await _smsSender.launchIosSmsApp(appName, hashedBody, shortCode);

      /// Retrieve the UUID from secure storage.
      String? uuid = await _secureStorage.retrieveKey();

      /// Notify the developer using the success result map.
      final callbackSuccessResult = _resultHandler.callbackSuccessResult(uuid: uuid, status: true);
      callBack(callbackSuccessResult); // Assuming SMS launch is successful
    } catch (e) {
      /// Notify the developer using the failure result map.
      final callbackFailureResult = _resultHandler.callbackFailureResult(exception: e);
      callBack(callbackFailureResult);
    }
  }
}
