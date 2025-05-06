import 'package:flutter/material.dart';

final Map mapColor = {
  'Initial': Colors.grey,
  'Success' : Colors.green,
  'Error' : const Color(0xFFE53935)
};

class LightColors {
  static const colorLight = Color(0xFFF2F2F2);
  static const primary = Color(0xFF253064); //azul
  static const onPrimary = Color(0xFFFFFFFF); //blanco
  static const primaryVariant = Color(0xFF23456e);
  static const secondary = Color(0xFFF6BE56);
  static const onSecondary = Color(0xFFE2AE4B);
  static const surface = Color(0xFFFFFFFF); //blanco
  static const onSurface = Color(0xFF23456e);//azul
  static const background = Color(0xFFF2F2F2);
  static const onBackground = Color(0xFF253064);
  static const error = Color(0xFFEA747A);
  static const onError = Color(0xFFF2F2F2);
  static const grayColor = Color(0x9ED4D4DF);
}


class DarkColors {
  static const colorDark = Color(0xFF121212);
  static const surface = Color(0xFF1E2230);
  static const background = Color(0xFF13161A);
  static const primary = Color(0xFFF6BE56);
  static const onPrimary = Color(0xFF121212);
  static const secondary = Color(0xFF23456E);
  static const onSecondary = Color(0xFFFFFFFF);
  static const onSurface = Color(0xFFFFFFFF);
  static const onBackground = Color(0xFFFFFFFF);
  static const error = Color(0xFFEA747A);
  static const onError = Color(0xFFFFFFFF);
  static const grayColor = Color(0x9ED4D4DF);
}


const colorSchemeLight = ColorScheme(
  brightness: Brightness.light,
  primary: LightColors.primary,
  onPrimary: LightColors.onPrimary,
  secondary: LightColors.secondary,
  onSecondary: LightColors.onSecondary,
  surface: LightColors.surface,
  onSurface: LightColors.onSurface,
  error: LightColors.error,
  onError: LightColors.onError,
);

const colorSchemeDark = ColorScheme(
  brightness: Brightness.dark,
  primary: DarkColors.primary,
  onPrimary: DarkColors.onPrimary,
  secondary: DarkColors.secondary,
  onSecondary: DarkColors.onSecondary,
  surface: DarkColors.surface,
  onSurface: DarkColors.onSurface,
  error: DarkColors.error,
  onError: DarkColors.onError,
);