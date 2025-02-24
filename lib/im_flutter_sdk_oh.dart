import 'package:flutter/services.dart';

class ImFlutterSdkOh {
  static const MethodChannel _channel = MethodChannel('im_flutter_sdk_oh');
  static const MethodChannel _messageChannel =
      MethodChannel('im_flutter_sdk_oh_message');

  ImFlutterSdkOh() {
    _messageChannel.setMethodCallHandler((call) async {
      print('ImFlutterSdkOh: ${call.method}');
    });
  }

  Future<String?> getPlatformVersion() async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  void startCallBack() {
    _messageChannel.setMethodCallHandler((call) async {
      print('ImFluttssserSdkOh: ${call.method}');
    });
    _channel.invokeMethod('startCallBack');
  }
}
