import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_tag_repository.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/tag.dart';

class TagRepository implements ITagRepository {
  final FirebaseFirestore firestore;
  final String tagsCollection = 'tags';

  TagRepository({required this.firestore});

  @override
  Future<Set<Tag>> fetchTagsFromCategory(ExperienceCategory category) async {
    final querySnapshot = await firestore
        .collection(tagsCollection)
        .where('categoryId', isEqualTo: category.id)
        .get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return Tag.fromJson(data);
    }).toSet();
  }
}
