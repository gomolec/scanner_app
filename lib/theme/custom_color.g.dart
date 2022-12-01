import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

const success = Color(0xFF008F5D);
const warning = Color(0xFFF68524);

CustomColors lightCustomColors = const CustomColors(
  sourceSuccess: Color(0xFF008F5D),
  success: Color(0xFF006C45),
  onSuccess: Color(0xFFFFFFFF),
  successContainer: Color(0xFF88F8BD),
  onSuccessContainer: Color(0xFF002112),
  sourceWarning: Color(0xFFF68524),
  warning: Color(0xFF954A00),
  onWarning: Color(0xFFFFFFFF),
  warningContainer: Color(0xFFFFDCC6),
  onWarningContainer: Color(0xFF301400),
);

CustomColors darkCustomColors = const CustomColors(
  sourceSuccess: Color(0xFF008F5D),
  success: Color(0xFF6BDBA2),
  onSuccess: Color(0xFF003822),
  successContainer: Color(0xFF005233),
  onSuccessContainer: Color(0xFF88F8BD),
  sourceWarning: Color(0xFFF68524),
  warning: Color(0xFFFFB785),
  onWarning: Color(0xFF502500),
  warningContainer: Color(0xFF713700),
  onWarningContainer: Color(0xFFFFDCC6),
);

/// Defines a set of custom colors, each comprised of 4 complementary tones.
///
/// See also:
///   * <https://m3.material.io/styles/color/the-color-system/custom-colors>
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.sourceSuccess,
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.sourceWarning,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
  });

  final Color? sourceSuccess;
  final Color? success;
  final Color? onSuccess;
  final Color? successContainer;
  final Color? onSuccessContainer;
  final Color? sourceWarning;
  final Color? warning;
  final Color? onWarning;
  final Color? warningContainer;
  final Color? onWarningContainer;

  @override
  CustomColors copyWith({
    Color? sourceSuccess,
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? onSuccessContainer,
    Color? sourceWarning,
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? onWarningContainer,
  }) {
    return CustomColors(
      sourceSuccess: sourceSuccess ?? this.sourceSuccess,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      successContainer: successContainer ?? this.successContainer,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
      sourceWarning: sourceWarning ?? this.sourceWarning,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      sourceSuccess: Color.lerp(sourceSuccess, other.sourceSuccess, t),
      success: Color.lerp(success, other.success, t),
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t),
      successContainer: Color.lerp(successContainer, other.successContainer, t),
      onSuccessContainer:
          Color.lerp(onSuccessContainer, other.onSuccessContainer, t),
      sourceWarning: Color.lerp(sourceWarning, other.sourceWarning, t),
      warning: Color.lerp(warning, other.warning, t),
      onWarning: Color.lerp(onWarning, other.onWarning, t),
      warningContainer: Color.lerp(warningContainer, other.warningContainer, t),
      onWarningContainer:
          Color.lerp(onWarningContainer, other.onWarningContainer, t),
    );
  }

  /// Returns an instance of [CustomColors] in which the following custom
  /// colors are harmonized with [dynamic]'s [ColorScheme.primary].
  ///   * [CustomColors.sourceSuccess]
  ///   * [CustomColors.success]
  ///   * [CustomColors.onSuccess]
  ///   * [CustomColors.successContainer]
  ///   * [CustomColors.onSuccessContainer]
  ///   * [CustomColors.sourceWarning]
  ///   * [CustomColors.warning]
  ///   * [CustomColors.onWarning]
  ///   * [CustomColors.warningContainer]
  ///   * [CustomColors.onWarningContainer]
  ///
  /// See also:
  ///   * <https://m3.material.io/styles/color/the-color-system/custom-colors#harmonization>
  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(
      sourceSuccess: sourceSuccess!.harmonizeWith(dynamic.primary),
      success: success!.harmonizeWith(dynamic.primary),
      onSuccess: onSuccess!.harmonizeWith(dynamic.primary),
      successContainer: successContainer!.harmonizeWith(dynamic.primary),
      onSuccessContainer: onSuccessContainer!.harmonizeWith(dynamic.primary),
      sourceWarning: sourceWarning!.harmonizeWith(dynamic.primary),
      warning: warning!.harmonizeWith(dynamic.primary),
      onWarning: onWarning!.harmonizeWith(dynamic.primary),
      warningContainer: warningContainer!.harmonizeWith(dynamic.primary),
      onWarningContainer: onWarningContainer!.harmonizeWith(dynamic.primary),
    );
  }
}
