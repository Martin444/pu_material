import 'package:flutter/material.dart';

class PuStyleContainers {
  static BoxDecoration borderAllContainer = BoxDecoration(
    border: Border.all(
      width: 1,
      color: const Color(0xFFBCBCBC),
    ),
  );
  static BoxDecoration borderBottomContainer = const BoxDecoration(
    border: Border(
      bottom: BorderSide(
        width: 1,
        color: Color(0xFFBCBCBC),
      ),
    ),
  );
  static BoxDecoration borderLeftContainer = const BoxDecoration(
    border: Border(
      left: BorderSide(
        width: 1,
        color: Color(0xFFBCBCBC),
      ),
    ),
  );
}
