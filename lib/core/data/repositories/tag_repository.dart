import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:turismo_rural_frontend/core/data/interfaces/i_tag_repository.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/tag.dart';

class TagRepository implements ITagRepository {
  Uri apiUri;

  TagRepository({required this.apiUri});

  @override
  Future<Set<Tag>> fetchAllTags() async {
    final response = await http.get(apiUri.replace(path: 'tag'));

    if (response.statusCode == 200) {
      final List<dynamic> tags = json.decode(response.body) as List<dynamic>;
      return tags
          .map(
            (json) => Tag.fromJson(json as Map<String, dynamic>),
          )
          .toSet();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Future<Set<Tag>> fetchTagsFromCategory(ExperienceCategory category) async {
    final response = await http
        .get(apiUri.replace(path: 'category/${category.categoryId}/tags'));

    if (response.statusCode == 200) {
      final List<dynamic> tags = json.decode(response.body) as List<dynamic>;
      return tags
          .map(
            (json) => Tag.fromJson(json as Map<String, dynamic>),
          )
          .toSet();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
