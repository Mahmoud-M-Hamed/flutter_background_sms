import 'package:flutter_background_sms/src/handlers/sms_action_handler.dart';
import 'package:flutter_background_sms/src/handlers/sms_result_handler.dart';
import 'package:flutter_background_sms/src/services/permission_services/permission_service.dart';
import 'package:flutter_background_sms/src/services/sms_services/sms_service.dart';

/// The main class for managing SMS operations.
class FlutterBackgroundSms {
  /// The singleton instance of [FlutterPluginTest].
  static final FlutterBackgroundSms _instance = FlutterBackgroundSms._internal();

  /// Returns the singleton instance of [FlutterPluginTest].
  static FlutterBackgroundSms get instance => _instance;

  /// Private constructor to ensure the singleton pattern.
  FlutterBackgroundSms._internal();

  /// The handler for SMS actions, managing permissions and SMS services.
  late final SmsActionHandler _smsActionHandler;

  /// Initializes the SMS action handler with dependencies.
  void initialize(SmsActionHandler smsActionHandler) {
    _smsActionHandler = smsActionHandler;
  }

  /// Initializes permissions required for sending SMS.
  Future<void> initializePermissions() async {
    await _smsActionHandler.initializePermissions();
  }

  /// Sends an SMS using the specified parameters.
  ///
  /// [appName] is the name of the application.
  /// [shortCode] is the recipient's shortcode.
  /// [simSlot] specifies the SIM slot to use.
  /// [callback] is the function to handle the result of the SMS action.
  Future<void> sendSms({
    required String shortCode,
    required String appName,
    required int simSlot,
    required SmsResultCallback callback,
  }) async {
    try {
      await _smsActionHandler.handleSendSmsAction(
        simSlot: simSlot,
        appName: appName,
        shortCode: shortCode,
        callBack: callback,
      );
    } catch (e) {
      FormatException('Failed to send SMS: $e');
    }
  }
}

/// A factory for creating instances of [FlutterBackgroundSms] with dependencies.
class FlutterBackgroundSmsFactory {
  /// Creates an instance of [FlutterBackgroundSms] with default dependencies.
  static FlutterBackgroundSms create() {
    final permissionService = PermissionService();
    final smsService = SmsService();
    final smsActionHandler = SmsActionHandler(
      permissionService: permissionService,
      smsService: smsService,
    );

    /// Get the singleton instance of FlutterBackgroundSms.
    final FlutterBackgroundSms flutterPluginTest = FlutterBackgroundSms.instance;
    flutterPluginTest.initialize(smsActionHandler);
    return flutterPluginTest;
  }
}
