import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turismo_rural_frontend/core/data/models/event.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/spot.dart';
import 'package:turismo_rural_frontend/core/data/repositories/experience_repository.dart';

class FirestoreExperienceRepository implements ExperienceRepository {
  final FirebaseFirestore _firestore;

  FirestoreExperienceRepository(this._firestore);

  @override
  Future<Set<Event>> fetchEvents() async {
    final QuerySnapshot snapshot = await _firestore.collection('events').get();
    final Set<Event> events = {};
    for (final doc in snapshot.docs) {
      events.add(await ExperienceFirebaseExtensions.fromEventSnapshot(doc));
    }
    return events;
  }

  @override
  Future<Set<ExperienceCategory>> fetchExperienceCategories() async {
    final QuerySnapshot snapshot =
        await _firestore.collection('experience_categories').get();
    return snapshot.docs.map((doc) {
      return (doc.data()! as Map<String, dynamic>).toExperienceCategory();
    }).toSet();
  }

  @override
  Future<Set<Experience>> fetchExperiencesfromCategory(
    ExperienceCategory category,
  ) async {
    final Set<Event> events = await fetchEvents();
    final Set<Spot> spots = await fetchSpots();

    final Set<Experience> experiences = {...events, ...spots};

    return experiences;
  }

  @override
  Future<Set<Spot>> fetchSpots() async {
    final QuerySnapshot snapshot = await _firestore.collection('spots').get();
    final Set<Spot> spots = {};
    for (final doc in snapshot.docs) {
      spots.add(await ExperienceFirebaseExtensions.fromSpotSnapshot(doc));
    }
    return spots;
  }
}

extension ExperienceFirebaseExtensions on Experience {
  static Future<Event> fromEventSnapshot(DocumentSnapshot doc) async {
    if (doc.data() == null) {
      throw Exception('Document does not exist');
    }
    final Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    final int categoryId = int.tryParse(data['category_id'].toString()) ?? -1;
    final ExperienceCategory? category = await fetchCategoryById(
      int.tryParse(data['category_id'].toString()) ?? -1,
    );
    if (category == null) {
      throw Exception('Category id $categoryId does not exist');
    }
    return Event(
      about: data['about']?.toString() ?? 'Sem informações',
      id: int.tryParse(data['id'].toString()) ?? -1,
      name: data['name']?.toString() ?? 'Sem nome',
      description: data['description']?.toString() ?? 'Sem descrição',
      category: category,
    );
  }

  static Future<Spot> fromSpotSnapshot(DocumentSnapshot doc) async {
    if (doc.data() == null) {
      throw Exception('Document does not exist');
    }
    final Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
    final int categoryId = int.tryParse(data['category_id'].toString()) ?? -1;
    final ExperienceCategory? category = await fetchCategoryById(
      int.tryParse(data['category_id'].toString()) ?? -1,
    );
    if (category == null) {
      throw Exception('Category id $categoryId does not exist');
    }
    return Spot(
      openingHours:
          data['opening_hours']?.toString() ?? 'Sem horários de abertura',
      id: int.tryParse(data['id'].toString()) ?? -1,
      name: data['name']?.toString() ?? 'Sem nome',
      description: data['description']?.toString() ?? 'Sem descrição',
      category: category,
    );
  }
}

extension MapExperienceCategoryExtension on Map<String, dynamic> {
  ExperienceCategory toExperienceCategory() {
    if (!containsKey('id') || !containsKey('name')) {
      throw Exception('Required keys are missing in the data');
    }
    return ExperienceCategory(
      id: int.tryParse(this['id'].toString()) ?? -1,
      name: this['name'].toString(),
    );
  }
}

Future<ExperienceCategory?> fetchCategoryById(int categoryId) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final DocumentSnapshot doc = await firestore
      .collection('experience_categories')
      .doc('$categoryId')
      .get();

  if (!doc.exists) {
    return null;
  }

  final Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;

  return ExperienceCategory(
    id: int.tryParse(data['id'].toString()) ?? -1,
    name: data['name'].toString(),
  );
}
