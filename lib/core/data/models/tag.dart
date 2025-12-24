import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/utils/common.dart';

class Tag extends Equatable {
  final String id;
  final String name;
  final List<ExperienceCategory> type;

  const Tag({
    required this.id,
    required this.name,
    required this.type,
  });

  @override
  List<Object?> get props => [name, type];

  factory Tag.fromJson(Map<String, dynamic> json) {
    final categoryJsonList = json['categories'] as List? ?? [];

    final List<ExperienceCategory> categoryList = categoryJsonList
        .map(
          (categoryJson) =>
              ExperienceCategory.fromJson(categoryJson as Map<String, dynamic>),
        )
        .toList();

    return Tag(
      id: json['id'] != null
          ? (json['id'] is int ? json['id'].toString() : json['id'] as String)
          : '',
      name: json['name'] != null ? decodeUtf8(json['name'] as String) : '',
      type: categoryList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'categories': type.map((category) => category.toJson()).toList(),
    };
  }
}
