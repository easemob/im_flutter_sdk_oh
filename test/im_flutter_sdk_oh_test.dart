import 'package:flutter_test/flutter_test.dart';
import 'package:im_flutter_sdk_oh/im_flutter_sdk_oh.dart';
import 'package:im_flutter_sdk_oh/im_flutter_sdk_oh_platform_interface.dart';
import 'package:im_flutter_sdk_oh/im_flutter_sdk_oh_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockImFlutterSdkOhPlatform
    with MockPlatformInterfaceMixin
    implements ImFlutterSdkOhPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ImFlutterSdkOhPlatform initialPlatform = ImFlutterSdkOhPlatform.instance;

  test('$MethodChannelImFlutterSdkOh is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelImFlutterSdkOh>());
  });

  test('getPlatformVersion', () async {
    ImFlutterSdkOh imFlutterSdkOhPlugin = ImFlutterSdkOh();
    MockImFlutterSdkOhPlatform fakePlatform = MockImFlutterSdkOhPlatform();
    ImFlutterSdkOhPlatform.instance = fakePlatform;

    expect(await imFlutterSdkOhPlugin.getPlatformVersion(), '42');
  });
}
