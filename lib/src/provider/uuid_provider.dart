import 'package:uuid/uuid.dart';

/// A provider class for generating UUIDs (Universally Unique Identifiers).
///
/// This class encapsulates the functionality to generate random UUIDs,
/// adhering to the Single Responsibility Principle (SRP) by focusing solely
/// on UUID generation.
class UUIDProvider {
  /// Generates a random UUID used to sign requests.
  ///
  /// This method utilizes the `Uuid` library to create a version 4 UUID,
  /// which is randomly generated and is suitable for identifying
  /// resources uniquely across distributed systems.
  ///
  /// Returns:
  /// A [String] representing the generated UUID.
  static String generateRandomUUID() {
    return const Uuid().v4(); // Return a randomly generated UUID
  }
}
