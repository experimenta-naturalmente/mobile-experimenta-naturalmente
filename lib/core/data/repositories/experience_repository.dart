import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_experience_repository.dart';
import 'package:turismo_rural_frontend/core/data/models/event.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/spot.dart';
import 'package:turismo_rural_frontend/core/repositories_config.dart';
import 'package:turismo_rural_frontend/core/data/repositories/tag_repository.dart';
import 'package:turismo_rural_frontend/core/services/aws/aws.dart';

class ExperienceRepository implements IExperienceRepository {
  final FirebaseFirestore firestore;
  final TagRepository tagRepository;
  final AwsS3Service awsS3Service;
  final String experienceCollection = 'experiences';
  final String categoriesCollection = 'experienceCategories';

  ExperienceRepository({
    required this.firestore,
    required this.tagRepository,
    required this.awsS3Service,
  });

  @override
  Future<Set<Experience>> fetchExperiencesFromCategory(
    ExperienceCategory category,
  ) async {
    final querySnapshot = await firestore
        .collection(experienceCollection)
        .where('categoryId', isEqualTo: category.id)
        .get();

    final experiences = querySnapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return Experience.fromJson(data, category, const {});
    }).toSet();

    return experiences;
  }

  @override
  Future<Set<ExperienceCategory>> fetchExperienceCategories() async {
    final querySnapshot =
        await firestore.collection('experienceCategories').get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return ExperienceCategory.fromJson(data);
    }).toSet();
  }

  @override
  Future<Set<Experience>> fetchFeaturedExperiences() async {
    // Load categories first for proper mapping
    final categoriesSnapshot =
        await firestore.collection(categoriesCollection).get();
    final categories = categoriesSnapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return ExperienceCategory.fromJson(data);
    }).toSet();

    // Fetch experiences directly from Firestore instead of mocked HTTP
    final experiencesSnapshot =
        await firestore.collection(experienceCollection).get();

    final experiences = experiencesSnapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      final categoryId = data['categoryId']?.toString();
      final category = categories.firstWhere(
        (c) => c.id == categoryId,
        orElse: () => const ExperienceCategory(id: 'unknown', name: 'Unknown'),
      );
      return Experience.fromJson(data, category, const {});
    }).toSet();

    return experiences;
  }

  @override
  Future<Event?> fetchEventById(int eventId) async {
    final categoriesSet = await fetchExperienceCategories();
    final categoriesList = categoriesSet;
    categoriesList.removeWhere((element) => element.name != 'Evento');

    final response = await http.get(apiUri.replace(path: 'event/$eventId'));

    if (response.statusCode == 200) {
      final eventJson = jsonDecode(response.body) as Map<String, dynamic>;
      final category = categoriesList.isNotEmpty ? categoriesList.first : null;
      if (category != null) {
        return Event.fromJson(eventJson, category, const {});
      }
    }

    return null;
  }

  @override
  Future<Set<Spot>> fetchAllSpots() async {
    final categoriesSet = await fetchExperienceCategories();
    categoriesSet.removeWhere((element) => element.name == 'Evento');

    final response = await http.get(apiUri.replace(path: 'spot'));

    if (response.statusCode == 200) {
      final List<dynamic> spotsJson =
          jsonDecode(response.body) as List<dynamic>;

      final spots = spotsJson
          .map(
            (json) =>
                Spot.fromJson(json as Map<String, dynamic>, categoriesSet),
          )
          .toSet();

      return spots;
    } else {
      throw Exception('Failed to load spots');
    }
  }

  @override
  Future<Set<Spot>> fetchSpotsByProfileId(int profileId) async {
    final response = await http.get(
      apiUri
          .replace(path: 'spot', queryParameters: {'profileId': '$profileId'}),
    );

    if (response.statusCode == 200) {
      final List<dynamic> spotsJson =
          jsonDecode(response.body) as List<dynamic>;
      final spots = spotsJson
          .map((json) => Spot.fromJsonProfile(json as Map<String, dynamic>))
          .toSet();

      return spots;
    } else if (response.statusCode == 404) {
      return {};
    } else {
      throw Exception('Failed to load spots');
    }
  }

  @override
  Future<Set<Event>> fetchEvents() async {
    final categoriesSet = await fetchExperienceCategories();

    final response = await http.get(apiUri.replace(path: 'event'));

    if (response.statusCode == 200) {
      final List<dynamic> eventsJson =
          jsonDecode(response.body) as List<dynamic>;
      final events = eventsJson.map(
        (json) {
          final category = categoriesSet.firstWhere(
            (cat) => cat.name == 'Evento',
            orElse: () => categoriesSet.first,
          );
          return Event.fromJson(
              json as Map<String, dynamic>, category, const {});
        },
      );
      return events.toSet();
    }
    return {};
  }

  @override
  Future<Spot?> fetchExperienceById(String id) async {
    final doc = await firestore.collection(experienceCollection).doc(id).get();

    if (doc.exists) {
      final data = doc.data()!;
      final categoryId = data['categoryId']?.toString() ?? '';
      final experienceCategoryData = await firestore
          .collection(categoriesCollection)
          .doc(categoryId)
          .get();
      final ExperienceCategory category;
      if (experienceCategoryData.exists) {
        final categoryData = experienceCategoryData.data()!;
        categoryData['id'] = experienceCategoryData.id;
        category = ExperienceCategory.fromJson(categoryData);
      } else {
        category = const ExperienceCategory(id: '0', name: 'Unknown');
      }
      data['id'] = doc.id;
      return Spot.fromJsonCategorized(data, category);
    }
    return null;
  }

  @override
  Future<String?> uploadImage(XFile file, Function(int) onProgress) {
    final upload =
        awsS3Service.uploadImageToS3(file: file, onProgress: onProgress);
    return upload;
  }
}
