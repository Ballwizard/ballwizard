import 'package:ballwizard/types.dart'
    show FundamentalVariant, ColorPalette, ColorPicker;
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/widgets.dart';

abstract class Fonts {
  static final TextStyle xs = Font.regular(10);
  static final TextStyle small = Font.regular(14);
  static final TextStyle sm = Font.regular(16);
  static final TextStyle medium = Font.regular(20);
  static final TextStyle large = Font.regular(26);
  static final TextStyle heading = Font.bold(32);

  static final TextStyle xsLight = Font.light(10);
  static final TextStyle smallLight = Font.light(14);
  static final TextStyle smLight = Font.light(16);
  static final TextStyle mediumLight = Font.light(20);
  static final TextStyle largeLight = Font.light(32);
  static final TextStyle headingLight = Font.light(48);
}

class Shadow extends StatelessWidget {
  final dynamic child;
  final FundamentalVariant variant;
  final double blurRadius;
  final double borderRadius;
  final Offset offset;
  final double opacity;
  final double spread;

  const Shadow({
    super.key,
    this.child,
    this.variant = FundamentalVariant.dark,
    this.blurRadius = 4,
    this.borderRadius = 0,
    this.offset = const Offset(0, 4),
    this.opacity = 0.25,
    this.spread = 1,
  });

  @override
  Widget build(BuildContext context) {
    return DropShadow(
        child: child,
        color: variant.color(),
        blurRadius: blurRadius,
        borderRadius: borderRadius,
        offset: offset,
        opacity: opacity,
        spread: spread);
  }
}

abstract class Font {
  static TextStyle regular(double fontSize) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w600,
        fontSize: fontSize);
  }

  static TextStyle light(double fontSize) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w400,
        fontSize: fontSize);
  }

  static TextStyle bold(double fontSize) {
    return TextStyle(
        fontFamily: "Montserrat",
        fontWeight: FontWeight.w700,
        fontSize: fontSize);
  }
}

class GradientBackground extends StatelessWidget {
  final dynamic child;
  final FundamentalVariant variant;

  const GradientBackground({
    super.key,
    this.child,
    this.variant = FundamentalVariant.light,
  });

  @override
  Widget build(BuildContext context) {
    if (variant == FundamentalVariant.light) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ColorPalette.primary, ColorPalette.secondary],
          ),
        ),
        child: child,
      );
    }

    return Container(
      color: ColorPalette.dark,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(ColorPicker.addOpacity(ColorPicker.primary, 0.6)),
              Color(ColorPicker.addOpacity(ColorPicker.secondary, 0.6))
            ],
          ),
        ),
        child: child,
      ),
    );
  }
}
