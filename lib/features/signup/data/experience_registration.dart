import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/tag.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';
import 'package:turismo_rural_frontend/features/signup/data/attachment.dart';

class ExperienceRegistration {
  ExperienceCategory? category;
  String? name;
  String? description;
  String? eventDetails;
  String? fantasyName;
  String? email;
  String? phone;
  String? address;
  String? zipCode;
  String? number;
  String? cnpj;
  Set<Tag>? tags;
  DateTime? eventStart;
  DateTime? eventEnd;
  List<Tag> selectedTags = [];
  Map<WeekDay, List<(TimeOfDay, TimeOfDay)>> workingHours = {};
  List<Attachment> attachments = [];

  ExperienceRegistration({
    this.category,
    this.name,
    this.description,
    this.eventDetails,
    this.tags,
    this.eventStart,
    this.eventEnd,
    this.fantasyName,
    this.email,
    this.phone,
    this.address,
    this.zipCode,
    this.number,
    this.cnpj,
    this.selectedTags = const [],
    this.workingHours = const {},
    this.attachments = const [],
  });

  void clear() {
    category = null;
    name = null;
    description = null;
    eventDetails = null;
    fantasyName = null;
    email = null;
    phone = null;
    address = null;
    zipCode = null;
    number = null;
    cnpj = null;
    tags = null;
    eventStart = null;
    eventEnd = null;
    selectedTags = [];
    workingHours = {};
    attachments = [];
  }

  Map<String, dynamic> toJson() {
    return {
      if (category != null) 'category': category!.toJson(),
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (eventDetails != null) 'eventDetails': eventDetails,
      if (fantasyName != null) 'fantasyName': fantasyName,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (zipCode != null) 'zipCode': zipCode,
      if (number != null) 'number': number,
      if (cnpj != null) 'cnpj': cnpj,
      if (tags != null) 'tags': tags!.map((tag) => tag.toJson()).toList(),
      if (eventStart != null) 'eventStart': eventStart!.toIso8601String(),
      if (eventEnd != null) 'eventEnd': eventEnd!.toIso8601String(),
      'selectedTags': selectedTags.map((tag) => tag.toJson()).toList(),
      'workingHours': workingHours.map(
        (day, hours) => MapEntry(
          day.toString(),
          hours
              .map(
                (range) => {
                  'start': _formatTimeOfDay(range.$1),
                  'end': _formatTimeOfDay(range.$2),
                },
              )
              .toList(),
        ),
      ),
      'attachments': attachments.map((attachment) => attachment.url).toList(),
    };
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
