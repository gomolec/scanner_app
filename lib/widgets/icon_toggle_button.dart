import 'package:flutter/material.dart';

class IconToggleButton extends StatefulWidget {
  const IconToggleButton({
    this.getDefaultStyle,
    this.onPressed,
    required this.icon,
    this.selectedIcon,
    this.color,
    this.selectedColor,
    this.isSelected = false,
    super.key,
  });

  final void Function()? onPressed;
  final Icon icon;
  final Icon? selectedIcon;
  final Color? color;
  final Color? selectedColor;
  final bool isSelected;
  final ButtonStyle? Function(bool, ColorScheme)? getDefaultStyle;

  @override
  State<IconToggleButton> createState() => _IconToggleButtonState();
}

class _IconToggleButtonState extends State<IconToggleButton> {
  late bool selected;

  @override
  void initState() {
    selected = widget.isSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final VoidCallback? onPressed = widget.onPressed != null
        ? () {
            setState(() {
              selected = !selected;
            });
            widget.onPressed!();
          }
        : null;
    ButtonStyle? style;
    if (widget.getDefaultStyle != null) {
      style = widget.getDefaultStyle!(selected, colors);
    }

    return IconButton(
      color: selected ? widget.selectedColor : widget.color,
      isSelected: selected,
      icon: widget.icon,
      selectedIcon: widget.selectedIcon,
      onPressed: onPressed,
      style: style,
    );
  }
}
