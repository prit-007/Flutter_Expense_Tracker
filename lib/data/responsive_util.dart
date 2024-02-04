
import 'package:flutter/widgets.dart';

class ResponsiveUtil {
  static double _baseFontSize = 12.0;
  static double _baseIconSize = 50.0;

  static double getNormalFont(BuildContext context) {
    var media = MediaQuery.of(context);
    var scaledFontSize = _baseFontSize * media.textScaler.scale(0.9);
    return scaledFontSize.clamp(10.0, 15.0); // Set min and max limits
  }

  static double getPageTitleFont(BuildContext context) {
    var media = MediaQuery.of(context);
    return 20.0 * media.textScaler.scale(1.0); // Invoke the scale function
  }

  static double getSubTitleFont(BuildContext context) {
    var media = MediaQuery.of(context);
    return 14.0 * media.textScaler.scale(1.0);
  }

  static double getHeadingTitleFont(BuildContext context) {
    var media = MediaQuery.of(context);
    return 40.0 * media.textScaler.scale(1.0);
  }

  static double getHeadingSubtitleFont(BuildContext context) {
    var media = MediaQuery.of(context);
    return 13.0 * media.textScaler.scale(1.0);
  }

  static double getIconSize(BuildContext context) {
    var media = MediaQuery.of(context);
    var scaledIconSize = _baseIconSize * media.size.width / 400; // Adjust as needed
    return scaledIconSize.clamp(30.0, 60.0); // Set min and max limits
  }

  static double getWidth(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return media.width;
  }

  static double getHeight(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return media.height;
  }

  static EdgeInsets getPadding(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var responsivePadding = EdgeInsets.symmetric(
      horizontal: media.width * 0.05,
      vertical: media.height * 0.03,
    );
    return responsivePadding;
  }

  static EdgeInsets getMargin(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var responsiveMargin = EdgeInsets.all(media.width * 0.03);
    return responsiveMargin;
  }

  static TextStyle getNormalFontStyle(BuildContext context) {
    return TextStyle(
      fontSize: getNormalFont(context),
      fontWeight: FontWeight.bold,
    );
  }
}
