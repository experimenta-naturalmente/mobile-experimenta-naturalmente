import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/tag.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';

class ExperienceRegistration {
  ExperienceCategory? category;
  String? name;
  String? description;
  Set<Tag>? tags;
  Map<WeekDay, List<(TimeOfDay, TimeOfDay)>> workingHours = {};

  ExperienceRegistration({
    this.category,
    this.name,
    this.description,
    this.tags,
  });
}
