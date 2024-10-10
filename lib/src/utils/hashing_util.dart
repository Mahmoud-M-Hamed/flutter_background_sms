import 'dart:convert';
import 'package:crypto/crypto.dart';

/// A utility class for hashing strings using SHA-256.
///
/// This class provides static methods for hashing messages and keys,
/// ensuring that sensitive information can be securely hashed for storage or verification.
class HashingUtil {
  /// Hashes the provided message using SHA-256 and returns the hash as a string.
  ///
  /// Parameters:
  /// - [message]: The message to be hashed.
  ///
  /// Returns:
  /// A [Future<String>] that resolves to the hashed message in hexadecimal format.
  ///
  /// This method converts the input message to bytes, computes its SHA-256
  /// hash, and returns the result as a string. It is suitable for hashing
  /// sensitive information that needs to be stored securely.
  static Future<String> hashMessage(String message) async {
    var messageBytes = utf8.encode(message); // Convert the message to bytes
    var digest = sha256.convert(messageBytes); // Hash the message using SHA-256
    return digest.toString(); // Return the hashed message as a hex string
  }
}
