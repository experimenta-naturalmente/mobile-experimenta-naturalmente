import 'dart:ui';

abstract class ColorEvent {}

class ChangeColor extends ColorEvent {
  final String text;
  final Color color;

  ChangeColor(this.text, this.color);
}
