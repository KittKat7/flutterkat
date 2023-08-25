import 'package:flutter/material.dart';
// custom
import 'flutterkat_graphics.dart';

class GoBackButton extends StatelessWidget
{
	// FIELDS
	final BuildContext context;
	final Function? exec;
	const GoBackButton({super.key, required this.context, this.exec});
	
	@override
	Widget build(BuildContext context)
	{
		return StyledOutlinedButton(
			onPressed: () {
				Navigator.pop(context);
				exec == null ? exec : null;
			},
			child: const Text('Go Back'),
		);
	} // end build
} // end GoBackButton

class PaddedScroll extends StatelessWidget
{
	// FIELDS
	final Widget child;
	final Alignment alignment;
	
	const PaddedScroll({super.key, this.alignment = Alignment.center, required this.child});

	@override
	Widget build(BuildContext context)
	{
		final screenSize = getScreenSize(context);
		var edgeInsets = EdgeInsets.symmetric(
			horizontal: screenSize.width * paddingW,
			vertical: screenSize.height * paddingH,
		);
		var padding = Padding(
			padding: edgeInsets,
			child: child,
		);
		return Align(
			alignment: alignment,
			child: SingleChildScrollView(
				child: padding
			),
		);
	} // end buidl
} // end PaddedScroll


class StyledOutlinedButton extends StatelessWidget {
	final Widget child;
	final VoidCallback onPressed;
	final bool isFilled;

	const StyledOutlinedButton({super.key, required this.child, required this.onPressed, this.isFilled = false});

	@override
	Widget build(BuildContext context) {
		Color outline = isFilled? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.primary;
		Color fill = isFilled? Theme.of(context).colorScheme.primary.withOpacity(0.6) : Theme.of(context).canvasColor;

		Widget content = Container(
			decoration: BoxDecoration(
				border: Border.all(color: outline, width: 4),
				borderRadius: BorderRadius.circular(10),
				color: fill,
				// boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.primary, blurRadius: 2, spreadRadius: 5)]
			),
			margin: const EdgeInsets.only(top: 2, bottom: 2),
			child: Container(
				margin: const EdgeInsets.only(top: 4, bottom: 4),
				alignment: Alignment.center,
				child: child,
			),
		);

		Widget button = GestureDetector(
			onTap: onPressed,
			child: content
		);

		return button;
	}
}
