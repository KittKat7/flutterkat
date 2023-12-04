import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// MaterialColor defColor = Colors.amber;
MaterialColor defColor = Colors.blue;
List<MaterialColor> themeColorList = 
 [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.purple, Colors.cyan];

MaterialColor themeColor = Colors.red;

ThemeData getLightTheme(context) {
  return Provider.of<ColorTheme>(context).lightTheme;
}

ThemeData getDarkTheme(context) {
  return Provider.of<ColorTheme>(context).darkTheme;
}

ThemeData getTheme(context) {
  return Provider.of<ColorTheme>(context).theme;
}

ThemeMode getThemeMode(context) {
  return Provider.of<AppThemeMode>(context).mode;
}

AppThemeMode getAppThemeMode(context) {
  return Provider.of<AppThemeMode>(context, listen: false);
}

class AppThemeMode with ChangeNotifier {
  ThemeMode mode = ThemeMode.system;
  
  setLightMode() { mode = ThemeMode.light; return notifyListeners(); }
  setDarkMode() { mode = ThemeMode.dark; return notifyListeners(); }
  setAutoMode() { mode = ThemeMode.system; return notifyListeners(); }
}

class ColorTheme with ChangeNotifier{

	ThemeData lightTheme = ThemeData(
		primarySwatch: themeColor,
		brightness: Brightness.light,
	);

	ThemeData darkTheme = ThemeData(
		primarySwatch: themeColor,
		brightness: Brightness.dark,
	);

  ThemeData theme = ThemeData(

  );

	setColor(MaterialColor? clr)
	{
		themeColor = clr??=themeColor;
		// currentTheme = ThemeData(
		// 	primarySwatch: themeColor,
		// 	brightness: mode,
		// );
		lightTheme = ThemeData(
			primarySwatch: themeColor,
			brightness: Brightness.light,
		);
		darkTheme = ThemeData(
			primarySwatch: themeColor,
			brightness: Brightness.dark,
		);
		return notifyListeners();
	} // end setColor

	setColorCyan()
	{
		themeColor = Colors.cyan;
		lightTheme = ThemeData(
			primarySwatch: themeColor,
			brightness: Brightness.light,
		);
		darkTheme = ThemeData(
			primarySwatch: themeColor,
			brightness: Brightness.dark,
		);
		return notifyListeners();
	} // end setColor

	cycleColor()
	{
		if (!themeColorList.contains(themeColor)) {
			setColor(themeColorList[0]);
		} else {
			int index = themeColorList.indexOf(themeColor) + 1;
			setColor(themeColorList[index >= (themeColorList.length - 1) ? 0 : index]);
		}
	} // end cycleColor
	
}

ColorTheme getColorTheme(BuildContext context) {
	return Provider.of<ColorTheme>(context, listen: false);
}

ColorScheme colorScheme(BuildContext context) {
  return Theme.of(context).colorScheme;
}