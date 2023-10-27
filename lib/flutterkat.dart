import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// custom
import 'package:flutterkat/settings.dart';
import 'package:flutterkat/theme.dart';
import 'package:flutterkat/lang.dart';

var _pageRoutes;
bool flutterkatInitialized = false;

Future<void> flutterkatInit() async {
	await flutterkatInitSettings();
  flutterkatInitialized = true;
}

void flktRunApp(Widget child) async {
  if (!flutterkatInitialized) {
    await flutterkatInit();
    print("Flutterkat should be initialized BEFORE running the app");
  }
	
	runApp(ChangeNotifierProvider<ColorTheme>(
			create: (context) => ColorTheme(),
			child: child,
		)
	);
}

String getString(String key, [List params = const []]) {
	return getLanguageString(key, params);
}

Map<String, Widget Function(BuildContext)> genRoutes(Map<String, List> pageRoutes) {
	Map<String, Widget Function(BuildContext)> routes = {};
	for (String name in pageRoutes.keys) {
		routes[pageRoutes[name]![0]] = (context) => pageRoutes[name]![1];
	}
	_pageRoutes = pageRoutes;
	return routes;
}

String getRoute(String key) {
	return _pageRoutes[key][0];
}

void flktSave(String key, String value) {
	flktSavePreference(key, value);
}

String? flktLoad(String key) {
	return flktGetPreference(key);
}
