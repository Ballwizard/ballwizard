// ignore_for_file: prefer_interpolation_to_compose_strings, curly_braces_in_flow_control_structures

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'globals.dart';

/// Defines the most rudimentary UI component color variants. The bare minimum of
/// customization that a certain UI component the offer is contained in this enum.
enum FundamentalVariant {
  light,
  dark;

  /// Method that gets the color hex by the variant
  int colorHex() {
    switch (this) {
      case FundamentalVariant.light:
        return ColorPicker.light;
      case FundamentalVariant.dark:
        return ColorPicker.dark;
    }
  }

  /// Method that gets the color hex by the inverse color variant
  int inverseColorHex() {
    switch (this) {
      case FundamentalVariant.light:
        return ColorPicker.dark;
      case FundamentalVariant.dark:
        return ColorPicker.light;
    }
  }

  /// Method that converts a `FundamentalVariant` into a `Color` instance.
  Color color() {
    return Color(colorHex());
  }

  /// Method that inverses a `FundamentalVariant` and converts it into a `Color` instance
  Color inverseColor() {
    return Color(inverseColorHex());
  }
}

/// Defines the basic UI component color variants.
enum BasicVariant {
  primary,
  secondary,
  success,
  warning,
  danger,
  info,
  dark,
  light,
  muted;

  /// Method that gets the color hex by the variant.
  int colorHex() {
    switch (this) {
      case BasicVariant.primary:
        return ColorPicker.primary;
      case BasicVariant.secondary:
        return ColorPicker.secondary;
      case BasicVariant.success:
        return ColorPicker.success;
      case BasicVariant.warning:
        return ColorPicker.warning;
      case BasicVariant.danger:
        return ColorPicker.danger;
      case BasicVariant.info:
        return ColorPicker.info;
      case BasicVariant.dark:
        return ColorPicker.dark;
      case BasicVariant.light:
        return ColorPicker.light;
      case BasicVariant.muted:
        return ColorPicker.muted;
    }
  }

  /// Method that converts a `BasicVariant` into a `Color` instance.
  Color color() {
    return Color(colorHex());
  }
}

/// Adds onto the `BasicVariant` enum by adding additional, "muted" color types.
enum Variant {
  primary,
  secondary,
  success,
  warning,
  danger,
  info,
  dark,
  light,
  muted,
  primaryMuted,
  secondaryMuted,
  successMuted,
  warningMuted,
  dangerMuted,
  infoMuted,
  darkMuted,
  lightMuted,
  mutedMuted;

  /// Method that gets the color hex by the variant.
  int colorHex() {
    switch (this) {
      case Variant.primary:
        return ColorPicker.primary;
      case Variant.secondary:
        return ColorPicker.secondary;
      case Variant.success:
        return ColorPicker.success;
      case Variant.warning:
        return ColorPicker.warning;
      case Variant.danger:
        return ColorPicker.danger;
      case Variant.info:
        return ColorPicker.info;
      case Variant.dark:
        return ColorPicker.dark;
      case Variant.light:
        return ColorPicker.light;
      case Variant.muted:
        return ColorPicker.muted;
      case Variant.primaryMuted:
        return ColorPicker.primaryMuted;
      case Variant.secondaryMuted:
        return ColorPicker.secondaryMuted;
      case Variant.successMuted:
        return ColorPicker.successMuted;
      case Variant.warningMuted:
        return ColorPicker.warningMuted;
      case Variant.dangerMuted:
        return ColorPicker.dangerMuted;
      case Variant.infoMuted:
        return ColorPicker.infoMuted;
      case Variant.darkMuted:
        return ColorPicker.darkMuted;
      case Variant.lightMuted:
        return ColorPicker.lightMuted;
      case Variant.mutedMuted:
        return ColorPicker.mutedMuted;
    }
  }

  /// Method that converts a `Variant` into a `Color` instance.
  Color color() {
    return Color(colorHex());
  }
}

/// Defines the available font sizes for the UI components.
enum FontSize { xs, small, sm, medium, large, heading }

/// Abstract class that is used for getting the colors
/// defined in the Ballwizard color palette.
abstract class ColorPicker {
  static const int primary = 0xff16708f;
  static const int secondary = 0xff168f72;
  static const int success = 0xff7dce82;
  static const int warning = 0xffe28413;
  static const int danger = 0xffbf0603;
  static const int info = 0xff2d4251;
  static const int dark = 0xff000000;
  static const int light = 0xffffffff;
  static const int muted = 0xff6b6b6b;

