import 'package:ballwizard/globals.dart';
import 'package:ballwizard/types.dart' show Variant, ColorPalette;
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final Variant variant;
  final String title;
  final VoidCallback onClick;
  final double? height;

  const Button(
      {super.key,
      this.variant = Variant.light,
      this.title = "",
      required this.onClick,
      this.height});

  @override
  State<Button> createState() => ButtonState();
}

class ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    final bool useLightFont = widget.variant == Variant.dark ||
        widget.variant == Variant.muted ||
        widget.variant == Variant.primary ||
        widget.variant == Variant.secondary ||
        widget.variant == Variant.primaryMuted ||
        widget.variant == Variant.secondaryMuted ||
        widget.variant == Variant.danger ||
        widget.variant == Variant.dangerMuted;

    return SizedBox(
        height: widget.height ?? 44,
        child: FractionallySizedBox(
          widthFactor: 1,
          heightFactor: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Material(
                color: widget.variant.color(),
                child: InkWell(
                    onTap: widget.onClick,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(widget.title,
                          style: Fonts.small.merge(TextStyle(
                              color: useLightFont
                                  ? ColorPalette.light
                                  : ColorPalette.dark))),
                    ))),
          ),
        ));
  }
}
