import 'package:turismo_rural_frontend/core/data/models/address.dart';
import 'package:turismo_rural_frontend/core/data/models/attachment.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/social_networks.dart';
import 'package:turismo_rural_frontend/core/data/models/tag.dart';
import 'package:turismo_rural_frontend/core/utils/common.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';

class Event extends Experience {
  final String details;
  final String eventStart;
  final String eventEnd;

  const Event({
    required this.details,
    required this.eventStart,
    required this.eventEnd,
    required super.id,
    required super.type,
    required super.cnpj,
    required super.name,
    required super.email,
    required super.phone,
    required super.description,
    required super.category,
    required super.socialNetworks,
    required super.tags,
    required super.attachments,
    required super.address,
  });

  factory Event.fromJson(
    Map<String, dynamic> json,
    ExperienceCategory category,
    Set<Tag> tags,
  ) {
    return Event(
      details: decodeUtf8(json['details'] as String),
      eventStart: json['eventStart'] as String,
      eventEnd: json['eventEnd'] as String,
      id: json['id'] as String,
      type: ExperienceType.event,
      cnpj: json['cnpj'] as String,
      name: decodeUtf8(json['name'] as String),
      email: json['email'] as String,
      phone: json['phone'] as String,
      description: decodeUtf8(json['description'] as String),
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      category: category,
      socialNetworks: json['socialNetworks'] != null
          ? SocialNetworks.fromJson(
              json['socialNetworks'] as Map<String, dynamic>)
          : null,
      tags: tags,
      attachments: (json['attachments'] as List<dynamic>)
          .map(
            (attachment) =>
                Attachment.fromJson(attachment as Map<String, dynamic>),
          )
          .toSet(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        type,
        cnpj,
        name,
        email,
        phone,
        description,
        address,
        category,
        socialNetworks,
        tags,
        attachments,
        details,
        eventStart,
        eventEnd,
      ];
}
