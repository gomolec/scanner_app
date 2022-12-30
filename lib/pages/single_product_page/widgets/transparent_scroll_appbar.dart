import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransparentScrollAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  const TransparentScrollAppBar({
    Key? key,
    this.leading,
    this.title,
    this.actions,
    required this.controller,
    required this.backgroundColor,
  }) : super(key: key);

  final Color backgroundColor;
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final ScrollController controller;

  @override
  State<TransparentScrollAppBar> createState() =>
      _TransparentScrollAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TransparentScrollAppBarState extends State<TransparentScrollAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorTween;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _colorTween = ColorTween(
      begin: null,
      end: widget.backgroundColor,
    ).animate(_animationController);
    widget.controller.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (widget.controller.hasClients) {
      setState(() {
        if (widget.controller.position.pixels == 0) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorTween,
      builder: (context, child) => Container(
        color: _colorTween.value,
        child: SafeArea(
          child: SizedBox(
            height: AppBar().preferredSize.height,
            child: Row(
              children: [
                widget.leading ?? const SizedBox(width: 56.0),
                Expanded(child: widget.title ?? const SizedBox()),
                Row(
                  children: widget.actions ?? [],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_scrollListener);
    _animationController.dispose();
    super.dispose();
  }
}
