import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

const warningcolor = Color(0xFFE6A03A);
const successcolor = Color(0xFF459B64);
const errorcolor = Color(0xFFE0002B);


CustomColors lightCustomColors = const CustomColors(
  sourceWarningcolor: Color(0xFFE6A03A),
  warningcolor: Color(0xFF845400),
  onWarningcolor: Color(0xFFFFFFFF),
  warningcolorContainer: Color(0xFFFFDDB6),
  onWarningcolorContainer: Color(0xFF2A1800),
  sourceSuccesscolor: Color(0xFF459B64),
  successcolor: Color(0xFF006D3A),
  onSuccesscolor: Color(0xFFFFFFFF),
  successcolorContainer: Color(0xFF99F6B4),
  onSuccesscolorContainer: Color(0xFF00210E),
  sourceErrorcolor: Color(0xFFE0002B),
  errorcolor: Color(0xFFBF0023),
  onErrorcolor: Color(0xFFFFFFFF),
  errorcolorContainer: Color(0xFFFFDAD7),
  onErrorcolorContainer: Color(0xFF410006),
);

CustomColors darkCustomColors = const CustomColors(
  sourceWarningcolor: Color(0xFFE6A03A),
  warningcolor: Color(0xFFFFB959),
  onWarningcolor: Color(0xFF462B00),
  warningcolorContainer: Color(0xFF643F00),
  onWarningcolorContainer: Color(0xFFFFDDB6),
  sourceSuccesscolor: Color(0xFF459B64),
  successcolor: Color(0xFF7EDA9A),
  onSuccesscolor: Color(0xFF00391C),
  successcolorContainer: Color(0xFF00522A),
  onSuccesscolorContainer: Color(0xFF99F6B4),
  sourceErrorcolor: Color(0xFFE0002B),
  errorcolor: Color(0xFFFFB3AF),
  onErrorcolor: Color(0xFF68000E),
  errorcolorContainer: Color(0xFF930018),
  onErrorcolorContainer: Color(0xFFFFDAD7),
);



