import 'package:flutter/material.dart';

final ButtonStyle buttonAlphabet = ElevatedButton.styleFrom(
  minimumSize: Size(10, 10),
  backgroundColor: Colors.grey,
  elevation: 0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
  )
);