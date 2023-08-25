import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// custom
import 'flutterkat_settings.dart';
import 'flutterkat_theme.dart';
import 'flutterkat_lang.dart';

Future<void> flutterkatInit(List<String> modules) async {
	await flutterkatInitSettings();
}

void flktRunApp(Widget child) {
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
	return routes;
}

void flktSave(String key, String value) {
	flktSavePreference(key, value);
}

String? flktLoad(String key) {
	return flktGetPreference(key);
}
