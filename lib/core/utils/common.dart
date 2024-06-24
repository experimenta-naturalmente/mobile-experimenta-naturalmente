import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';


String decodeUtf8(String input) {
  try {
    return utf8.decode(input.codeUnits);
  } catch (e) {
    return input;
  }
}

Icon iconFromCategory({
  required ExperienceCategory experienceCategory,
  Color? color,
  double? size,
}) {
  switch (experienceCategory.name.toLowerCase()) {
    case 'evento':
      return Icon(Elusive.star_empty, color: color, size: size);
    case 'atração turística':
      return Icon(FontAwesome5.landmark, color: color, size: size);
    case 'restaurante':
      return Icon(Icons.restaurant, color: color, size: size);
    case 'hotel':
      return Icon(FontAwesome5.hotel, color: color, size: size);
    case 'produtor rural':
      return Icon(FontAwesome5.seedling, color: color, size: size);
    default:
      return Icon(Icons.help, color: color, size: size);
  }
}
