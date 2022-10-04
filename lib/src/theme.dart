import 'package:flutter/material.dart';

/// The primary color for light theme, used for body text and the headline
const primary = Colors.black;

/// The primary color for dark theme, used for body text and the headline
const primaryDark = Colors.white;

/// The system blue color for light theme, used for links and button text
const systemBlue = Color(0xFF007AFF);

/// The system blue color for dark theme, used for links and button text
const systemBlueDark = Color(0xFF0A84FF);

/// The system red color for light theme, never used
const systemRed = Color(0xFFFF3B30);

/// The system red color for dark theme, never used
const systemRedDark = Color(0xFFFF453A);

/// The primary fill for light theme (#787880 20%)
const primaryFill = Color.fromARGB(20, 120, 120, 128);

/// The primary fill for dark theme (#787880 36%)
const primaryFillDark = Color.fromARGB(36, 120, 120, 128);

/// The system background color for light theme
const systemBackground = Colors.white;

/// The system background color for dark theme
const systemBackgroundDark = Colors.black;

/// The secondary system background color for light theme, used in buttons
const secondarySystemBackground = Color(0xFFF2F2F7);

/// The secondary system background color for dark theme, used in buttons
const secondarySystemBackgroundDark = Color(0xFF2C2C2E);

/// The default button style
const buttonStyle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: systemBlue,
    height: 22 / 17);

/// The default button style for dark theme
const buttonStyleDark = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: systemBlueDark,
    height: 22 / 17);

/// The default title style
const titleStyle = TextStyle(
  fontSize: 34,
  fontWeight: FontWeight.bold,
  color: primary,
  height: 41 / 34,
);

/// The default title style for dark theme
const titleStyleDark = TextStyle(
  fontSize: 34,
  fontWeight: FontWeight.bold,
  color: primaryDark,
  height: 41 / 34,
);

/// The default body style
const bodyStyle = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.normal,
  color: primary,
  height: 22 / 17,
);

/// The default body style for dark theme
const bodyStyleDark = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.normal,
  color: primaryDark,
  height: 22 / 17,
);
