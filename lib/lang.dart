Map<String, String> languageStrings = {};

void setLang(Map<String, String> language) {
	languageStrings = language;
}

String getLanguageString(String key, [List params = const []]) {
	String str = languageStrings[key]!;
	for (int i = 0; i < params.length; i++) {
		str = str.replaceAll('\${$i}', params[i].toString());
	}
	// for (String key in params.keys) {
	// 	str.replaceAll('\${key}', params[key]);
	// }
  str = str.replaceAll(RegExp('\\\$\\{\\d+\\}'), '');
	return str;
}

bool contains(String key) {
	return languageStrings.containsKey(key);
}