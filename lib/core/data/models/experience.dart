import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/core/data/models/attachment.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/tag.dart';

abstract class Experience extends Equatable {
  final int id;
  final String cnpj;
  final String name;
  final String email;
  final String phone;
  final String description;
  final ExperienceCategory category;
  final List<String> socialNetworks;
  final Set<Tag> tags;
  final Set<Attachment> attachments;

  const Experience({
    required this.id,
    required this.cnpj,
    required this.name,
    required this.email,
    required this.phone,
    required this.description,
    required this.category,
    required this.socialNetworks,
    required this.tags,
    required this.attachments,
  });
}
