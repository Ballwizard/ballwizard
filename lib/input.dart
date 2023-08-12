import 'package:ballwizard/globals.dart' as Globals;
import 'package:ballwizard/types.dart'
    show BasicVariant, FundamentalVariant, ColorPalette;
import 'package:flutter/material.dart';

class Form extends StatefulWidget {
  final FundamentalVariant variant;
  final BasicVariant labelVariant;
  final String placeholder;
  final String label;

  //inputStyle?: StyleProp<ViewStyle>;

  //labelStyle?: StyleProp<ViewStyle>;
  //onChange?: (value: string) => void;
  //type?: "password" | "none" | "emailAddress" | "username" | "newPassword";

  //const MyCustomForm({Key? key}) : super(key: key);
  const Form({
    super.key,
    this.variant = FundamentalVariant.light,
    this.labelVariant = BasicVariant.light,
    this.placeholder = "",
    this.label = "",
  });

  @override
  State<Form> createState() => FormState();
}

class FormState extends State<Form> {
  /*
  double _size = 1.0;

  void grow() {
    setState(() { _size += 0.1; });
  }
  */
  @override
  Widget build(BuildContext context) {
    final bool useLightFont = widget.variant == FundamentalVariant.dark;
    final bool useLightLabelFont =
        widget.labelVariant == FundamentalVariant.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.label,
                  style: TextStyle(
                      color: useLightLabelFont
                          ? ColorPalette.light
                          : ColorPalette.dark)),
            ],
          ),
        ),
        SizedBox(
          height: 40,
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
                  borderSide: BorderSide(width: 3, color: ColorPalette.dark)),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide:
                    const BorderSide(color: ColorPalette.muted, width: 1),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide:
                    const BorderSide(color: ColorPalette.dark, width: 1),
              ),
              hintText: widget.placeholder,
              hintStyle: TextStyle(
                  color: useLightFont ? ColorPalette.light : ColorPalette.dark),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
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