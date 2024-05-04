import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/core/data/models/tag.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class LoadSignUp extends SignUpEvent {}

class SignUpAttachmentUpload extends SignUpEvent {
  final dynamic file;

  const SignUpAttachmentUpload(this.file);
}

class SignUpChangePage extends SignUpEvent {
  final bool previous;

  const SignUpChangePage({this.previous = false});
}

class SignUpToggleTag extends SignUpEvent {
  final Tag tag;
  final Map<int, bool> selectedTags;
  const SignUpToggleTag(this.tag, this.selectedTags);

  @override
  List<Object?> get props => [tag];

  @override
  String toString() => 'ToggleTag { tag: $tag }';
}

class SignUpChangeWorkingHours extends SignUpEvent {
  final WeekDay day;
  final List<(TimeOfDay, TimeOfDay)> workingHours;

  const SignUpChangeWorkingHours({
    required this.day,
    required this.workingHours,
  });
}
