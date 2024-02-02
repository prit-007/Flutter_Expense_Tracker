import 'package:flutter/widgets.dart';

class ResponsiveUtil {
  static double getNormalFont(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return 9 * (media.height + media.width) / (60 * 16); // Adjusted for slightly smaller normal font
  }

  static double getTitleFont(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return 9 * (media.height + media.width) / (10 * 27); // Increased for much larger title font
  }

  static double getSubTitleFont(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return 9 * (media.height + media.width) / (45 * 16);
  }

  static double getWidth(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return media.width;
  }

  static double getHeight(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return media.height; // Changed to use height for vertical adjustments
  }

  static EdgeInsets getPadding(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var responsivePadding = EdgeInsets.symmetric(
      horizontal: media.width * 0.05, // Increased horizontal padding
      vertical: media.height * 0.03,  // Increased vertical padding
    );
    return responsivePadding;
  }

  static EdgeInsets getMargin(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var responsiveMargin = EdgeInsets.all(media.width * 0.03); // Increased margin
    return responsiveMargin;
  }
}
