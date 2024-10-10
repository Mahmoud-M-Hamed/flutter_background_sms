import 'package:flutter/material.dart';
import 'package:flutter_background_sms/flutter_background_sms.dart';

void main() {
  runApp(const MyApp());
}

/// The main application widget.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown'; // Initialize platform version
  final FlutterBackgroundSms _flutterSmsPlugin = FlutterBackgroundSmsFactory.create(); // Create instance of FlutterPluginTest

  @override
  void initState() {
    super.initState();
    _initializePermissions(); // Initialize permissions on app start
  }

  /// Initializes permissions for sending SMS.
  Future<void> _initializePermissions() async {
    await _flutterSmsPlugin.initializePermissions();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin Example App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Running on: $_platformVersion\n'), // Display platform version
              ElevatedButton(
                onPressed: _sendSms, // Call the send SMS method when pressed
                child: const Text('Send SMS'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Sends SMS using the Flutter plugin.
  Future<void> _sendSms() async {
    await _flutterSmsPlugin.sendSms(
      shortCode: '01225554005', // Recipient's shortcode
      appName: 'stand', // Application name
      simSlot: 0, // SIM slot to use
      callback: (Map<String, String> result) {
        print('Result: $result'); // Handle result of the SMS sending action
      },
    );
  }
}
