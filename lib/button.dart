import 'package:ballwizard/types.dart'
    show BasicVariant, FundamentalVariant, ColorPalette, ColorPicker;
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final FundamentalVariant variant;
  final String title;
  final VoidCallback onClick;

  const Button({
    super.key,
    this.variant = FundamentalVariant.light,
    this.title = "",
    required this.onClick,
  });

  @override
  State<Button> createState() => ButtonState();
}

class ButtonState extends State<Button> {
  /*
  double _size = 1.0;

  void grow() {
    setState(() { _size += 0.1; });
  }
  */
  @override
  Widget build(BuildContext context) {
    final bool useLightFont = widget.variant == FundamentalVariant.dark;

    return SizedBox(
        height: 44,
        child: FractionallySizedBox(
          widthFactor: 1,
          heightFactor: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Material(
                color: widget.variant.color(),
                child: InkWell(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(widget.title,
                          style: TextStyle(
                              color: useLightFont
                                  ? ColorPalette.light
                                  : ColorPalette.dark)),
                    ))),
          ),
        ));
  }
}
