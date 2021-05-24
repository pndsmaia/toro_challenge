import 'package:flutter/material.dart';

class MQuery {
  static late BuildContext _context;
  static late DefaultValue _defaultValues;
  // Default Values that is used in calculate base
  static late MediaQueryData _mediaQuery;

  static void configure(BuildContext context,
      {DefaultValue? defaultPortrait, DefaultValue? defaultLandscape}) {
    _context = context;
    _mediaQuery = MediaQuery.of(_context);

    _setDefaultValue();
  }

  // Used to pass
  static double heightPercent(
    double percent, {
    double? max, // Pixel Value
    double? min, // Pixel Value
  }) {
    percent /= 100;
    double result = _mediaQuery.size.height * percent;
    return result.clamp(min ?? result, max ?? result);
  }

  static double height(
    double height, {
    // Pixel Value
    double? max, // Pixel Value
    double? min, // Pixel Value
  }) {
    double percent = (((height * 100) / _defaultValues.height) / 100);
    return (percent * _mediaQuery.size.height)
        .clamp(min ?? height, max ?? height);
  }

  static double widthPercent(
    double percent, {
    double? max, // Pixel Value
    double? min, // Pixel Value
  }) {
    percent /= 100;
    double result = _mediaQuery.size.width * percent;
    return result.clamp(min ?? result, max ?? result);
  }

  static double width(
    double width, {
    // Pixel Value
    double? max, // Pixel Value
    double? min, // Pixel Value
  }) {
    // print('W: ${_mediaQuery.size.width} | H: ${_mediaQuery.size.height}');
    double percent = (((width * 100) / _defaultValues.width) / 100);
    return (percent * _mediaQuery.size.width).clamp(min ?? width, max ?? width);
  }

  static double textScale(double value, {double? max, double? min}) {
    return (_mediaQuery.textScaleFactor * value)
        .clamp(min ?? value, max ?? value);
  }

  static double text(
    double fontSize, {
    bool textScale = true,
    double? max,
    double? min,
  }) {
    double percentWidth = (((getWidth * 100) / _defaultValues.width) / 100);
    double percentHeight = (((getHeight * 100) / _defaultValues.height) / 100);

    double fontSizeBasedWidth = fontSize * percentWidth;
    double fontSizeBasedHeight = fontSize * percentHeight;

    if (fontSizeBasedWidth > fontSizeBasedHeight) {
      fontSize = fontSizeBasedHeight;
    } else {
      fontSize = fontSizeBasedWidth;
    }

    if (fontSize < (max ?? fontSize) && fontSize > (min ?? fontSize)) {
      if (textScale)
        return (fontSize * _mediaQuery.textScaleFactor)
            .clamp(min ?? fontSize, max ?? fontSize);
      return fontSize;
    } else if (fontSize < (min ?? fontSize)) {
      return (min ?? fontSize);
    } else {
      return (max ?? fontSize);
    }
  }

  static double get aspectRatio => _mediaQuery.devicePixelRatio;

  static double get getWidth => _mediaQuery.size.width;

  static double get getHeight => _mediaQuery.size.height;

  static double avaliableHeight(double appBarHeight) {
    double height = getHeight;
    double percentHeight =
        ((100 * (height - appBarHeight - _mediaQuery.padding.top)) / height) /
            100;
    double result = height * percentHeight;
    return result;
  }

  static bool get isPortrait {
    if (_mediaQuery.size.width >= _mediaQuery.size.height) return false;
    return true;
  }

  static bool get isLandscape {
    if (_mediaQuery.size.width >= _mediaQuery.size.height) return true;
    return false;
  }

  static void _setDefaultValue(
      {DefaultValue? defaultPortrait, DefaultValue? defaultLandscape}) {
    if (_mediaQuery.size.width >= _mediaQuery.size.height) {
      _defaultValues = defaultLandscape != null
          ? defaultLandscape
          : DefaultValue(height: 1024, width: 1440, fontSize: 12);
    } else {
      _defaultValues = defaultPortrait != null
          ? defaultPortrait
          : DefaultValue(height: 568, width: 320, fontSize: 12);
    }
  }
}

class DefaultValue {
  final double height;
  final double width;
  final double fontSize;

  DefaultValue({
    required this.fontSize,
    required this.height,
    required this.width,
  });
}
