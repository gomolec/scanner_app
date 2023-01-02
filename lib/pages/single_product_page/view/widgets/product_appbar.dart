import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product_bloc.dart';

class ProductAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ProductAppBar({
    Key? key,
    required this.controller,
    required this.backgroundColor,
    required this.marked,
  }) : super(key: key);

  final ScrollController controller;
  final Color backgroundColor;
  final bool marked;

  @override
  State<ProductAppBar> createState() => _TransparentScrollAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TransparentScrollAppBarState extends State<ProductAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorTween;

  bool didChanged = false;
  late bool marked;

  @override
  void initState() {
    marked = widget.marked;
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
    return BlocListener<ProductBloc, ProductState>(
      listenWhen: (previous, current) =>
          previous.didChanged != current.didChanged ||
          previous.marked != current.marked,
      listener: (context, state) {
        setState(() {
          didChanged = state.didChanged;
          marked = state.marked;
        });
      },
      child: AnimatedBuilder(
        animation: _colorTween,
        builder: (context, child) => Container(
          color: _colorTween.value,
          child: SafeArea(
            child: SizedBox(
              height: AppBar().preferredSize.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AutoLeadingButton(),
                  didChanged
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              context
                                  .read<ProductBloc>()
                                  .add(const ProductChangesSaved());
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                foregroundColor:
                                    Theme.of(context).colorScheme.onPrimary),
                            child: const Text("Zapisz"),
                          ),
                        )
                      : Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                context
                                    .read<ProductBloc>()
                                    .add(ProductMarkedChanged(!marked));
                              },
                              tooltip: "Oflaguj",
                              icon: marked
                                  ? const Icon(Icons.flag)
                                  : const Icon(Icons.flag_outlined),
                            ),
                            IconButton(
                              onPressed: () {
                                context
                                    .read<ProductBloc>()
                                    .add(const ProductDeleted());
                              },
                              tooltip: "Usuń",
                              icon: const Icon(Icons.delete_outline),
                            ),
                          ],
                        )
                ],
              ),
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
