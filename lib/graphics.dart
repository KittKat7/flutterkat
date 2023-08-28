import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/services.dart' show rootBundle;

/* ========== HELPERS ========== */
// vars
double aspectWidth = 1;
double aspectHeight = 1;

void setAspect(double w, double h) {
	aspectWidth = w;
	aspectHeight = h;
}

const Text spacer = Text("");
double paddingW = 0.1; // the percent of horiontal padding on each side
double paddingH = 0.05; // the amount of verticle padding on each side
double paddedW = 0; // the width of the available screen (excluding padding)
double paddedH = 0; // the height of the available screen (excluding padding)
double scale = 1; // not sure

var rBundle = rootBundle;

bool isDark = true;

// Future<void> loadWords() async {
//   String text = await rootBundle.loadString('assets/texts/words.txt');
//   wordList = text.split(" ");
// }

Size getScreenSize(BuildContext context) {
	Size size = MediaQuery.of(context).size;

	double aspectW = 1;
	// double aspectW = 10;
	double aspectH = 1;
	// double aspectH = 16;

	double scaleW = size.width / aspectW;
	double scaleH = size.height / aspectH;

	// ignore: unused_local_variable
	double drawW = scaleW / aspectW;
	// ignore: unused_local_variable
	double drawH = scaleH / aspectH;

	double scale = scaleH * aspectW;
	paddingW = (size.width - scale) / (size.width) / 2;
	if (paddingW < 0.1) {
		paddingW = 0.01;
	}
	// paddingW = 0.01;
	return size;
}

double getPaddingW()
{
	return paddedW;
}

double getPaddingH()
{
	return paddedH;
}

void enterTxtPopup(BuildContext context, String title, Function(String) onConfirm, {String hint = "", String def = ""}) {
	final TextEditingController controller = TextEditingController(text: def);

	showDialog(
		context: context,
		builder: (BuildContext context) {
			return AlertDialog(
				title: Text(title),
				content: TextField(
					decoration: InputDecoration(
						hintText: hint
					),
					controller: controller,
					onChanged: (value) {
						// Handle text change
					},
					keyboardType: TextInputType.multiline,
					maxLines: null,
				),
				actions: <Widget>[
					TextButton(
						child: const Text('Cancel'),
						onPressed: () {
							// Handle cancel
							Navigator.of(context).pop();
						},
					),
					TextButton(
						child: const Text('Confirm'),
						onPressed: () {
							// Handle confirm
							String text = controller.text;
							Navigator.of(context).pop();
							onConfirm(text);
						},
					),
				],
			);
		},
	);
}

void dateSelect(BuildContext context, Function(DateTime?) onConfirm) {
	// final controller = TextEditingController();
	DateTime? date;

	showDatePicker(
		context: context, 
		initialDate: DateTime.now(), 
		firstDate: DateTime.now().subtract(const Duration(days: 365 * 1000)),
		lastDate: DateTime.now().add(const Duration(days: 365 * 1000)),
	).then((value) {
		if (value == null) return;
		date = value;
		showTimePicker(
			context: context, 
			initialTime: TimeOfDay.now()
		).then((value) {
			if (value == null) return;
			date = DateTime(date!.year, date!.month, date!.day, value.hour, value.minute);
			onConfirm(date);
		});
	});
}


void confirmPopup(BuildContext context, String title, String question, Function() onConfirm) {

	showDialog(
		context: context,
		builder: (BuildContext context) {
			return AlertDialog(
				title:  Text(title),
				content: MarkdownBody(data: question),
				actions: <Widget>[
					TextButton(
						child: const Text('Cancel'),
						onPressed: () {
							// Handle cancel
							Navigator.of(context).pop();
						},
					),
					TextButton(
						child: const Text('Confirm'),
						onPressed: () {
							// Handle confirm
							onConfirm();
							Navigator.of(context).pop();
						},
					),
				],
			);
		},
	);
}

Row flexible(List<Widget> children) {
	return Row(
		children: [
			for (Widget w in children) Flexible(flex: 1, child: w)
		]
	);
}

Row expand(Widget child) {
	return Row(
		children: [
			Expanded(flex: 1, child: child)
		]
	);
}


/// Shows the Widget menu
/// 
/// Causes a popup menu with a cancel button.
/// The options in the menu are the widgets in [items]
void showWidgetMenu(BuildContext context, String title, List<Widget> items) {
	Column buttons = Column(
		mainAxisSize: MainAxisSize.min,
		children: items,
	);
	
	showDialog(
		context: context,
		builder: (BuildContext context) {
			return AlertDialog(
				title: Text(title),
				content: buttons,
				actions: <Widget>[
					TextButton(
						child: const Text('Cancel'),
						onPressed: () {
							// Handle cancel
							Navigator.of(context).pop();
						},
					),
				],
			);
		},
	);
} // end showItemMenu