/// Defines a set of custom colors, each comprised of 4 complementary tones.
///
/// See also:
///   * <https://m3.material.io/styles/color/the-color-system/custom-colors>
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.sourceWarningcolor,
    required this.warningcolor,
    required this.onWarningcolor,
    required this.warningcolorContainer,
    required this.onWarningcolorContainer,
    required this.sourceSuccesscolor,
    required this.successcolor,
    required this.onSuccesscolor,
    required this.successcolorContainer,
    required this.onSuccesscolorContainer,
    required this.sourceErrorcolor,
    required this.errorcolor,
    required this.onErrorcolor,
    required this.errorcolorContainer,
    required this.onErrorcolorContainer,
  });

  final Color? sourceWarningcolor;
  final Color? warningcolor;
  final Color? onWarningcolor;
  final Color? warningcolorContainer;
  final Color? onWarningcolorContainer;
  final Color? sourceSuccesscolor;
  final Color? successcolor;
  final Color? onSuccesscolor;
  final Color? successcolorContainer;
  final Color? onSuccesscolorContainer;
  final Color? sourceErrorcolor;
  final Color? errorcolor;
  final Color? onErrorcolor;
  final Color? errorcolorContainer;
  final Color? onErrorcolorContainer;

  @override
  CustomColors copyWith({
    Color? sourceWarningcolor,
    Color? warningcolor,
    Color? onWarningcolor,
    Color? warningcolorContainer,
    Color? onWarningcolorContainer,
    Color? sourceSuccesscolor,
    Color? successcolor,
    Color? onSuccesscolor,
    Color? successcolorContainer,
    Color? onSuccesscolorContainer,
    Color? sourceErrorcolor,
    Color? errorcolor,
    Color? onErrorcolor,
    Color? errorcolorContainer,
    Color? onErrorcolorContainer,
  }) {
    return CustomColors(
      sourceWarningcolor: sourceWarningcolor ?? this.sourceWarningcolor,
      warningcolor: warningcolor ?? this.warningcolor,
      onWarningcolor: onWarningcolor ?? this.onWarningcolor,
      warningcolorContainer: warningcolorContainer ?? this.warningcolorContainer,
      onWarningcolorContainer: onWarningcolorContainer ?? this.onWarningcolorContainer,
      sourceSuccesscolor: sourceSuccesscolor ?? this.sourceSuccesscolor,
      successcolor: successcolor ?? this.successcolor,
      onSuccesscolor: onSuccesscolor ?? this.onSuccesscolor,
      successcolorContainer: successcolorContainer ?? this.successcolorContainer,
      onSuccesscolorContainer: onSuccesscolorContainer ?? this.onSuccesscolorContainer,
      sourceErrorcolor: sourceErrorcolor ?? this.sourceErrorcolor,
      errorcolor: errorcolor ?? this.errorcolor,
      onErrorcolor: onErrorcolor ?? this.onErrorcolor,
      errorcolorContainer: errorcolorContainer ?? this.errorcolorContainer,
      onErrorcolorContainer: onErrorcolorContainer ?? this.onErrorcolorContainer,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      sourceWarningcolor: Color.lerp(sourceWarningcolor, other.sourceWarningcolor, t),
      warningcolor: Color.lerp(warningcolor, other.warningcolor, t),
      onWarningcolor: Color.lerp(onWarningcolor, other.onWarningcolor, t),
      warningcolorContainer: Color.lerp(warningcolorContainer, other.warningcolorContainer, t),
      onWarningcolorContainer: Color.lerp(onWarningcolorContainer, other.onWarningcolorContainer, t),
      sourceSuccesscolor: Color.lerp(sourceSuccesscolor, other.sourceSuccesscolor, t),
      successcolor: Color.lerp(successcolor, other.successcolor, t),
      onSuccesscolor: Color.lerp(onSuccesscolor, other.onSuccesscolor, t),
      successcolorContainer: Color.lerp(successcolorContainer, other.successcolorContainer, t),
      onSuccesscolorContainer: Color.lerp(onSuccesscolorContainer, other.onSuccesscolorContainer, t),
      sourceErrorcolor: Color.lerp(sourceErrorcolor, other.sourceErrorcolor, t),
      errorcolor: Color.lerp(errorcolor, other.errorcolor, t),
      onErrorcolor: Color.lerp(onErrorcolor, other.onErrorcolor, t),
      errorcolorContainer: Color.lerp(errorcolorContainer, other.errorcolorContainer, t),
      onErrorcolorContainer: Color.lerp(onErrorcolorContainer, other.onErrorcolorContainer, t),
    );
  }

  /// Returns an instance of [CustomColors] in which the following custom
  /// colors are harmonized with [dynamic]'s [ColorScheme.primary].
  ///   * [CustomColors.sourceWarningcolor]
  ///   * [CustomColors.warningcolor]
  ///   * [CustomColors.onWarningcolor]
  ///   * [CustomColors.warningcolorContainer]
  ///   * [CustomColors.onWarningcolorContainer]
  ///   * [CustomColors.sourceSuccesscolor]
  ///   * [CustomColors.successcolor]
  ///   * [CustomColors.onSuccesscolor]
  ///   * [CustomColors.successcolorContainer]
  ///   * [CustomColors.onSuccesscolorContainer]
  ///   * [CustomColors.sourceErrorcolor]
  ///   * [CustomColors.errorcolor]
  ///   * [CustomColors.onErrorcolor]
  ///   * [CustomColors.errorcolorContainer]
  ///   * [CustomColors.onErrorcolorContainer]
  ///
  /// See also:
  ///   * <https://m3.material.io/styles/color/the-color-system/custom-colors#harmonization>
  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(
      sourceWarningcolor: sourceWarningcolor!.harmonizeWith(dynamic.primary),
      warningcolor: warningcolor!.harmonizeWith(dynamic.primary),
      onWarningcolor: onWarningcolor!.harmonizeWith(dynamic.primary),
      warningcolorContainer: warningcolorContainer!.harmonizeWith(dynamic.primary),
      onWarningcolorContainer: onWarningcolorContainer!.harmonizeWith(dynamic.primary),
      sourceSuccesscolor: sourceSuccesscolor!.harmonizeWith(dynamic.primary),
      successcolor: successcolor!.harmonizeWith(dynamic.primary),
      onSuccesscolor: onSuccesscolor!.harmonizeWith(dynamic.primary),
      successcolorContainer: successcolorContainer!.harmonizeWith(dynamic.primary),
      onSuccesscolorContainer: onSuccesscolorContainer!.harmonizeWith(dynamic.primary),
      sourceErrorcolor: sourceErrorcolor!.harmonizeWith(dynamic.primary),
      errorcolor: errorcolor!.harmonizeWith(dynamic.primary),
      onErrorcolor: onErrorcolor!.harmonizeWith(dynamic.primary),
      errorcolorContainer: errorcolorContainer!.harmonizeWith(dynamic.primary),
      onErrorcolorContainer: onErrorcolorContainer!.harmonizeWith(dynamic.primary),
    );
  }
}