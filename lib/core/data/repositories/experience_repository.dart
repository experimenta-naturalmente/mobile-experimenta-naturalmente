import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_experience_repository.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/spot.dart';
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
    final categoriesSnapshot =
        await firestore.collection(categoriesCollection).get();
    final categories = categoriesSnapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return ExperienceCategory.fromJson(data);
    }).toSet();

    final experiencesSnapshot =
        await firestore.collection(experienceCollection).get();
    final experiences = experiencesSnapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      final category = categories.firstWhere(
        (category) => category.id == data['categoryId'],
        orElse: () => const ExperienceCategory(id: '0', name: 'Unknown'),
      );
      return Experience.fromJson(data, category, const {});
    }).toSet();

    return experiences;
  }

  @override
  Future<Spot?> fetchExperienceById(String id) async {
    final doc = await firestore.collection(experienceCollection).doc(id).get();

    if (doc.exists) {
      final data = doc.data()!;
      final categoryId = data['categoryId'] as String;
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
      return Spot.fromJson(data, category, const {});
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
