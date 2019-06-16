import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_aliyunoss/flutter_aliyunoss.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_aliyunoss');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await MKAliyunOSS.platformVersion, '42');
  });
}
