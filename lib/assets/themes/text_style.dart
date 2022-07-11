import 'package:flutter/painting.dart';
import 'package:kartograph/assets/colors/colors.dart';

//ignore_for_file: public_member_api_docs

/// Styles of texts.

// const TextStyle _text = TextStyle(
//   fontStyle: FontStyle.normal,
//   color: ProjectColors.textColorPrimary,
// );

// //Light
// TextStyle textLight = _text.copyWith(fontWeight: FontWeight.w300);
//
// //Regular
// TextStyle textRegular = _text.copyWith(fontWeight: FontWeight.normal);
// TextStyle textRegular16 = textRegular.copyWith(fontSize: 16.0);
// TextStyle textRegular16Secondary =
//     textRegular16.copyWith(color: ProjectColors.textColorSecondary);
// TextStyle textRegular16Grey = textRegular16.copyWith(color: ProjectColors.textColorGrey);
//
// //Medium
// TextStyle textMedium = _text.copyWith(fontWeight: FontWeight.w500);
// TextStyle textMedium20 = textMedium.copyWith(fontSize: 20.0);
//
// //Bold
// TextStyle textBold = _text.copyWith(fontWeight: FontWeight.bold);

/// Strings of Kartograph project
abstract class ProjectTextStyle {
  static const TextStyle _text = TextStyle(
    fontStyle: FontStyle.normal,
    color: ProjectColors.lightTextColorPrimary,
  );

//Light
  static TextStyle textLight = _text.copyWith(fontWeight: FontWeight.w300);

//Regular
  static TextStyle textRegular = _text.copyWith(fontWeight: FontWeight.normal);
  static TextStyle textRegular16 = textRegular.copyWith(fontSize: 16.0);
  static TextStyle textRegular16Secondary =
      textRegular16.copyWith(color: ProjectColors.textColorSecondary);
  static TextStyle textRegular16Grey =
      textRegular16.copyWith(color: ProjectColors.textColorGrey);

//Medium
  static TextStyle textMedium = _text.copyWith(fontWeight: FontWeight.w500);
  static TextStyle textMedium20 = textMedium.copyWith(fontSize: 20.0);

//Bold
  static TextStyle textBold = _text.copyWith(fontWeight: FontWeight.bold);
}
