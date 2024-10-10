/// A class responsible for building result maps for SMS sending operations.
class SmsResultHandler {
  /// Constructs a success result map.
  ///
  /// Parameters:
  /// - [uuid]: The UUID retrieved from secure storage.
  /// - [status]: The status of the SMS sending attempt.
  ///
  /// Returns:
  /// - A [Map<String, String>] containing the success result.
  Map<String, String> callbackSuccessResult({
    required String? uuid,
    required bool status,
  }) {
    return {
      'id': uuid ?? 'No ID found',
      'status': status ? 'Success' : 'Failed',
    };
  }

  /// Constructs a failure result map.
  ///
  /// Parameters:
  /// - [exception]: The exception thrown during the SMS sending attempt.
  ///
  /// Returns:
  /// - A [Map<String, String>] containing the failure result.
  Map<String, String> callbackFailureResult({
    required Object exception,
  }) {
    return {
      'id': 'No ID found',
      'status': 'Failed: ${exception.toString()}',
    };
  }
}


/// Callback function type for SMS result handling.
///
/// This callback is invoked with a map containing the result of the SMS
/// sending operation, providing information about the success or failure
/// of the SMS send action.
typedef SmsResultCallback = void Function(Map<String, String> result);
