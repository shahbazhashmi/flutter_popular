import 'package:core/extensions.dart';
import 'package:flutter/material.dart';

class AppSizes {
  static const defaultFontSize = 18.0;
  static const headline1FontSize = 48.0;
}

class AppColors {
  static final black = HexColor.fromHex('#000000');
  static final white = HexColor.fromHex('#FFFFFF');
  static final gray = HexColor.fromHex('#808080');
  static final red = HexColor.fromHex('#FF0000');

  static final cgBlue = HexColor.fromHex('#227C9D');
  static final lightSeaGreen = HexColor.fromHex('#17C3B2');
  static final maximumYellowRed = HexColor.fromHex('#FFCB77');
  static final floralWhite = HexColor.fromHex('#FEF9EF');
  static final lightCoral = HexColor.fromHex('#FE6D73');
}

class AppConstants {
  static const searchMaxLength = '25';
}

class AppTheme {
  static ThemeData of(context) {
    ThemeData theme = Theme.of(context);
    return theme.copyWith(
        primaryColor: AppColors.cgBlue,
        primaryColorLight: AppColors.floralWhite,
        bottomAppBarColor: AppColors.lightSeaGreen,
        errorColor: AppColors.lightCoral,
        appBarTheme: theme.appBarTheme.copyWith(
            color: AppColors.cgBlue,
            textTheme: theme.textTheme.copyWith(caption: TextStyle(color: AppColors.maximumYellowRed, fontSize: AppSizes.defaultFontSize))),
        textTheme:
            theme.textTheme.copyWith(headline1: theme.textTheme.headline1!.copyWith(color: AppColors.maximumYellowRed, fontSize: AppSizes.headline1FontSize)),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.maximumYellowRed));
  }
}
