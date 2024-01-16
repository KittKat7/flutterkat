
import 'package:flutter/foundation.dart';

class GetPlatform {
  static const isWeb = kIsWeb;
  static final isLinux = defaultTargetPlatform == TargetPlatform.linux;
  static final isWindows = defaultTargetPlatform == TargetPlatform.windows;
  static final isMacOs = defaultTargetPlatform == TargetPlatform.macOS;
  static final isAndroid = defaultTargetPlatform == TargetPlatform.android;
  static final isIOS = defaultTargetPlatform == TargetPlatform.iOS;

  static final bool isDesktop = (isLinux || isWindows || isMacOs);
  static final bool isMobile = (isAndroid || isIOS);
}