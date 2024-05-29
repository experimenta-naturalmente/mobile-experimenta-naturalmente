import 'package:flutter/material.dart';

TextStyle getTagTextStyle(String tagName, BuildContext context) {
  if (tagName.length < 10) {
    return Theme.of(context).textTheme.labelLarge!;
  } else if (tagName.length < 20) {
    return Theme.of(context).textTheme.labelMedium!;
  } else {
    return Theme.of(context).textTheme.labelSmall!;
  }
}
