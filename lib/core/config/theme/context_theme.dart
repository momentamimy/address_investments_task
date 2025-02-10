import 'package:flutter/material.dart';

extension ContextColorScheme on BuildContext {
  Color get primary => Theme.of(this).colorScheme.primary;


  Color get secondary => Theme.of(this).colorScheme.secondary;


  Color get surface => Theme.of(this).colorScheme.surface;


  Color get onPrimary => Theme.of(this).colorScheme.onPrimary;

  Color get onSecondary => Theme.of(this).colorScheme.onSecondary;

  Color get onSurface => Theme.of(this).colorScheme.onSurface;

  Color get error => Theme.of(this).colorScheme.error;

  Color get onError => Theme.of(this).colorScheme.onError;

  Color get hintColor => Theme.of(this).hintColor;
}

extension ContextTextTheme on BuildContext {
  TextStyle? get displayLarge => Theme.of(this).textTheme.displayLarge;

  TextStyle? get displayMedium => Theme.of(this).textTheme.displayMedium;

  TextStyle? get displaySmall => Theme.of(this).textTheme.displaySmall;

  TextStyle? get headlineLarge => Theme.of(this).textTheme.headlineLarge;

  TextStyle? get headlineMedium => Theme.of(this).textTheme.headlineMedium;

  TextStyle? get headlineSmall => Theme.of(this).textTheme.headlineSmall;

  TextStyle? get titleLarge => Theme.of(this).textTheme.titleLarge;

  TextStyle? get titleMedium => Theme.of(this).textTheme.titleMedium;

  TextStyle? get titleSmall => Theme.of(this).textTheme.titleSmall;

  TextStyle? get bodyLarge => Theme.of(this).textTheme.bodyLarge;

  TextStyle? get bodyMedium => Theme.of(this).textTheme.bodyMedium;

  TextStyle? get bodySmall => Theme.of(this).textTheme.bodySmall;

  TextStyle? get labelLarge => Theme.of(this).textTheme.labelLarge;

  TextStyle? get labelMedium => Theme.of(this).textTheme.labelMedium;

  TextStyle? get labelSmall => Theme.of(this).textTheme.labelSmall;
}
