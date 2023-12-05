import 'package:flutter/material.dart';

class TCardTheme {
  TCardTheme._();

  static CardTheme lightCardTheme = CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(
        color: Colors.grey,
        width: 0.5,
      ),
    ),
  );



  static CardTheme darkCardTheme = CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(
        color: Colors.grey,
        width: 0.5,
      ),
    ),
  );

}
