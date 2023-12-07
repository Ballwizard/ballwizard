import 'package:ballwizard/globals.dart' as Globals;
import 'package:ballwizard/types.dart'
    show BasicVariant, FundamentalVariant, ColorPalette, ColorPicker;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatefulWidget {
  final FundamentalVariant variant;
  final FundamentalVariant labelVariant;
  final String placeholder;
  final String label;
  final int limit;
  final TextInputType type;
  late final dynamic onChange;
  late final dynamic validator;

  Input({
    super.key,
    this.variant = FundamentalVariant.light,
    this.labelVariant = FundamentalVariant.light,
    this.placeholder = "",
    this.label = "",
    this.limit = 128,
    this.type = TextInputType.text,
    this.onChange,
    this.validator,
  });

  @override
  State<Input> createState() => InputState();
}

class InputState extends State<Input> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool useLightFont = widget.variant == FundamentalVariant.dark;
    final bool useLightLabelFont =
        widget.labelVariant == FundamentalVariant.dark;

    /*
    dynamic onChange;
    if (widget.onChange) {
      onChange = widget.onChange;
    } else {
      onChange = (dynamic text) {};
    }
    */

    dynamic onChange = widget.onChange ?? (dynamic text) {};

    return Stack(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: FractionallySizedBox(
            widthFactor: 1.04,
            child: Globals.ShadowElement(
              blurRadius: 4,
              child: SizedBox(
                height: 45,
                child: TextField(
                  keyboardType: widget.type != null ? widget.type : null,
                  controller: controller,
                  onChanged: onChange,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(widget.limit + 1)
                  ],
                  style: TextStyle(
                          color: useLightFont
                              ? ColorPalette.light
                              : ColorPalette.dark)
                      .merge(Globals.Fonts.small),
                  decoration: InputDecoration(
                    fillColor:
                        useLightFont ? ColorPalette.dark : ColorPalette.light,
                    filled: true,
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide:
                            BorderSide(width: 0, color: ColorPalette.dark)),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide:
                          BorderSide(color: ColorPalette.dark, width: 0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          color: useLightFont
                              ? ColorPalette.light
                              : ColorPalette.dark,
                          width: 0),
                    ),
                    hintText: widget.placeholder,
                    hintStyle: TextStyle(
                        color: useLightFont
                            ? ColorPalette.light
                            : ColorPalette.dark),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                    errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide:
                            BorderSide(width: 2, color: ColorPalette.danger)),
                    focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide:
                            BorderSide(width: 3, color: ColorPalette.danger)),
                    errorText: widget.validator != null &&
                            !widget.validator(controller.text)
                        ? ""
                        : null,
                    errorStyle:
                        TextStyle(fontSize: 0, fontStyle: null, height: 0),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.label,
                    style: TextStyle(
                        color: useLightLabelFont
                            ? ColorPalette.dark
                            : ColorPalette.light,
                        shadows: [
                          Shadow(
                              color: ColorPicker.colorOpacity(
                                  ColorPicker.dark, 0.25),
                              offset: Offset(0, 2),
                              blurRadius: 4)
                        ]).merge(Globals.Fonts.small)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
/*
class Bird extends StatefulWidget {
  const Bird({
    super.key,
    this.color = const Color(0xFFFFE306),
    this.child,
  });

  final Color color;
  final Widget? child;

  @override
  State<Bird> createState() => _BirdState();
}

class _BirdState extends State<Bird> {
  double _size = 1.0;

  void grow() {
    setState(() { _size += 0.1; });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      transform: Matrix4.diagonal3Values(_size, _size, 1.0),
      child: widget.child,
    );
  }
}*/
/*
Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          transform: Matrix4.translationValues(0, 8, 0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.label,
                    style: TextStyle(
                        color: useLightLabelFont
                            ? ColorPalette.dark
                            : ColorPalette.light,
                        shadows: [Shadow(color: Color(ColorPicker.addOpacity(ColorPicker.dark, 0.25)), offset: Offset(0, 2), blurRadius: 4)]
                    ).merge(Globals.Fonts.small)
                ),
              ],
            ),
          ),
        ),
        FractionallySizedBox(
          widthFactor: 1.05,
          child: Globals.Shadow(
            blurRadius: 4,
            child: TextField(
              style: TextStyle(
                      color:
                          useLightFont ? ColorPalette.light : ColorPalette.dark)
                  .merge(Globals.Fonts.small),
              decoration: InputDecoration(
                fillColor: useLightFont ? ColorPalette.dark : ColorPalette.light,
                filled: true,
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(width: 0, color: ColorPalette.dark)),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide:
                      BorderSide(color: ColorPalette.dark, width: 0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide:
                      BorderSide(color: useLightFont ? ColorPalette.light : ColorPalette.dark, width: 0),
                ),
                hintText: widget.placeholder,
                hintStyle: TextStyle(
                    color: useLightFont ? ColorPalette.light : ColorPalette.dark),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              ),
            ),
          ),
        ),
      ],
    );
 */
