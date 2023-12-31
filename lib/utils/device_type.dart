import 'package:flutter/widgets.dart';

enum DeviceType { phone, tablet }

DeviceType getDeviceType() {
  final data = MediaQueryData.fromView(WidgetsBinding.instance.window);
  return data.size.shortestSide < 550 ? DeviceType.phone : DeviceType.tablet;
}
