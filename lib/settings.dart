import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

import 'theme.dart';

const String flutterkatVersion = "0.0.1";

String flutterkatError = "";
bool get hasError {
	return flutterkatError.isNotEmpty;
}

late SharedPreferences prefs;
// settings
Map<String, String> flutterkatInfo = {};
late Map<String, String> flutterkatSettings;
final isWebMobile = kIsWeb && (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android);

Map<String, String> flutterkatSettingsDefault = {
  'themeColor': themeColorMap.keys.first,
  'themeMode': 'auto'
};

Future<void> flutterkatInitSettings() async {
	flutterkatInfo = {};
	// flutterkatInfo['platform'] = getPlatform();
	// flutterkatInfo['platformType'] = getPlatformType();
	flutterkatInfo['version'] = flutterkatVersion;
    print("DEBUG ERR1");

	try {
		prefs = await SharedPreferences.getInstance();
    print("DEBUG ERR2");
		flutterkatSettings = Map<String, String>.from(jsonDecode(prefs.getString('flutterkat')!));
	} catch (e, trace) {
		loadDefaults();
    print("ERROR > occured while initialize shared preferences $e $trace");
	}
}

// Save the value to shared preferences
Future<void> saveSettings() async {
	prefs.setString('flutterkat', jsonEncode(flutterkatSettings));
} // end saveOptions

// Load the value from shared preferences
Future<void> loadSettings() async {
	flutterkatSettings = jsonDecode(prefs.getString('flutterkat')!);
} // end loadOptions

void loadDefaults() {
	flutterkatSettings = flutterkatSettingsDefault;
	saveSettings();
} // end loadDefaults

String getSetting(String key) {
  String ret = "";
  if (flutterkatSettings.containsKey(key)) {
    ret = flutterkatSettings[key]!;
  } else {
    ret = flutterkatSettingsDefault[key]!;
  }
  return ret;
}

void flktSavePreference(String key, String value) {
	prefs.setString(key, value);
}

Future<bool> flktRemovePreference(String key) {
	return prefs.remove(key);
}

String? flktGetPreference(String key) {
	return prefs.getString(key);
}

void flktResetPreference(String key) {
	prefs.remove(key);
}

Future<void> resetOptions() async {
	final prefs = await SharedPreferences.getInstance();
	prefs.clear();
	loadDefaults();
} // end resetOptions



// String getPlatform() {
// 	String platform;
// 	switch(defaultTargetPlatform) {
// 		case TargetPlatform.linux:
// 			platform = "linux";
// 			break;
// 		case TargetPlatform.windows:
// 			platform = "windows";
// 			break;
// 		case TargetPlatform.macOS:
// 			platform = "macos";
// 			break;
// 		case TargetPlatform.android:
// 			platform = "android";
// 			break;
// 		case TargetPlatform.iOS:
// 			platform = "ios";
// 			break;
// 		default:
// 			platform = "unknown";
// 	} // end switch
// 	return platform;
// } // end getPlatform

// String getPlatformType() {
// 	String platformType;
// 	switch(defaultTargetPlatform) {
// 		case TargetPlatform.linux || TargetPlatform.windows || TargetPlatform.macOS:
// 			platformType = "desktop";
// 			break;
// 		case TargetPlatform.android || TargetPlatform.iOS:
// 			platformType = "mobile";
// 			break;
// 		default:
// 			platformType = "unknown";
// 	} // end switch
// 	return platformType;
// } // end getPlatform

