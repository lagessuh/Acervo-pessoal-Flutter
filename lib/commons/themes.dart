import 'package:flutter/material.dart';

class AppColorsTheme extends ThemeExtension<AppColorsTheme> {
  // reference colors:
  static const _grey = Color(0xFFB0B0B0);
  static const _green = Color(0xFF00C060);
  static const _red = Color(0xFFED4E52);

  // actual colors used throughout the app:
  final Color backgroundDefault;
  final Color backgroundInput;
  final Color snackbarValidation;
  final Color snackbarError;
  final Color textDefault;

  // private constructor (use factories below instead):
  const AppColorsTheme._internal({
    required this.backgroundDefault,
    required this.backgroundInput,
    required this.snackbarValidation,
    required this.snackbarError,
    required this.textDefault,
  });

  // factory for light mode:
  factory AppColorsTheme.light() {
    return const AppColorsTheme._internal(
        backgroundDefault: _grey,
        backgroundInput: _grey,
        snackbarValidation: _green,
        snackbarError: _red,
        textDefault: _grey);
  }

  // factory for dark mode:
  factory AppColorsTheme.dark() {
    return AppColorsTheme._internal(
        backgroundDefault: Colors.black,
        backgroundInput: _grey,
        snackbarError: Colors.blueGrey.shade50,
        snackbarValidation: Colors.blueGrey.shade800,
        textDefault: Colors.white);
  }

  @override
  ThemeExtension<AppColorsTheme> copyWith({bool? lightMode}) {
    if (lightMode == null || lightMode == true) {
      return AppColorsTheme.light();
    }
    return AppColorsTheme.dark();
  }

  @override
  ThemeExtension<AppColorsTheme> lerp(
          covariant ThemeExtension<AppColorsTheme>? other, double t) =>
      this;
}

class AppTextsTheme extends ThemeExtension<AppTextsTheme> {
  static const _baseFamily = "Base";

  final TextStyle labelBigEmphasis;
  final TextStyle labelBigDefault;
  final TextStyle labelDefaultEmphasis;
  final TextStyle labelDefaultDefault;

  const AppTextsTheme._internal({
    required this.labelBigEmphasis,
    required this.labelBigDefault,
    required this.labelDefaultEmphasis,
    required this.labelDefaultDefault,
  });

  factory AppTextsTheme.main() => const AppTextsTheme._internal(
        labelBigEmphasis: TextStyle(
          fontFamily: _baseFamily,
          fontWeight: FontWeight.w400,
          fontSize: 18,
          height: 1.4,
        ),
        labelBigDefault: TextStyle(
          fontFamily: _baseFamily,
          fontWeight: FontWeight.w300,
          fontSize: 18,
          height: 1.4,
        ),
        labelDefaultEmphasis: TextStyle(
          fontFamily: _baseFamily,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 1.4,
        ),
        labelDefaultDefault: TextStyle(
          fontFamily: _baseFamily,
          fontWeight: FontWeight.w300,
          fontSize: 16,
          height: 1.4,
        ),
      );

  @override
  ThemeExtension<AppTextsTheme> copyWith() {
    return AppTextsTheme._internal(
      labelBigEmphasis: labelBigEmphasis,
      labelBigDefault: labelBigDefault,
      labelDefaultEmphasis: labelDefaultEmphasis,
      labelDefaultDefault: labelDefaultDefault,
    );
  }

  @override
  ThemeExtension<AppTextsTheme> lerp(
          covariant ThemeExtension<AppTextsTheme>? other, double t) =>
      this;
}

class AppDimensionsTheme extends ThemeExtension<AppDimensionsTheme> {
  final double radiusHelpIndication;
  final EdgeInsets paddingHelpIndication;

  const AppDimensionsTheme._internal({
    required this.radiusHelpIndication,
    required this.paddingHelpIndication,
  });

  factory AppDimensionsTheme.main() => const AppDimensionsTheme._internal(
        radiusHelpIndication: 8,
        paddingHelpIndication:
            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      );

  @override
  ThemeExtension<AppDimensionsTheme> copyWith() {
    return AppDimensionsTheme._internal(
      radiusHelpIndication: radiusHelpIndication,
      paddingHelpIndication: paddingHelpIndication,
    );
  }

  @override
  ThemeExtension<AppDimensionsTheme> lerp(
          covariant ThemeExtension<AppDimensionsTheme>? other, double t) =>
      this;
}

extension ThemeDataExtended on ThemeData {
  AppDimensionsTheme get appDimensions => extension<AppDimensionsTheme>()!;
  AppColorsTheme get appColors => extension<AppColorsTheme>()!;
  AppTextsTheme get appTexts => extension<AppTextsTheme>()!;
}

class AppColorTheme2 extends ThemeExtension<AppColorTheme2> {
  final Color primaryColor;

  final Color secondaryColor;

  AppColorTheme2({
    this.primaryColor = const Color.fromARGB(255, 3, 58, 26),
    this.secondaryColor = const Color.fromARGB(255, 17, 128, 4),
  });

  @override
  ThemeExtension<AppColorTheme2> copyWith({
    Color? appPrimaryColor,
    Color? appSecondaryColor,
  }) {
    return AppColorTheme2(
      primaryColor: appPrimaryColor ?? primaryColor,
      secondaryColor: appSecondaryColor ?? secondaryColor,
    );
  }

  @override
  ThemeExtension<AppColorTheme2> lerp(
    covariant ThemeExtension<AppColorTheme2>? other,
    double t,
  ) {
    if (other == null) {
      return this;
    }
    return AppColorTheme2();
  }
}
