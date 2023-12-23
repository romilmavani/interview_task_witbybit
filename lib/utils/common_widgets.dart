import 'dart:ffi';

import 'package:flutter/material.dart';

commonContainerDecoration({
  // String? image,
  Color color = Colors.white,
  Color borderColor = Colors.transparent,
  double? borderRadius,
  DecorationImage? image,
}) {
  return BoxDecoration(
    color: color,
    border: Border.all(
      color: borderColor,
    ),
    borderRadius: BorderRadius.circular(borderRadius ?? 10),
    image: image,
  );
}