  static const int primaryMuted = 0xff06607f;
  static const int secondaryMuted = 0xff067f62;
  static const int successMuted = 0xff6dbe72;
  static const int warningMuted = 0xffd27403;
  static const int dangerMuted = 0xff950000;
  static const int infoMuted = 0xff1d3241;
  static const int darkMuted = 0xff111111;
  static const int lightMuted = 0xffdddddd;
  static const int mutedMuted = 0xff5b5b5b;

  /// Enables color instantiation using strings and enum types.
  static const Map<dynamic, int> colors = {
    "primary": 0xff16708f,
    "secondary": 0xff168f72,
    "success": 0xff7dce82,
    "warning": 0xffe28413,
    "danger": 0xffbf0603,
    "info": 0xff2d4251,
    "dark": 0xff000000,
    "light": 0xffffffff,
    "muted": 0xff6b6b6b,
    "primaryMuted": 0xff06607f,
    "secondaryMuted": 0xff067f62,
    "successMuted": 0xff6dbe72,
    "warningMuted": 0xffd27403,
    "dangerMuted": 0xff950000,
    "infoMuted": 0xff1d3241,
    "darkMuted": 0xff111111,
    "lightMuted": 0xffeeeeee,
    "mutedMuted": 0xff5b5b5b,
    FundamentalVariant.light: 0xffffffff,
    BasicVariant.light: 0xffffffff,
    Variant.light: 0xffffffff,
    FundamentalVariant.dark: 0xff000000,
    BasicVariant.dark: 0xffffffff,
    Variant.dark: 0xffffffff,
    BasicVariant.primary: 0xff16708f,
    Variant.primary: 0xff16708f,
    BasicVariant.secondary: 0xff168f72,
    Variant.secondary: 0xff168f72,
    BasicVariant.success: 0xff7dce82,
    Variant.success: 0xff7dce82,
    BasicVariant.warning: 0xffe28413,
    Variant.warning: 0xffe28413,
    BasicVariant.danger: 0xffbf0603,
    Variant.danger: 0xffbf0603,
    BasicVariant.info: 0xff2d4251,
    Variant.info: 0xff2d4251,
    BasicVariant.muted: 0xff6b6b6b,
    Variant.muted: 0xff6b6b6b,
    Variant.primaryMuted: 0xff06607f,
    Variant.secondaryMuted: 0xff067f62,
    Variant.successMuted: 0xff6dbe72,
    Variant.warningMuted: 0xffd27403,
    Variant.dangerMuted: 0xff950000,
    Variant.infoMuted: 0xff1d3241,
    Variant.darkMuted: 0xff111111,
    Variant.lightMuted: 0xffeeeeee,
    Variant.mutedMuted: 0xff5b5b5b
  };

  /// Adds opacity to a color in the hex form that can be used by the `Color` class in Flutter.
  static int addOpacity(final int color, final double opacity) {
    if (opacity > 1 || opacity < 0)
      throw Exception("Opacity must be between 0 and 1");

    String opacityHex = (double.parse(opacity.toStringAsFixed(2)) * 0xFF)
        .round()
        .toRadixString(16); // formula to create the hex format of the color

    String colorHex = color.toRadixString(16).substring(2);

    return int.parse("0x" + opacityHex + colorHex);
  }

  /// Creates a `Color` class with opacity using a int in the hex form and a provided opacity.
  static Color colorOpacity(final int color, final double opacity) {
    return Color(addOpacity(color, opacity));
  }
}

/// Abstract class that adds onto the `ColorPicker` class by enabling
/// automatic conversion to a `Color` instead of having to instantiate
/// a `Color` instance manually.
abstract class ColorPalette {
  static const Color primary = Color(ColorPicker.primary);
  static const Color secondary = Color(ColorPicker.secondary);
  static const Color success = Color(ColorPicker.success);
  static const Color warning = Color(ColorPicker.warning);
  static const Color danger = Color(ColorPicker.danger);
  static const Color info = Color(ColorPicker.info);
  static const Color dark = Color(ColorPicker.dark);
  static const Color light = Color(ColorPicker.light);
  static const Color muted = Color(ColorPicker.muted);

