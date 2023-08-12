import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/widgets.dart';
import 'package:ballwizard/types.dart' show ColorPicker, FundamentalVariant;

abstract class Fonts {
  static final TextStyle xs = Font.regular(14);
  static final TextStyle small = Font.regular(18);
  static final TextStyle sm = Font.regular(22);
  static final TextStyle medium = Font.regular(28);
  static final TextStyle large = Font.regular(36);
  static final TextStyle heading = Font.bold(48);

  static final TextStyle xsLight = Font.light(14);
  static final TextStyle smallLight = Font.light(18);
  static final TextStyle smLight = Font.light(22);
  static final TextStyle mediumLight = Font.light(28);
  static final TextStyle largeLight = Font.light(36);
  static final TextStyle headingLight = Font.light(48);
}

class Shadow extends StatelessWidget {
  dynamic children;
  FundamentalVariant variant;
  double blurRadius;
  double borderRadius;
  Offset offset;
  double opacity;
  double spread;

  Shadow(
    this.children,
    {
      super.key,
      this.variant = FundamentalVariant.dark,
      this.blurRadius = 4,
      this.borderRadius = 0,
      this.offset = const Offset(0, 4),
      this.opacity = 0.25,
      this.spread = 1,
    }
  );

  @override
  Widget build(BuildContext context) {
    return DropShadow(
        child: children,
        color: Color(variant.color()),
        blurRadius: blurRadius,
        borderRadius: borderRadius,
        offset: offset,
        opacity: opacity,
        spread: spread
    );
  }
}

abstract class Font {
  static TextStyle regular(double fontSize) {
    return TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.w600, fontSize: fontSize);
  }

  static TextStyle light(double fontSize) {
    return TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.w400, fontSize: fontSize);
  }

  static TextStyle bold(double fontSize) {
    return TextStyle(fontFamily: "Montserrat", fontWeight: FontWeight.w700, fontSize: fontSize);
  }
}
