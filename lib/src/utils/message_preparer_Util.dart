/*
import 'package:flutter_background_sms/src/provider/uuid_provider.dart';
import 'package:flutter_background_sms/src/services/storage_service/secure_storage.dart';
import 'package:flutter_background_sms/src/utils/hashing_util.dart';

/// A class responsible for preparing messages for sending.
class MessagePreparer {
  final SecureStorage _secureStorage;

  MessagePreparer(this._secureStorage);

  /// Prepares a message for sending by generating a random UUID and hashing it.
  Future<String> prepareMessage() async {
    final String randomMessage = UUIDProvider.generateRandomUUID(); // Generate a random UUID
    await _secureStorage.storeKey(value: randomMessage); // Store the UUID securely
    return await HashingUtil.hashMessage(randomMessage); // Return the hashed UUID
  }
}
*/