  static const Color primaryMuted = Color(ColorPicker.primaryMuted);
  static const Color secondaryMuted = Color(ColorPicker.secondaryMuted);
  static const Color successMuted = Color(ColorPicker.successMuted);
  static const Color warningMuted = Color(ColorPicker.warningMuted);
  static const Color dangerMuted = Color(ColorPicker.dangerMuted);
  static const Color infoMuted = Color(ColorPicker.infoMuted);
  static const Color darkMuted = Color(ColorPicker.darkMuted);
  static const Color lightMuted = Color(ColorPicker.lightMuted);
  static const Color mutedMuted = Color(ColorPicker.mutedMuted);
}

//enum LoginReturnCode {
//
//}

/// Defines the toast variants that can be used with the `Toast` UI component.
enum ToastVariant {
  success,
  error,
  warning,
  info;

  /// Method that gets the color by the variant.
  Color color() {
    switch (this) {
      case ToastVariant.success:
        return ColorPalette.success;
      case ToastVariant.error:
        return ColorPalette.danger;
      case ToastVariant.warning:
        return ColorPalette.warning;
      case ToastVariant.info:
        return ColorPalette.info;
      default:
        return ColorPalette.light;
    }
  }

  IconData icon() {
    switch (this) {
      case ToastVariant.success:
        return Icons.check_rounded;
      case ToastVariant.error:
        return Icons.close_rounded;
      case ToastVariant.warning:
        return Icons.warning_amber_rounded;
      case ToastVariant.info:
        return Icons.info_outline_rounded;
      default:
        return Icons.question_mark;
    }
  }
}

class Toast {
  ToastVariant variant;
  String value;

  Toast({required this.variant, required this.value});
}

/// Defines the states that the `CustomAppBar` component can be in.
/// * [arrow] is used when only the arrow should be visible in the app bar.
/// * [logoPicture] is used when the logo and the user's profile picture should be visible
/// * [arrowLogo] is used when the arrow should be visible with the logo in the center.
/// * [arrowLogoPicture] is used when the arrow, logo and profile picture should all be visible in the app bar.
/// * [search] displays an app bar with a search bar and the user's profile picture.
enum AppBarVariant { arrow, logoPicture, arrowLogo, arrowLogoPicture, search }

/// Defines the possible registration states of the user.
/// Every single user in the Cloud Firestore database will have one of these registration states.
/// They are sent out as soon as the user registers their account.
/// * [complete] means that the user has done every step of the registration, including the actual registration,
/// the user info part (date of registration, name), and the display name has been added as well as their actual name.
/// * [completeWithoutIntroduction] means that the user has registered the account, but has not done the user info part
/// nor, however their display name has been updated.
/// * [incomplete] means that that the user has just registered the account and has not done any further step of
/// the registration process.
enum RegistrationState {
  complete,
  completeWithoutIntroduction,
  incomplete;

  /// Method that returns the code of the registration state in a `String`.
  String code() {
    switch (this) {
      case RegistrationState.complete:
        return "complete";
      case RegistrationState.completeWithoutIntroduction:
        return "completeWithoutIntroduction";
      case RegistrationState.incomplete:
        return "incomplete";
    }
  }
}

class LectureObject {
  final String? title;
  final String? content;
  final String id;
  final String? thumbnail;
  final File? thumbnailFile;
  final int? difficulty;
  final DateTime? dateOfCreation;
  final int? views;
  final String? author;

  LectureObject(
      {this.title,
      this.content,
      required this.id,
      this.thumbnail,
      this.thumbnailFile,
      this.difficulty,
      this.dateOfCreation,
      this.views,
      this.author});

  static fromJson(Map<String, dynamic> json) async {
    //final views = await getLectureViews(json["lecture_id"]);

    return LectureObject(
        id: json["lecture_id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        dateOfCreation: DateTime.parse(json["date_of_creation"]),
        difficulty: json["difficulty"],
        content: json["content"],
        //views: views,
        author: json["author"]);
  }

  static fromId(String id) async {
    Map<String, dynamic> json =
        jsonDecode(await getJsonFile()) as Map<String, dynamic>;
    final item = json["id"][id];
    final views = await getLectureViews(id);

    return LectureObject(
        id: id,
        title: item["title"],
        content: item["content"],
        thumbnail: item["thumbnail"],
        dateOfCreation: DateTime.parse(item["date_of_creation"]),
        difficulty: item["difficulty"],
        views: views,
        author: item["author"]);
  }
}
