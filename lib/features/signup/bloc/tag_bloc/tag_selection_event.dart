import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/features/experiences/data/model/tag.dart';

abstract class TagSelectionEvent extends Equatable {
  const TagSelectionEvent();

  @override
  List<Object?> get props => [];
}

class ToggleTagInitialization extends TagSelectionEvent {
  @override
  List<Object?> get props => [];
}

class ToggleTag extends TagSelectionEvent {
  final Tag tag;
  const ToggleTag(this.tag);

  @override
  List<Object?> get props => [tag];

  @override
  String toString() => 'ToggleTag { tag: $tag }';
}
